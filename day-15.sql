-- SQL Advent Calendar - Day 15
-- Title: The Grinch's Mischief Tracker
-- Difficulty: hard
--
-- Question:
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--

-- Table Schema:
-- Table: grinch_mischief_log
--   log_date: DATE
--   mischief_score: INTEGER
--

-- My Solution:

WITH mischief_score_comp AS(
  SELECT log_date, mischief_score
  , LAG (mischief_score, 1, 0) OVER (ORDER BY log_date) AS prev_mischief_score
  FROM grinch_mischief_log)
SELECT log_date, mischief_score-prev_mischief_score AS diff_in_score_from_prev_day
FROM mischief_score_comp
