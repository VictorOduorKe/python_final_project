-- -- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS studyAiBudyDb;

-- ----USE DATABASE
USE studyAiBudyDb;

----- CREATE USER TABLE----
CREATE TABLE users (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(100) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login datetime DEFAULT NULL,
  user_role enum('user','admin') DEFAULT 'user',
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
);

-- --- CREATE  SUBJECTS TABLE-----
CREATE TABLE subjects (
  id int NOT NULL AUTO_INCREMENT,
  user_id int DEFAULT NULL,
  subject_name varchar(100) NOT NULL,
  education_level varchar(100) NOT NULL,
  created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  CONSTRAINT subjects_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- --CREATE STUDYPLAN TABLE-----
CREATE TABLE study_plans (
  id int NOT NULL AUTO_INCREMENT,
  subject_id int NOT NULL,
  summary text NOT NULL,
  roadmap json NOT NULL,
  quiz_questions json NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int DEFAULT NULL,
  uuid char(36) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY subject_id (subject_id),
  KEY fk_study_plans_user_id (user_id),
  CONSTRAINT fk_study_plans_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT study_plans_ibfk_1 FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
);


-- CREATE QUIZES TABLE----
CREATE TABLE quizzes (
  id int NOT NULL AUTO_INCREMENT,
  user_id int DEFAULT NULL,
  subject_id int DEFAULT NULL,
  question text,
  answer text,
  user_answer text,
  score int DEFAULT NULL,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  KEY subject_id (subject_id),
  CONSTRAINT quizzes_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT quizzes_ibfk_2 FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
);

-- --- CREATE QUIZ_ATTEMPT TABLE------
CREATE TABLE quiz_attempts (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  plan_id int NOT NULL,
  answers json NOT NULL,
  score int NOT NULL,
  total_questions int NOT NULL,
  completed_at datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY unique_user_plan (user_id,plan_id),
  KEY plan_id (plan_id),
  CONSTRAINT quiz_attempts_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT quiz_attempts_ibfk_2 FOREIGN KEY (plan_id) REFERENCES study_plans (id) ON DELETE CASCADE
);
