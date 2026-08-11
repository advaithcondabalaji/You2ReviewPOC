import os
import ssl
import pymysql
from flask import current_app, has_app_context
from dotenv import load_dotenv

# Load environment variables from .env file directly for standalone scripts
load_dotenv()

def get_db_connection():
    """Establishes a connection, applying an explicit SSL context for cloud databases."""
    # Check if running inside a Flask request/app context
    if has_app_context():
        host = os.environ.get('DB_HOST', current_app.config.get('DB_HOST', '')).strip()
        user = os.environ.get('DB_USER', current_app.config.get('DB_USER', '')).strip()
        password = os.environ.get('DB_PASSWORD', current_app.config.get('DB_PASSWORD', '')).strip()
        db = os.environ.get('DB_NAME', current_app.config.get('DB_NAME', '')).strip()
        port_val = os.environ.get('DB_PORT') or current_app.config.get('DB_PORT', 3306)
    else:
        host = os.environ.get('DB_HOST', '').strip()
        user = os.environ.get('DB_USER', '').strip()
        password = os.environ.get('DB_PASSWORD', '').strip()
        db = os.environ.get('DB_NAME', '').strip()
        port_val = os.environ.get('DB_PORT', 3306)

    port = int(str(port_val).strip())

    # Base connection parameters
    connection_params = {
        'host': host,
        'port': port,
        'user': user,
        'password': password,
        'database': db,
        'cursorclass': pymysql.cursors.DictCursor
    }

    # Explicit SSL Context setup for Aiven cloud database connections
    if "aivencloud" in host:
        ssl_ctx = ssl.create_default_context()
        ssl_ctx.check_hostname = False
        ssl_ctx.verify_mode = ssl.CERT_NONE
        connection_params['ssl'] = ssl_ctx

    return pymysql.connect(**connection_params)

def get_all_movies(genre=None, search=None, page=1, per_page=8, **kwargs):
    """Retrieves a paginated list of movies AND the total count matching the current filters."""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            query = "SELECT * FROM movies WHERE 1=1"
            params = []

            if genre:
                query += " AND genre LIKE %s"
                params.append(f"%{genre}%")

            if search:
                query += " AND (title LIKE %s OR director LIKE %s)"
                params.extend([f"%{search}%", f"%{search}%"])

            limit = int(per_page)
            current_page = max(1, int(page))
            offset = (current_page - 1) * limit

            query += " LIMIT %s OFFSET %s"
            params.extend([limit, offset])

            cursor.execute(query, params)
            movies = cursor.fetchall()

            count_query = "SELECT COUNT(*) as total FROM movies WHERE 1=1"
            count_params = []

            if genre:
                count_query += " AND genre LIKE %s"
                count_params.append(f"%{genre}%")

            if search:
                count_query += " AND (title LIKE %s OR director LIKE %s)"
                count_params.extend([f"%{search}%", f"%{search}%"])

            cursor.execute(count_query, count_params)
            result = cursor.fetchone()
            total_count = result['total'] if result else 0

            return movies, total_count
            
    finally:
        connection.close()

def get_movie_by_id(movie_id):
    """Retrieves a single movie's details by its ID."""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            query = "SELECT * FROM movies WHERE id = %s"
            cursor.execute(query, (movie_id,))
            return cursor.fetchone()
    finally:
        connection.close()

def get_total_movie_count(genre=None, search=None, **kwargs):
    """Returns the total count of movies matching the current filters (standalone helper)."""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            query = "SELECT COUNT(*) as total FROM movies WHERE 1=1"
            params = []

            if genre:
                query += " AND genre LIKE %s"
                params.append(f"%{genre}%")

            if search:
                query += " AND (title LIKE %s OR director LIKE %s)"
                params.extend([f"%{search}%", f"%{search}%"])

            cursor.execute(query, params)
            result = cursor.fetchone()
            return result['total'] if result else 0
    finally:
        connection.close()

def get_unique_genres():
    """Retrieves all distinct genres from the database for the navigation dropdown/filter."""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT DISTINCT genre FROM movies WHERE genre IS NOT NULL AND genre != '';")
            genres = [row['genre'] for row in cursor.fetchall()]
            return genres
    finally:
        connection.close()

def add_user(username, password_hash, email=None):
    """
    Dynamically inserts a new user into the database based on active table columns.
    Returns True if successful, False if insertion fails.
    """
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SHOW COLUMNS FROM users")
        columns = [col['Field'] for col in cursor.fetchall()]

        fields = ['username']
        values = [username]

        if 'password_hash' in columns:
            fields.append('password_hash')
            values.append(password_hash)
        elif 'password' in columns:
            fields.append('password')
            values.append(password_hash)

        if 'email' in columns:
            fields.append('email')
            values.append(email if email else f"{username}@example.com")

        placeholders = ', '.join(['%s'] * len(fields))
        col_names = ', '.join(fields)
        query = f"INSERT INTO users ({col_names}) VALUES ({placeholders})"

        cursor.execute(query, tuple(values))
        conn.commit()
        print(f" SUCCESS: Registered user '{username}' in database!")
        return True

    except Exception as e:
        print(f"❌ Error adding user to database: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def get_user_by_username(username):
    """
    Retrieves a user record by their username.
    Returns the user dictionary if found, or None if not found.
    """
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        return user
    except Exception as e:
        print(f"Error fetching user: {e}")
        return None
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def add_review(movie_id, user_id, rating, comment):
    """Inserts a new review into the database, auto-detecting column names and missing movies."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # 1. Auto-create movie record if missing from Aiven (prevents Foreign Key errors)
        cursor.execute("SELECT id FROM movies WHERE id = %s", (int(movie_id),))
        if not cursor.fetchone():
            cursor.execute(
                "INSERT INTO movies (id, title, genre) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE id=id",
                (int(movie_id), f"Movie #{movie_id}", "General")
            )
            conn.commit()

        cursor.execute("SHOW COLUMNS FROM reviews")
        columns = [col['Field'] for col in cursor.fetchall()]

        fields = ['movie_id', 'user_id', 'rating']
        values = [int(movie_id), int(user_id), int(rating)]

        # Find the actual text column name in Aiven
        possible_text_cols = ['comment', 'review', 'review_text', 'comments', 'content', 'text', 'body']
        for col_name in possible_text_cols:
            if col_name in columns:
                fields.append(col_name)
                values.append(str(comment))
                break

        # Check for created_at
        if 'created_at' in columns:
            fields.append('created_at')

        placeholders = ['NOW()' if f == 'created_at' else '%s' for f in fields]
        query = f"INSERT INTO reviews ({', '.join(fields)}) VALUES ({', '.join(placeholders)})"

        cursor.execute(query, tuple(values))
        conn.commit()
        return True, "Success"

    except Exception as e:
        print(f"❌ DATABASE ERROR IN ADD_REVIEW: {e}")
        if conn:
            conn.rollback()
        return False, str(e)

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def get_reviews_by_movie_id(movie_id):
    """Retrieves all reviews for a specific movie, dynamically adapting to database column names."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # 1. Inspect reviews table columns
        cursor.execute("SHOW COLUMNS FROM reviews")
        rev_cols = [col['Field'] for col in cursor.fetchall()]
        
        # 2. Inspect users table columns
        cursor.execute("SHOW COLUMNS FROM users")
        user_cols = [col['Field'] for col in cursor.fetchall()]

        # Safely determine order column (fallback to 'id' if 'created_at' is missing)
        order_by = "reviews.created_at" if "created_at" in rev_cols else "reviews.id"
        
        # Safely check for is_admin column in users
        admin_field = ", users.is_admin" if "is_admin" in user_cols else ""

        query = f"""
            SELECT reviews.*, users.username{admin_field} 
            FROM reviews 
            JOIN users ON reviews.user_id = users.id 
            WHERE reviews.movie_id = %s 
            ORDER BY {order_by} DESC
        """
        cursor.execute(query, (int(movie_id),))
        reviews = cursor.fetchall()

        # 3. Standardize comment field name for HTML template compatibility
        for r in reviews:
            if 'comment' not in r or not r['comment']:
                for alt_key in ['review', 'review_text', 'comments', 'content', 'text', 'body']:
                    if alt_key in r and r[alt_key]:
                        r['comment'] = r[alt_key]
                        break

        return reviews
    except Exception as e:
        print(f"❌ ERROR IN GET_REVIEWS_BY_MOVIE_ID: {e}")
        return []
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def delete_review_by_id(review_id):
    """Deletes a review from the database by its ID."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM reviews WHERE id = %s", (review_id,))
        conn.commit()
        return True
    except Exception as e:
        print(f"Error deleting review: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()