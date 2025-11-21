CREATE DATABASE IF NOT EXISTS demojpa;
USE demojpa;

-- USERS
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(200) NOT NULL,
    password VARCHAR(500) NOT NULL,
    email VARCHAR(200) NOT NULL,
    fullname VARCHAR(200) NOT NULL,
    phone VARCHAR(15),
    images VARCHAR(500),
    admin BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CATEGORIES
CREATE TABLE IF NOT EXISTS categories (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    Categoryname VARCHAR(200) NOT NULL,
    Categorycode VARCHAR(50) NOT NULL,
    Images VARCHAR(500),
    Status INT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- VIDEOS
CREATE TABLE IF NOT EXISTS videos (
    VideoId VARCHAR(255) PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Poster VARCHAR(500),
    Views INT DEFAULT 0,
    Description TEXT,
    Active INT DEFAULT 1,
    CategoryId INT,
    FOREIGN KEY (CategoryId) REFERENCES categories(CategoryId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- SAMPLE DATA

INSERT INTO users (username, password, email, fullname, phone, images, admin, active) VALUES
('admin', '123', 'admin@example.com', 'Administrator', '0909000111', NULL, TRUE, TRUE),
('user1', '123', 'user1@example.com', 'Nguyen Van A', '0909000222', NULL, FALSE, TRUE),
('user2', '123', 'user2@example.com', 'Tran Thi B', '0909000333', NULL, FALSE, FALSE);

INSERT INTO categories (Categoryname, Categorycode, Images, Status) VALUES
('Phim Hành Động', 'ACTION', NULL, 1),
('Phim Tình Cảm', 'ROMANCE', NULL, 1),
('Phim Hoạt Hình', 'ANIMATION', NULL, 1);

INSERT INTO videos (VideoId, Title, Poster, Views, Description, Active, CategoryId) VALUES
('V001', 'Avengers: Endgame', 'https://example.com/avengers.jpg', 1000, 'Biệt đội siêu anh hùng', 1, 1),
('V002', 'Titanic', 'https://example.com/titanic.jpg', 500, 'Tàu Titanic', 1, 2),
('V003', 'Tom and Jerry', 'https://example.com/tomjerry.jpg', 2000, 'Mèo và Chuột', 1, 3);
