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
    roleid INT DEFAULT 1, -- 1: User, 2: Manager, 3: Admin
    active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CATEGORIES
CREATE TABLE IF NOT EXISTS categories (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    Categoryname VARCHAR(200) NOT NULL,
    Categorycode VARCHAR(50) NOT NULL,
    Images VARCHAR(500),
    Status INT DEFAULT 1,
    userid INT,
    FOREIGN KEY (userid) REFERENCES users(id)
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

INSERT INTO users (username, password, email, fullname, phone, images, roleid, active) VALUES
('admin', '123', 'admin@example.com', 'Administrator', '0909000111', NULL, 3, TRUE),
('manager', '123', 'manager@example.com', 'Manager User', '0909000222', NULL, 2, TRUE),
('user', '123', 'user@example.com', 'Normal User', '0909000333', NULL, 1, TRUE);

INSERT INTO categories (Categoryname, Categorycode, Images, Status, userid) VALUES
('Phim Hành Động', 'ACTION', NULL, 1, 1),
('Phim Tình Cảm', 'ROMANCE', NULL, 1, 2),
('Phim Hoạt Hình', 'ANIMATION', NULL, 1, 3);

INSERT INTO videos (VideoId, Title, Poster, Views, Description, Active, CategoryId) VALUES
('V001', 'Avengers: Endgame', 'https://example.com/avengers.jpg', 1000, 'Biệt đội siêu anh hùng', 1, 1),
('V002', 'Titanic', 'https://example.com/titanic.jpg', 500, 'Tàu Titanic', 1, 2),
('V003', 'Tom and Jerry', 'https://example.com/tomjerry.jpg', 2000, 'Mèo và Chuột', 1, 3);
