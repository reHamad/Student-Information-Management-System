
--PROCEDURE 1

CREATE OR REPLACE PROCEDURE getAdvisor(StudentID CHAR) 
AS 
    SNAME STUDENT.S_FNAME%TYPE ;
    SFID 	STUDENT.S_ADVISOR%TYPE ; 
    FID 	FACULTY.FACULTY_ID%TYPE	;
    FFNAME 	FACULTY.F_FNAME%TYPE;
    FLNAME	FACULTY.F_LNAME%TYPE;
    FHD		FACULTY.F_HIREDATE%TYPE;
    FDOB	FACULTY.F_DOB%TYPE;
    FEID	FACULTY.F_EID%TYPE;
    FCOID	FACULTY.F_COLLEGE%TYPE;
BEGIN 
SELECT S.S_FNAME, S.S_ADVISOR, F.FACULTY_ID, F_FNAME, F_LNAME, F_HIREDATE, F_DOB, F_EID, F_COLLEGE
    INTO SNAME, SFID, FID, FFNAME, FLNAME, FHD, FDOB, FEID, FCOID
	FROM STUDENT S, FACULTY F
    WHERE StudentID = S.STUDENT_ID AND S.S_ADVISOR = F.FACULTY_ID; 

    DBMS_OUTPUT.PUT_LINE('`` ');
    DBMS_OUTPUT.PUT_LINE(SNAME || '`s Advisor Information');
    DBMS_OUTPUT.PUT_LINE(' | ID: '||FID ||' | NAME: '|| FFNAME ||' '||FLNAME ||' | Hiredate: '||FHD ||' | Date of Birth: '||FDOB ||' | EID: '||FEID ||' | College ID: '||FCOID);
END;

-- Test
call getadvisor(201944525);


--PROCEDURE 2

CREATE OR REPLACE PROCEDURE insertCourse(x char, y char, z VARCHAR2, c char, s number, ng number, lg char)
AS
  NAME VARCHAR2(50);
  SID CHAR(9);
BEGIN

    SELECT S_FNAME, STUDENT_ID 
	INTO NAME, SID 
	FROM STUDENT 
    WHERE STUDENT_ID = Y;


    INSERT INTO COURSES VALUES (X, Y, Z, C, S, NG, LG);

    DBMS_OUTPUT.PUT_LINE('Course has been added to ' || NAME ||' record.');

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('THIS STUDENT IS NOT ENROLLED IN ZAYED UNIVERSITY');

END;

-- Test
CALL insertCourse('24845', '201944525', 'Arabic', 'ARA465', 905, 96.89, 'A' );


--PROCEDURE 3

CREATE OR REPLACE PROCEDURE getStatus(X IN VARCHAR2 DEFAULT 'Active') AS
allCount number(38);
BEGIN

SELECT COUNT(*) INTO allCount FROM ACADAMIC_RECORD WHERE CURRENT_STATUS = X;

	IF allCount = 0 THEN
	DBMS_OUTPUT.PUT_LINE('There is no such status assigned to a student in our records!');

	ELSIF allCount > 0 THEN
	DBMS_OUTPUT.PUT_LINE('There are '|| allCount||' students who their status is set to '|| X);
	END IF;

END;

-- Test
CALL getStatus();
