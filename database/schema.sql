-- Disable foreign key checks temporarily to make dropping tables clean
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS review_tags;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. MOVIES TABLE (Stores movie details, cached AI consensus, and aggregated metrics)
CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    genre VARCHAR(100),
    runtime VARCHAR(50), -- e.g., "2h 28m"
    director VARCHAR(100),
    synopsis TEXT,
    poster_url VARCHAR(500),
    
    -- Cached rating and sentiment stats (updated periodically by background math/AI)
    overall_rating DECIMAL(3,1) DEFAULT 0.0, -- 1.0 to 10.0 scale
    positive_pct INT DEFAULT 0,
    mixed_pct INT DEFAULT 0,
    negative_pct INT DEFAULT 0,
    
    -- Dynamic AI summary
    ai_verdict TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. USERS TABLE (Handles account details and securely hashed passwords)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Never store plain text passwords!
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. REVIEWS TABLE (Captures the main rating, text, and anonymous state)
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    user_id INT NULL, -- NULL indicates an Anonymous/Guest review
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 10), -- 1-10 star scale
    review_text TEXT,
    is_spoiler BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 4. REVIEW TAGS TABLE (Categorizes what specific elements users liked/disliked)
CREATE TABLE review_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    review_id INT NOT NULL,
    tag_name VARCHAR(100) NOT NULL, -- e.g., 'Acting', 'Pacing', 'Music', 'VFX', 'Ending'
    is_positive BOOLEAN NOT NULL,   -- 1 = Liked (🔥), 0 = Disliked (❌)
    
    FOREIGN KEY (review_id) REFERENCES reviews(id) ON DELETE CASCADE
);