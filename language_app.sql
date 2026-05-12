CREATE DATABASE language_learning_db;
USE language_learning_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    role ENUM('student', 'teacher', 'admin') DEFAULT 'student',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE languages (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    level ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL,
    language_id INT,
    teacher_id INT,
    
    FOREIGN KEY (language_id) REFERENCES languages(language_id),
    FOREIGN KEY (teacher_id) REFERENCES users(user_id)
);


CREATE TABLE lessons (
    lesson_id INT PRIMARY KEY AUTO_INCREMENT,
    lesson_title VARCHAR(100) NOT NULL,
    content TEXT,
    video_url VARCHAR(255),
    course_id INT,

    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    course_id INT,
    enrolled_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    progress INT DEFAULT 0,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE vocabulary (
    vocab_id INT PRIMARY KEY AUTO_INCREMENT,
    word VARCHAR(100) NOT NULL,
    meaning VARCHAR(255) NOT NULL,
    pronunciation VARCHAR(100),
    lesson_id INT,

    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id)
);

CREATE TABLE quizzes (
    quiz_id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_title VARCHAR(100) NOT NULL,
    lesson_id INT,

    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id)
);

CREATE TABLE questions (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    question_content TEXT NOT NULL,
    option_a VARCHAR(255),
    option_b VARCHAR(255),
    option_c VARCHAR(255),
    option_d VARCHAR(255),
    correct_answer CHAR(1),
    quiz_id INT,

    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id)
);