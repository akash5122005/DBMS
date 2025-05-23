//(a) Create table and PL/pgSQL Program to calculate fine

CREATE TABLE Book (
    acc_no INT PRIMARY KEY,
    username VARCHAR(50),
    bookno VARCHAR(20),
    days INT
);


INSERT INTO Book VALUES
(101, 'John', 'B101', 6),
(102, 'James', 'B102', 2),
(103, 'Alice', 'B103', 0),
(104, 'Jenny', 'B104', 10);

//PL/pgSQL Function to Calculate Fine:
CREATE OR REPLACE FUNCTION calculate_fine(p_acc_no INT)
RETURNS INT AS $$
DECLARE
    fine INT;
    borrowed_days INT;
BEGIN
    SELECT days INTO borrowed_days FROM Book WHERE acc_no = p_acc_no;
    
    IF NOT FOUND THEN
        RAISE NOTICE 'Account number not found.';
        RETURN NULL;
    END IF;

    fine := borrowed_days * 5;
    RETURN fine;
END;
$$ LANGUAGE plpgsql;

//usage:
SELECT calculate_fine(101);


//(B):PL/pgSQL block to find greatest of three numbers

DO $$
DECLARE
    a INT := 10;
    b INT := 25;
    c INT := 15;
    greatest INT;
BEGIN
    greatest := a;

    IF b > greatest THEN
        greatest := b;
    END IF;

    IF c > greatest THEN
        greatest := c;
    END IF;

    RAISE NOTICE 'Greatest number is %', greatest;
END;
$$;

//(C)Number of books taken by users whose name starts with 'J'

SELECT username, COUNT(*) AS books_taken
FROM Book
WHERE username ILIKE 'J%'
GROUP BY username;

//(D)Display user name and account number for users whose accounts were created after the 15th of any month

ALTER TABLE Book ADD COLUMN created_date DATE;

-- Sample update
UPDATE Book SET created_date = '2025-05-16' WHERE acc_no = 101;
UPDATE Book SET created_date = '2025-05-10' WHERE acc_no = 102;
UPDATE Book SET created_date = '2025-06-18' WHERE acc_no = 103;
UPDATE Book SET created_date = '2025-06-14' WHERE acc_no = 104;

//query:
SELECT username, acc_no
FROM Book
WHERE EXTRACT(DAY FROM created_date) > 15;
