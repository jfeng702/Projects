DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body VARCHAR,
  author_id INTEGER,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body VARCHAR,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);



DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO question_likes (user_id, question_id)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO users (fname, lname)
VALUES
('Joey','Feng'),
('Ashil','Farahmand'),
('James','Dean');

INSERT INTO questions (title, body, author_id)
VALUES
  ('What is Ruby?', 'Is Ruby a gem or programming language?', 1),
  ('What is a question?', 'so intuitive?', 3),
  ('?', '???', 2);

INSERT INTO question_follows (user_id, question_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

INSERT INTO replies (question_id, user_id, body)
VALUES
  (1, 1, "That is a stupid question"),
  (2, 2, "What is an answer?"),
  (3, 3, "!");

INSERT INTO replies (question_id, parent_id, user_id, body)
VALUES
  (1, 1, 2, "Yes it is."),
  (2,2,3, 'A response to a question.');
