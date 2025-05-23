Step 1: Create the Marks Table
sql
Copy code
CREATE TABLE Marks (
    Regno INT PRIMARY KEY,
    Name VARCHAR(100),
    Dept VARCHAR(50),
    Subj1 INT,
    Subj2 INT,
    Subj3 INT
);
Step 2: Add a Column Total and Update It
sql
Copy code
-- Add the Total column
ALTER TABLE Marks ADD COLUMN Total INT;

-- Update Total with the sum of 3 subject marks
UPDATE Marks SET Total = Subj1 + Subj2 + Subj3;
Step 3: Find the Second Maximum Total
sql
Copy code
SELECT MAX(Total) AS Second_Max_Total
FROM Marks
WHERE Total < (SELECT MAX(Total) FROM Marks);
Step 4: Display the Name of the Student with Maximum Total
sql
Copy code
SELECT Name
FROM Marks
WHERE Total = (SELECT MAX(Total) FROM Marks);
Step 5: PL/PGSQL Program to Display Report Sheet Using regno
sql
Copy code
DO $$
DECLARE
    reg_input INT := 101; -- Replace with any desired regno
    student RECORD;
BEGIN
    SELECT * INTO student
    FROM Marks
    WHERE Regno = reg_input;

    IF FOUND THEN
        RAISE NOTICE 'Report Sheet for Regno %', student.Regno;
        RAISE NOTICE 'Name: %', student.Name;
        RAISE NOTICE 'Department: %', student.Dept;
        RAISE NOTICE 'Subject 1: %', student.Subj1;
        RAISE NOTICE 'Subject 2: %', student.Subj2;
        RAISE NOTICE 'Subject 3: %', student.Subj3;
        RAISE NOTICE 'Total: %', student.Total;
    ELSE
        RAISE NOTICE 'No student found with Regno %', reg_input;
    END IF;
END $$;
 
