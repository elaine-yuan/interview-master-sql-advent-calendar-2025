- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH activity_rank AS(
  SELECT DATE(sent_at) AS date, user_name, COUNT(DISTINCT message_id) AS message_count
  , RANK() OVER(PARTITION BY DATE(sent_at) ORDER BY COUNT(DISTINCT message_id) DESC) AS activity_rank
  FROM npn_users u
  LEFT JOIN npn_messages m
  ON u.user_id=m.sender_id
  GROUP BY DATE(sent_at), user_name)
SELECT date, user_name, message_count
FROM activity_rank 
WHERE activity_rank=1
