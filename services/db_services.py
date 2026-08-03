import os
import pymysql
from flask import current_app

def get_db_connection():
    """Establishes a connection, applying SSL only for the cloud database."""
    # Grab from environment variables first (Render), fallback to config (Local)
    host = os.environ.get('DB_HOST', current_app.config.get('DB_HOST', '')).strip()
    user = os.environ.get('DB_USER', current_app.config.get('DB_USER', '')).strip()
    password = os.environ.get('DB_PASSWORD', current_app.config.get('DB_PASSWORD', '')).strip()
    db = os.environ.get('DB_NAME', current_app.config.get('DB_NAME', '')).strip()
    
    # Safely get the port, defaulting to 3306 for local
    port_val = os.environ.get('DB_PORT') or current_app.config.get('DB_PORT', 3306)
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

    # ONLY apply SSL if the host is your Aiven cloud database
    if "aivencloud" in host:
        connection_params['ssl'] = {"ssl": {}}

    return pymysql.connect(**connection_params)

def get_all_movies(genre=None, search=None, page=1, per_page=8, **kwargs):
    """Retrieves a paginated list of movies AND the total count matching the current filters."""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            # 1. First, build the query for fetching the specific page of movies
            query = "SELECT * FROM movies WHERE 1=1"
            params = []

            if genre:
                query += " AND genre LIKE %s"
                params.append(f"%{genre}%")

            if search:
                query += " AND (title LIKE %s OR director LIKE %s)"
                params.extend([f"%{search}%", f"%{search}%"])

            # Calculate limit and offset based on pagination args from app.py
            limit = int(per_page)
            current_page = max(1, int(page))
            offset = (current_page - 1) * limit

            query += " LIMIT %s OFFSET %s"
            params.extend([limit, offset])

            cursor.execute(query, params)
            movies = cursor.fetchall()

            # 2. Get the total count for the pagination math in app.py
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

            # Return BOTH items so app.py can unpack them properly
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

def add_user(username, password_hash):
    """
    Inserts a new user into the database.
    Returns True if successful, False if the username already exists.
    """
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute(
            "INSERT INTO users (username, password_hash) VALUES (%s, %s)", 
            (username, password_hash)
        )
        conn.commit()
        return True
    except Exception as e:
        print(f"Error adding user: {e}")
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
        # Uses DictCursor defined at the connection level safely
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
    """Inserts a new review into the database."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO reviews (movie_id, user_id, rating, comment) VALUES (%s, %s, %s, %s)",
            (movie_id, user_id, rating, comment)
        )
        conn.commit()
        return True
    except Exception as e:
        print(f"Error adding review: {e}")
        return False
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def get_reviews_by_movie_id(movie_id):
    """Retrieves all reviews for a specific movie, including the username and admin status of the reviewer."""
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        query = """
            SELECT reviews.*, users.username, users.is_admin 
            FROM reviews 
            JOIN users ON reviews.user_id = users.id 
            WHERE reviews.movie_id = %s 
            ORDER BY reviews.created_at DESC
        """
        cursor.execute(query, (movie_id,))
        return cursor.fetchall()
    except Exception as e:
        print(f"Error fetching reviews: {e}")
        return []
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

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
        if cursor: cursor.close()
        if conn: conn.close()