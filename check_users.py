from app import app
from services.db_services import get_db_connection

def inspect_users():
    with app.app_context():
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                # 1. Fetch all existing users
                cursor.execute("SELECT id, username, email FROM users")
                users = cursor.fetchall()
                
                print("\n--- Current Users in Database ---")
                if users:
                    for u in users:
                        print(f"ID: {u.get('id')} | Username: '{u.get('username')}' | Email: {u.get('email')}")
                else:
                    print("No users found in database.")

                # Option to clear users table if you want a fresh start
                # Uncomment the lines below to wipe the users table:
                # cursor.execute("DELETE FROM users")
                # conn.commit()
                # print("\n Cleaned all users from database!")

        except Exception as e:
            print(f"Error checking users: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    inspect_users()