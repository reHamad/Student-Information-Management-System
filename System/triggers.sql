
-- TRIGGER 1 

CREATE OR REPLACE TRIGGER gpaChack
BEFORE UPDATE OF CGPA ON ACADAMIC_RECORD
FOR EACH ROW
DECLARE
InputCount number(38);
Username VARCHAR2(50);
SID CHAR(9);
GetDate VARCHAR2(50);

BEGIN

	Username := USER;
	SID := :OLD.Student_ID;

	SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') INTO GetDate FROM DUAL;

	SELECT MAX(Attempt_No) INTO InputCount
	FROM cgpaSecurityAudit;

 	IF :NEW.CGPA > :OLD.CGPA + 1  OR :NEW.CGPA < :OLD.CGPA - 1 THEN 

          RAISE_APPLICATION_ERROR (-20002, ' You cannot update the student CGPA more then the double, conatact the adminstration officer for such changes. ');

	ELSIF :NEW.CGPA > 4 THEN 

   		 RAISE_APPLICATION_ERROR (-20003, 'The amount that you have entered is not valid, conatact the adminstration officer for such changes.');

	ELSIF :NEW.CGPA = :OLD.CGPA THEN
        
   		 RAISE_APPLICATION_ERROR (-20004, 'The student CGPA is already '|| :OLD.CGPA);

	ELSE

    Insert into cgpaSecurityAudit 
	values (
		InputCount + 1, Username, SID, :OLD.CGPA, :NEW.CGPA, GetDate, 'PASSED'
        );

    END IF;

	DBMS_OUTPUT.PUT_LINE('Student CGPA has been updated successfully..');
END;


-- Test

UPDATE ACADAMIC_RECORD
    SET CGPA = 1
	WHERE STUDENT_ID = 201933482;

UPDATE ACADAMIC_RECORD
    SET CGPA = 4.2
	WHERE STUDENT_ID = 202031368;

UPDATE ACADAMIC_RECORD
    SET CGPA = 4
	WHERE STUDENT_ID = 201969706;

UPDATE ACADAMIC_RECORD
    SET CGPA = 3.98
	WHERE STUDENT_ID = 202032708;

-- Trigger 2 

CREATE OR REPLACE TRIGGER newStudent
AFTER INSERT ON STUDENT
FOR EACH ROW
BEGIN 

	INSERT INTO ACADAMIC_RECORD
	VALUES(:NEW.S_College, :NEW.STUDENT_ID, 'Active', 0, 'Not Met', 0, 0);

	DBMS_OUTPUT.PUT_LINE('Student has been added to ZU records...');
	DBMS_OUTPUT.PUT_LINE('Acadamic record has been created successfully...');

END;

-- Test

drop trigger REGPERIOD

insert into student 
values (
	'205218616', 'ddd', 'booo',
	to_date('10-8-2017', 'dd-mm-yyyy'),
	to_date('17-5-1997', 'dd-mm-yyyy'),
	'1997-46541201788-4-19162', 
	'201612586', '3478'
);


--TRIGGER 3

CREATE OR REPLACE TRIGGER regPeriod
BEFORE INSERT ON STUDENT
BEGIN
     IF (TO_CHAR(SYSDATE, 'MM') NOT BETWEEN '04' AND '06') THEN
      RAISE_APPLICATION_ERROR (-20001, 'The registration period is already closed, please contact an administrator.');
     END IF;
END;

-- Test

insert into student 
values (
	'201912368', 'Hamad', 'Almazrouei',
	to_date('24-7-2019', 'dd-mm-yyyy'),
	to_date('10-4-2001', 'dd-mm-yyyy'),
	'2001-59601132222-4-51768', 
	'201912586', '2558'
);
