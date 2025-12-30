-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH first_and_last AS (
SELECT subject, MIN(quiz_date) AS first_quiz_date, MAX(quiz_date) AS last_quiz_date
FROM daily_quiz_scores
GROUP BY subject
),
first_quiz AS (
SELECT d.subject, d.quiz_date, d.score
FROM daily_quiz_scores d
JOIN first_and_last fl
ON d.subject = fl.subject
AND d.quiz_date = fl.first_quiz_date
),
last_quiz AS (
SELECT d.subject, d.quiz_date, d.score
FROM daily_quiz_scores d
JOIN first_and_last fl
ON d.subject = fl.subject
AND d.quiz_date = fl.last_quiz_date
)
SELECT fl.subject, MIN(f.score) AS first_score, MIN(l.score) AS last_score
FROM first_and_last fl
LEFT JOIN first_quiz f ON fl.subject = f.subject AND fl.first_quiz_date = f.quiz_date
LEFT JOIN last_quiz l ON fl.subject = l.subject AND fl.last_quiz_date  = l.quiz_date
GROUP BY fl.subject, fl.first_quiz_date, fl.last_quiz_date
ORDER BY fl.subject
