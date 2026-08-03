import os
from app import app
from services.db_services import get_db_connection

def run_sql_file(filename, cursor):
    file_path = os.path.join('database', filename)
    if os.path.exists(file_path):
        print(f"Executing {filename}...")
        with open(file_path, 'r', encoding='utf-8') as f:
            sql_commands = f.read().split(';')
            for command in sql_commands:
                if command.strip():
                    cursor.execute(command)
        print(f"Finished {filename}!")
    else:
        print(f"Warning: {filename} not found.")

def init_db():
    print("Connecting to database...")
    with app.app_context():
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                
                run_sql_file('schema.sql', cursor)
                
                run_sql_file('seed_data.sql', cursor)
                
            conn.commit()
            print("🎉 Database successfully initialized!")
        except Exception as e:
            print(f"❌ Error initializing database: {e}")
        finally:
            conn.close()

if __name__ == '__main__':
    init_db()