from flask import Flask, render_template, request, redirect, url_for, flash, session
from werkzeug.security import generate_password_hash, check_password_hash
from better_profanity import profanity
import os
import inspect
from dotenv import load_dotenv
from config import config_by_name 

from services.db_services import (
    get_all_movies, 
    get_movie_by_id, 
    get_total_movie_count, 
    get_unique_genres,
    add_user,
    get_user_by_username,
    add_review,
    get_reviews_by_movie_id,
    delete_review_by_id
)
from services.ai_services import generate_movie_sentiment

load_dotenv()

profanity.load_censor_words()

app = Flask(__name__)

# Determine the environment from system variables, defaulting to 'development'
env_name = os.getenv('FLASK_ENV', 'development')
app.config.from_object(config_by_name[env_name])
app.secret_key = os.getenv('SECRET_KEY', 'dev_secret_key') 

@app.route('/')
def index():
    """Main Catalog Dashboard View."""
    search_query = request.args.get('search', '').strip()
    selected_genre = request.args.get('genre', '').strip()
    
    try:
        current_page = int(request.args.get('page', 1))
    except ValueError:
        current_page = 1

    per_page = 8  # Show 8 movie cards per page in the main grid

    # 1. Fetch paginated data for the Main Grid
    catalog_movies, total_count = get_all_movies(
        search=search_query, 
        genre=selected_genre, 
        page=current_page, 
        per_page=per_page
    )
    
    # 2. Fetch broader list for Carousel and Sidebar
    all_movies, _ = get_all_movies(per_page=100)
    
    featured_movies = all_movies[:3] if all_movies else []
    top_movies = sorted(all_movies, key=lambda x: float(x.get('rating') or 0), reverse=True)[:5]
    genres = get_unique_genres()

    total_pages = (total_count + per_page - 1) // per_page if total_count > 0 else 1

    return render_template(
        'index.html',
        featured_movies=featured_movies,
        movies=catalog_movies,
        top_movies=top_movies,
        genres=genres,
        search_query=search_query,
        selected_genre=selected_genre,
        current_page=current_page,
        total_pages=total_pages
    )


@app.route('/movie/<int:movie_id>')
def movie_detail(movie_id):
    """Individual Movie Detail View."""
    movie = get_movie_by_id(movie_id)
    if not movie:
        return redirect(url_for('index'))

    ai_analysis = generate_movie_sentiment(
        title=movie['title'],
        director=movie.get('director'),
        genre=movie.get('genre'),
        release_year=movie.get('release_year')
    )

    reviews = get_reviews_by_movie_id(movie_id)

    return render_template(
        'movie_detail.html', 
        movie=movie, 
        ai_analysis=ai_analysis,
        reviews=reviews,
        get_user_by_username=get_user_by_username
    )


@app.route('/movie/<int:movie_id>/review', methods=['POST'])
def submit_review(movie_id):
    """Handle adding a review for a movie."""
    user_id = session.get('user_id')
    
    if not user_id:
        flash("You must be logged in to leave a review.", "error")
        return redirect(url_for('login'))
        
    rating_raw = request.form.get('rating')
    comment_raw = request.form.get('comment', '').strip()
    
    if not rating_raw or not comment_raw:
        flash("Rating and comment are required.", "error")
        return redirect(url_for('movie_detail', movie_id=movie_id))

    try:
        rating = int(rating_raw)
        if rating < 1 or rating > 10:
            raise ValueError()
    except ValueError:
        flash("Rating must be a valid number between 1 and 10.", "error")
        return redirect(url_for('movie_detail', movie_id=movie_id))

    clean_comment = profanity.censor(comment_raw)

    success, err_msg = add_review(
        movie_id=int(movie_id), 
        user_id=int(user_id), 
        rating=rating, 
        comment=clean_comment
    )
    
    if success:
        flash("Review submitted successfully!", "success")
    else:
        flash(f"Database Error: {err_msg}", "error")
        
    return redirect(url_for('movie_detail', movie_id=movie_id))


@app.route('/review/<int:review_id>/delete', methods=['POST'])
def delete_review(review_id):
    """Handle deleting a review (Admin only)."""
    if not session.get('user_id'):
        flash("You must be logged in.", "error")
        return redirect(url_for('login'))
    
    user = get_user_by_username(session.get('username'))
    if not user or not user.get('is_admin'):
        flash("Unauthorized action.", "error")
        return redirect(url_for('index'))
        
    success = delete_review_by_id(review_id)
    if success:
        flash("Review deleted successfully.", "success")
    else:
        flash("Failed to delete review.", "error")
        
    return redirect(request.referrer or url_for('index'))


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    """Handle user registration."""
    if request.method == 'POST':
        username = request.form.get('username', '').strip()
        email = request.form.get('email', '').strip()
        password = request.form.get('password')
        
        if not username or not password:
            flash("Username and password are required.", "error")
            return render_template('signup.html')
            
        # 1. Inappropriate Username Filter Check
        if profanity.contains_profanity(username):
            flash("That username contains inappropriate language. Please choose another.", "error")
            return render_template('signup.html')
            
        # 2. Length Check
        if len(username) < 3 or len(username) > 20:
            flash("Username must be between 3 and 20 characters.", "error")
            return render_template('signup.html')
            
        hashed_password = generate_password_hash(password)
        
        # 3. Call add_user dynamically checking if email parameter is supported
        sig = inspect.signature(add_user)
        try:
            if 'email' in sig.parameters:
                user_created = add_user(username, hashed_password, email=email)
            else:
                user_created = add_user(username, hashed_password)
        except Exception as e:
            user_created = False
            print(f"Error calling add_user: {e}")

        if user_created:
            flash("Account created successfully! Please log in.", "success")
            return redirect(url_for('login'))
        else:
            flash("Could not create account. Username or email may already exist.", "error")
            return render_template('signup.html')
            
    return render_template('signup.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    """Handle user login."""
    if request.method == 'POST':
        username = request.form.get('username', '').strip()
        password = request.form.get('password')
        
        user = get_user_by_username(username)
        
        # Flexibly handle password column naming ('password_hash' or 'password')
        stored_hash = user.get('password_hash') or user.get('password') if user else None

        if user and stored_hash and check_password_hash(stored_hash, password):
            session['user_id'] = user['id']
            session['username'] = user['username']
            flash("Successfully logged in!", "success")
            return redirect(url_for('index'))
        else:
            flash("Invalid username or password.", "error")
            return render_template('login.html')
            
    return render_template('login.html')


@app.route('/logout')
def logout():
    """Handle user logout."""
    session.clear()
    flash("You have been logged out.", "success")
    return redirect(url_for('index'))


@app.route('/dashboard')
def dashboard():
    """System analytics and controls console."""
    total_movies = get_total_movie_count()
    recent_movies, _ = get_all_movies(page=1, per_page=5)

    return render_template(
        'movie_dashboard.html',
        total_movies=total_movies,
        movies=recent_movies
    )


@app.errorhandler(404)
def page_not_found(e):
    return render_template('index.html', movies=[], featured_movies=[], top_movies=[], genres=[], search_query="", selected_genre="", current_page=1, total_pages=1), 404


if __name__ == '__main__':
    app.run(debug=True, port=5000)