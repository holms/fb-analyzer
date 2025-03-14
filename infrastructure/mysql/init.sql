-- Initialize database schema for FB Analyzer

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS fb_analyzer;
USE fb_analyzer;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Facebook Groups table
CREATE TABLE IF NOT EXISTS fb_groups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fb_group_id VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- User-Group mapping table
CREATE TABLE IF NOT EXISTS user_groups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    fb_group_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (fb_group_id) REFERENCES fb_groups(id) ON DELETE CASCADE,
    UNIQUE KEY user_group_unique (user_id, fb_group_id)
);

-- Posts table
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fb_post_id VARCHAR(255) NOT NULL UNIQUE,
    fb_group_id INT NOT NULL,
    content TEXT,
    author VARCHAR(255),
    post_url VARCHAR(512),
    posted_at DATETIME,
    likes_count INT DEFAULT 0,
    comments_count INT DEFAULT 0,
    shares_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (fb_group_id) REFERENCES fb_groups(id) ON DELETE CASCADE
);

-- Post Analysis table
CREATE TABLE IF NOT EXISTS post_analysis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    sentiment_score FLOAT,
    engagement_score FLOAT,
    keywords TEXT,
    topics TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Create default user for testing
INSERT INTO users (username, email, password_hash)
VALUES ('testuser', 'test@example.com', '$2a$10$PLACEHOLDER_HASH_REPLACE_IN_PRODUCTION');
