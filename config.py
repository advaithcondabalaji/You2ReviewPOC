import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """Base configuration class."""

    SECRET_KEY = os.environ.get('SECRET_KEY', 'develop-secret-key-keep-it-safe')
    
    # Database Configuration
    DB_HOST = os.environ.get('DB_HOST', 'localhost')
    DB_USER = os.environ.get('DB_USER', 'root')
    DB_PASSWORD = os.environ.get('DB_PASSWORD', '')
    DB_NAME = os.environ.get('DB_NAME', 'movie_db')
    
   
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"

class DevelopmentConfig(Config):
    """Development-specific configurations."""
    DEBUG = True

class ProductionConfig(Config):
    """Production-specific configurations."""
    DEBUG = False
    # In production, require actual environment variables to be set
    SECRET_KEY = os.environ.get('SECRET_KEY')
    
    # Secure cookie settings
    SESSION_COOKIE_SECURE = True
    REMINDER_COOKIE_SECURE = True

# Dictionary to easily switch environments
config_by_name = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'default': DevelopmentConfig
}