-- 1.1 Simple Example
SELECT
	*,
	MAX(score) OVER() AS maximum_score,
	MIN(score) OVER() AS minimum_score

FROM student_score;

SELECT *,
	(SELECT MAX(score) FROM student_score) AS maximum_score,
	(SELECT MIN(score) FROM student_score) AS minimum_score
FROM student_score;

-- 1.2 Partition By
SELECT
	*,
	MAX(score)OVER(PARTITION BY dep_name) AS dep_maximum_score,
	ROUND(AVG(score)OVER(PARTITION BY dep_name), 2) AS dep_average_score
FROM student_score;

-- 1.3 Row Number
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY student_name) AS name_serial_number
FROM student_score;

-- 1.4 Rank
SELECT
	*,
	RANK()OVER(PARTITION BY dep_name ORDER BY score DESC)
FROM student_score;

-- 1.5 Dense Rank
SELECT
	*,
	DENSE_RANK()OVER(PARTITION BY dep_name ORDER BY score DESC)
FROM student_score;

-- 1.6 Lag
SELECT
	*,
	LAG(score) OVER(PARTITION BY dep_name ORDER BY score)
FROM student_score;

-- 1.7 Frame Clause
SELECT
	*,
	SUM(score)OVER(ORDER BY student_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cummulative_sum
FROM student_score;

-- 2.0 Initialization
CREATE TABLE
    users (
        fullname VARCHAR(120),
        email VARCHAR(120),
        username VARCHAR(30),
        password VARCHAR(60)
    );

-- 2.1 Create Trigger
CREATE OR REPLACE FUNCTION hash_password()
RETURNS TRIGGER AS $$
BEGIN
  NEW.password = MD5(NEW.password);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER password_hasher
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION hash_password();

INSERT INTO
    users
VALUES
    (
        'idris babu',
        'zubs@test.com',
        'zubby1',
        'password'
    );

-- 2.2 Drop Trigger
DROP TRIGGER
    IF EXISTS password_hasher
    ON users;

INSERT INTO
    users
VALUES
    (
        'idris babu',
        'zubs@test.com',
        'zubby1',
        'password'
    );
