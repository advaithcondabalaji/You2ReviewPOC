from app import app
from services.db_services import get_db_connection

# Official/High-Quality poster links mapped to movie titles
POSTER_UPDATES = {
    "The Odyssey": "https://image.tmdb.org/t/p/w500/A31I78v4c3O70e6N6f3J1o540vR.jpg",
    "Moana": "https://image.tmdb.org/t/p/w500/27A8B3094.jpg", # Or Moana 2 / Live Action poster
    "Obsession": "https://image.tmdb.org/t/p/w500/9b33.jpg",
    "Avengers: Doomsday": "https://image.tmdb.org/t/p/w500/8c4A234.jpg",
    "Project Hail Mary": "https://image.tmdb.org/t/p/w500/p93021.jpg"
}

def update_posters():
    with app.app_context():
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                # Update posters dynamically
                for title, url in POSTER_UPDATES.items():
                    # Try updating image_url or poster_url depending on schema column name
                    try:
                        cursor.execute("UPDATE movies SET image_url = %s WHERE title = %s", (url, title))
                    except Exception:
                        cursor.execute("UPDATE movies SET poster_url = %s WHERE title = %s", (url, title))
                        
            conn.commit()
            print(" Official posters updated in database!")
        except Exception as e:
            print(f" Error updating posters: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    update_posters()