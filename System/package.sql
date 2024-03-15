
CREATE OR REPLACE PACKAGE HAMAD 
AS
	Procedure getAdvisor(StudentID CHAR);
	Procedure insertCourse(x char, y char, z VARCHAR2, c char, s number, ng number, lg char);
	Procedure getStatus(X IN VARCHAR2 DEFAULT 'Active');

	Function StudentInGPA(x int, y int, z INT) RETURN VARCHAR2;
	Function getCourse(cCode CHAR) RETURN VARCHAR2;
	Function getGrade(courseCode VARCHAR2, SIGN CHAR, nGRADE INT) RETURN VARCHAR2;

END HAMAD;

CREATE OR REPLACE PACKAGE BODY HAMAD
AS
	PROCEDURE 
	getAdvisor(StudentID CHAR) IS 
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

	PROCEDURE
	insertCourse(x char, y char, z VARCHAR2, c char, s number, ng number, lg char) IS 
		NAME VARCHAR2(50);
  		SID CHAR(9);
	BEGIN
		
    	SELECT S_FNAME, STUDENT_ID 
			INTO NAME, SID 
			FROM STUDENT 
    		WHERE STUDENT_ID = Y;


   		INSERT INTO COURSES 
			VALUES (X, Y, Z, C, S, NG, LG);

    	DBMS_OUTPUT.PUT_LINE('Course has been added to ' || NAME ||' record.');

  	EXCEPTION
   		 WHEN NO_DATA_FOUND THEN
    		  DBMS_OUTPUT.PUT_LINE('THIS STUDENT IS NOT ENROLLED IN ZAYED UNIVERSITY');

	END;	

	PROCEDURE 
	getStatus(X IN VARCHAR2 DEFAULT 'Active') AS
		allCount number(38);
	BEGIN

		SELECT COUNT(*) INTO allCount FROM ACADAMIC_RECORD WHERE CURRENT_STATUS = X;

			IF allCount = 0 THEN
			DBMS_OUTPUT.PUT_LINE('There is no such status assigned to a student in our records!');

			ELSIF allCount > 0 THEN
			DBMS_OUTPUT.PUT_LINE('There are '|| allCount||' students who their status is set to '|| X);
		END IF;

	END;
	
	FUNCTION
	StudentInGPA(x int, y int, z INT) 
		RETURN VARCHAR2 AS  
			STUCOUNT NUMBER(38);
	BEGIN
		SELECT COUNT(*) 
			INTO STUCOUNT
			FROM ACADAMIC_RECORD
			WHERE COLLEGE_ID = Z AND CGPA BETWEEN X AND Y;

		RETURN (STUCOUNT||''||' Student(s) are between '||x||' and '||y||' in college '||Z);
	END;

	
	FUNCTION
	getCourse(cCode CHAR)
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

		RETURN ('There are '|| SinCourse ||' Student(s) who completed '|| CourseName 
		||' course, and the avarage grade is: '|| AvgGrade);
	END;

	FUNCTION
	getGrade(courseCode VARCHAR2, SIGN CHAR, nGRADE INT)
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


END HAMAD;
