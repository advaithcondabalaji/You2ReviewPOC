import os
import requests
import pymysql
from dotenv import load_dotenv
import time


load_dotenv()

TMDB_API_KEY = os.getenv("TMDB_API_KEY")
TMDB_BASE_URL = "https://api.themoviedb.org/3/search/movie"
TMDB_IMAGE_BASE = "https://image.tmdb.org/t/p/w500" # High-res poster size
TMDB_BACKDROP_BASE = "https://image.tmdb.org/t/p/original" # High-res wide backdrop size

def get_db_connection():
    """Connect to the MySQL database."""
    return pymysql.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        user=os.getenv('DB_USER', 'root'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME', 'movie_db'),
        cursorclass=pymysql.cursors.DictCursor
    )

def fetch_movie_data(title, release_year=None):
    """Hits the TMDB API to find the official synopsis, poster, and wide backdrop."""
    params = {
        'api_key': TMDB_API_KEY,
        'query': title,
        'language': 'en-US',
        'page': 1,
        'include_adult': 'false'
    }
    
    # Add year to search if we have it to make it more accurate
    if release_year:
        params['primary_release_year'] = release_year

    response = requests.get(TMDB_BASE_URL, params=params)
    
    if response.status_code == 200:
        results = response.json().get('results', [])
        if results:
            # Grab the top result
            top_match = results[0]
            
            # Ensure the plot is mapped to what your DB uses
            synopsis = top_match.get('overview', '')
            
            # Construct the full vertical poster URL
            poster_path = top_match.get('poster_path')
            poster_url = f"{TMDB_IMAGE_BASE}{poster_path}" if poster_path else ""
            
            # Construct the full wide landscape backdrop URL for the banner
            backdrop_path = top_match.get('backdrop_path')
            backdrop_url = f"{TMDB_BACKDROP_BASE}{backdrop_path}" if backdrop_path else poster_url
            
            return synopsis, poster_url, backdrop_url
            
    return None, None, None

def update_catalog():
    """Loops through the database and updates missing information."""
    print("Connecting to database...")
    connection = get_db_connection()
    
    try:
        with connection.cursor() as cursor:
            # Check if backdrop_url column exists, if not, add it automatically
            cursor.execute("""
                SELECT COUNT(*) as cnt 
                FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() 
                AND TABLE_NAME = 'movies' 
                AND COLUMN_NAME = 'backdrop_url'
            """)
            if cursor.fetchone()['cnt'] == 0:
                print("Adding 'backdrop_url' column to movies table...")
                cursor.execute("ALTER TABLE movies ADD COLUMN backdrop_url VARCHAR(255)")
                connection.commit()

            # Get all movies
            cursor.execute("SELECT id, title, release_year FROM movies")
            movies = cursor.fetchall()
            
            print(f"Found {len(movies)} movies. Starting TMDB sync...")
            
            for movie in movies:
                movie_id = movie['id']
                title = movie['title']
                year = movie.get('release_year')
                
                print(f"Fetching data for: {title}...")
                synopsis, poster_url, backdrop_url = fetch_movie_data(title, year)
                
                if synopsis or poster_url:
                    # Update the database with synopsis, poster, and backdrop
                    update_query = """
                        UPDATE movies 
                        SET synopsis = %s, poster_url = %s, backdrop_url = %s 
                        WHERE id = %s
                    """
                    cursor.execute(update_query, (synopsis, poster_url, backdrop_url, movie_id))
                    connection.commit()
                    print(f"  -> Successfully updated {title}!")
                else:
                    print(f"  -> Could not find data for {title}.")
                
                # Sleep for a fraction of a second to avoid overwhelming the TMDB API
                time.sleep(0.2)
                
        print("\nCatalog update complete!")
        
    finally:
        connection.close()

if __name__ == "__main__":
    update_catalog()