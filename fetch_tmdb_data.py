import os
import requests
from app import app
from services.db_services import get_db_connection

TMDB_API_KEY = os.environ.get('TMDB_API_KEY', '1bbe3f93b1b3cd2bff79636f4695ffc6')
TMDB_IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"

def sync_tmdb_data():
    with app.app_context():
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                # 1. Detect actual column names in your 'movies' table
                cursor.execute("SHOW COLUMNS FROM movies")
                columns = [col['Field'] for col in cursor.fetchall()]
                
                poster_col = 'poster_url' if 'poster_url' in columns else ('image_url' if 'image_url' in columns else 'poster')
                desc_col = 'description' if 'description' in columns else ('overview' if 'overview' in columns else None)

                print(f"Detected columns -> Poster: '{poster_col}', Description: '{desc_col}'")

                # 2. Fetch movies
                cursor.execute("SELECT id, title FROM movies")
                movies = cursor.fetchall()

                print(f"Found {len(movies)} movies. Fetching TMDB posters and descriptions...\n")

                for movie in movies:
                    movie_id = movie['id']
                    title = movie['title']

                    # Call TMDB Search API
                    search_url = "https://api.themoviedb.org/3/search/movie"
                    params = {
                        "api_key": TMDB_API_KEY,
                        "query": title
                    }
                    
                    response = requests.get(search_url, params=params).json()
                    results = response.get('results', [])

                    if results:
                        top_match = results[0]
                        poster_path = top_match.get('poster_path')
                        overview = top_match.get('overview')

                        full_poster_url = f"{TMDB_IMAGE_BASE_URL}{poster_path}" if poster_path else None

                           
                        update_parts = [f"{poster_col} = COALESCE(%s, {poster_col})"]
                        params_list = [full_poster_url]

                        if desc_col:
                            update_parts.append(f"{desc_col} = COALESCE(%s, {desc_col})")
                            params_list.append(overview)

                        params_list.append(movie_id)
                        query = f"UPDATE movies SET {', '.join(update_parts)} WHERE id = %s"

                        cursor.execute(query, tuple(params_list))
                        
                        print(f" SUCCESS: '{title}' -> {full_poster_url}")
                    else:
                        print(f" SKIPPED: No match found on TMDB for '{title}'")

            conn.commit()
            print("\n Database successfully updated with official TMDB posters and plots!")
        except Exception as e:
            print(f"\n Error updating TMDB data: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    sync_tmdb_data()