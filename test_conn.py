import os
import pymysql
import ssl
from dotenv import load_dotenv

load_dotenv()

host = os.environ.get('DB_HOST')
port = int(os.environ.get('DB_PORT', 16566))
user = os.environ.get('DB_USER')
password = os.environ.get('DB_PASSWORD')
db = os.environ.get('DB_NAME')

print(f"Testing connection to {host}:{port}...")

ssl_ctx = ssl.create_default_context()
ssl_ctx.check_hostname = False
ssl_ctx.verify_mode = ssl.CERT_NONE

try:
    conn = pymysql.connect(
        host=host,
        port=port,
        user=user,
        password=password,
        database=db,
        ssl=ssl_ctx
    )
    print(" Connection successful!")
    conn.close()
except Exception as e:
    print(f" Connection failed: {e}")