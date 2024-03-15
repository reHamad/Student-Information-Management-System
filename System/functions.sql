
--FUNCTION 1

CREATE OR REPLACE FUNCTION getGrade(courseCode VARCHAR2, SIGN CHAR, nGRADE INT)
RETURN VARCHAR2 AS 
studentsInThat NUMBER(38);
BEGIN

    IF SIGN = '-' THEN
    SELECT COUNT(*) 
    INTO studentsInThat
    FROM COURSES
	WHERE	courseCode = C_CODE AND C_NGRADE <= nGRADE;

	DBMS_OUTPUT.PUT_LINE('The total students who their grade is less then '|| nGRADE || ' in the requested course is '|| studentsInThat);

    ELSIF SIGN = '+' THEN
    SELECT COUNT(*) 
    INTO studentsInThat
    FROM COURSES
	WHERE	courseCode = C_CODE AND C_NGRADE >= nGRADE;

	DBMS_OUTPUT.PUT_LINE('The total students who their grade is more then '|| nGRADE || ' in the requested course is '|| studentsInThat);

    ELSE
      RAISE_APPLICATION_ERROR (-20008, 'There is a syntax error in your input, enter the values in the format of the following example > ("ARA465", "- OR +", 85)');

    END IF;

	RETURN ' ';
END;

-- Test
BEGIN
		DBMS_OUTPUT.PUT_LINE(getGrade('ARA465', '+', 10));
END;


--FUNCTION 2


CREATE OR REPLACE FUNCTION StudentInGPA(x int, y int, z INT) 
RETURN VARCHAR2 AS  
STUCOUNT NUMBER(38);
BEGIN
SELECT COUNT(*) 
INTO STUCOUNT
FROM ACADAMIC_RECORD
WHERE COLLEGE_ID = Z AND CGPA BETWEEN X AND Y;

RETURN (STUCOUNT||''||' Student(s) are between '||x||' and '||y||' in college '||Z);
END;

-- Test
BEGIN
    DBMS_OUTPUT.PUT_LINE(StudentInGPA(2,3.4,2366));
END;




--FUNCTION 3

CREATE OR REPLACE FUNCTION getCourse(cCode CHAR)
RETURN VARCHAR2 AS

SinCourse int;
AvgGrade int;
CourseName VARCHAR2(50);

BEGIN

SELECT COUNT(STUDENT_ID), AVG(C_NGRADE)
	INTO SinCourse, AvgGrade
	FROM COURSES
	WHERE C_CODE = cCode;

SELECT DISTINCT(C_NAME)  
	INTO CourseName
	FROM COURSES
	WHERE C_CODE = cCode;

RETURN ('There are '|| SinCourse ||' Student(s) who completed '|| CourseName ||' course, and the average grade is: '|| AvgGrade);
END;

-- Test
BEGIN
    DBMS_OUTPUT.PUT_LINE(getCourse('MTH213'));
END;
