create table Campus(
    Campus_ID NUMBER(4) PRIMARY KEY,
    Campus_name VARCHAR(25) NOT NULL, 
    Campus_location VARCHAR(50) NOT NULL
);
create table College(
    College_ID CHAR(4) PRIMARY KEY,
    College_name VARCHAR(100) NOT NULL, 
    Campus_ID NUMBER(4),
    constraint CampusFK1 foreign key (Campus_ID) references Campus(Campus_ID)
);

create table Faculty(
    Faculty_ID CHAR(9) PRIMARY KEY,
    F_FName VARCHAR(15) NOT NULL, 
    F_LName VARCHAR(15) NOT NULL, 
    F_HireDate DATE NOT NULL,
    F_DOB DATE NOT NULL,
    F_EID CHAR(24) NOT NULL Unique,
    F_College CHAR(4),
    
    constraint FK1 foreign key (F_College) REFERENCES College(College_ID)
);

create table Student(
    Student_ID CHAR(9) PRIMARY KEY,
    S_FName VARCHAR(15) NOT NULL, 
    S_LName VARCHAR(15) NOT NULL, 
    S_JoinDate DATE NOT NULL,
    S_DOB DATE NOT NULL,
    S_EID CHAR(24) NOT NULL Unique,
    S_Advisor CHAR(9),
    S_College CHAR(4), 
    
    constraint FacultyFK1 foreign key (S_Advisor) references Faculty (Faculty_ID),
    constraint CollegeFK2 foreign key (S_College) references College (College_ID)
);

CREATE TABLE ACADAMIC_RECORD (
     College_ID CHAR(4),
     Student_ID CHAR(9),
     CURRENT_STATUS VARCHAR(50) NOT NULL,
     EARNED_HOURS NUMBER(3),
     GRADUATION_REQ VARCHAR(15),
     REG_CREDITS NUMBER(2),
     CGPA NUMBER(3,2),

     CONSTRAINT COMPKEY1 PRIMARY KEY (College_ID, Student_ID),
     CONSTRAINT CLGFK1 FOREIGN KEY (College_ID) REFERENCES College(College_ID),
     CONSTRAINT STUDENTFK2 FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)

);

CREATE TABLE COURSES (
	C_CRN CHAR(5),
	STUDENT_ID CHAR(9),
	C_NAME VARCHAR(50) NOT NULL,
	C_CODE CHAR(6) NOT NULL,
	C_SECTION NUMBER(3) NOT NULL,
	C_NGRADE NUMBER(4, 2),
	C_LGRADE CHAR(2), 

	CONSTRAINT COURSEPK PRIMARY KEY (STUDENT_ID, C_CRN),
	CONSTRAINT STUDENTFK3 FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID)
);

CREATE TABLE cgpaSecurityAudit (
	Attempt_No number(38) Primary key,
	Attempt_By	VARCHAR2(50) NOT NULL,
	Attempt_On CHAR(9) not null,
	Original_Value number(3,2) not null,
	Attempt_Value number(3,2) not null,
	Attempt_Date VARCHAR2(50) not null,
	Attempt_Status VARCHAR2(6) not null

);


-- RECORDS OF CAMPUS

insert into Campus (Campus_ID, Campus_name, Campus_location) 
values ( '666', 'AUH', 'Abudhabi' );

insert into Campus (Campus_ID, Campus_name, Campus_location) 
values ( '888', 'DXB', 'Dubai' );

insert into Campus (Campus_ID, Campus_name, Campus_location) 
values ( '222', 'SHRJ', 'Sharjah' );

-- RECORDS OF COLLEGES

insert into College (College_ID, College_name, Campus_ID) 
values ( '2468', 'College of Arts and Creative Enterprises', '666' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '2354', 'College of Business', '666' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '2558', 'College of Communication and Media Sciences', '666' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '2366', 'College of Technological Innovation', '666' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '3455', 'College of Arts and Creative Enterprises', '888' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '3654', 'College of Communication and Media Sciences', '888' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '3478', 'College of Technological Innovation', '888');

insert into College (College_ID, College_name, Campus_ID) 
values ( '3549', 'College of Business', '888' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '4512', 'College of Interdisciplinary Studies', '222' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '4663', 'College of Natural and Health Sciences', '222' );

insert into College (College_ID, College_name, Campus_ID) 
values ( '4117', 'College of Humanities and Social Sciences', '222' );

--RECORDS OF FACULTY

insert into Faculty 
values ( 
		'201712356', 'Ahmed', 'Mashraq', 
		to_date('28-11-2017', 'dd-mm-yyyy'),
		to_date('21-7-1981', 'dd-mm-yyyy'),
		'1981-56211122247-5-23332', '2468'
);

insert into Faculty 
values ( 
		'201714257', 'Ali', 'Rashed', 
		to_date('28-11-2017', 'dd-mm-yyyy'),
		to_date('21-7-1991', 'dd-mm-yyyy'),
		'1991-56211425897-4-41252', '2354'
);


insert into Faculty 
values ( 
		'201912586', 'Ikbal', 'Mohammed', 
		to_date('2-3-2019', 'dd-mm-yyyy'),
		to_date('5-9-1989', 'dd-mm-yyyy'),
		'1989-23564125432-5-32648', '2558'
);

insert into Faculty 
values ( 
		'202065312', 'Rashed', 'Qraii', 
		to_date('28-1-2020', 'dd-mm-yyyy'),
		to_date('21-7-1990', 'dd-mm-yyyy'),
		'1990-56216312247-3-83461', '2366'
);

insert into Faculty 
values ( 
		'201812735', 'Fadi', 'Ahmed', 
		to_date('9-2-2018', 'dd-mm-yyyy'),
		to_date('6-4-1971', 'dd-mm-yyyy'),
		'1971-16484125434-4-34828', '3455'
);

insert into Faculty 
values ( 
		'201555487', 'Faisal', 'Basheer', 
		to_date('3-12-2015', 'dd-mm-yyyy'),
		to_date('26-4-1975', 'dd-mm-yyyy'),
		'1975-56246218567-5-14225', '3654'
);

insert into Faculty 
values ( 
		'201612586', 'Mohammed', 'Tarreq', 
		to_date('19-3-2016', 'dd-mm-yyyy'),
		to_date('13-4-1985', 'dd-mm-yyyy'),
		'1985-23414587432-3-18531', '3478'
);

insert into Faculty 
values ( 
		'202114912', 'Shadiah', 'Ahmed', 
		to_date('4-1-2021', 'dd-mm-yyyy'),
		to_date('21-7-1979', 'dd-mm-yyyy'),
		'1979-56268423847-5-42867', '3549'
);

insert into Faculty 
values ( 
		'201754739', 'Moheb', 'Matly', 
		to_date('10-8-2017', 'dd-mm-yyyy'),
		to_date('16-6-1986', 'dd-mm-yyyy'),
		'1986-84314382434-3-14628', '4512'
);

insert into Faculty 
values ( 
		'201712586', 'Latifa', 'Ahmed', 
		to_date('19-3-2017', 'dd-mm-yyyy'),
		to_date('13-4-1982', 'dd-mm-yyyy'),
		'1982-72414431832-3-18461', '4663'
);

insert into Faculty 
values ( 
		'201514912', 'Khaled', 'Taleb', 
		to_date('4-1-2015', 'dd-mm-yyyy'),
		to_date('21-7-1978', 'dd-mm-yyyy'),
		'1978-62243173847-5-64367', '4117'
);

insert into Faculty 
values ( 
		'201954739', 'Farooq', 'Ched', 
		to_date('10-8-2019', 'dd-mm-yyyy'),
		to_date('16-6-1989', 'dd-mm-yyyy'),
		'1989-48314456234-4-12188', '3455');

insert into Faculty 
values ( 
		'201642586', 'Moosa', 'Tasha', 
		to_date('11-3-2019', 'dd-mm-yyyy'),
		to_date('26-4-1975', 'dd-mm-yyyy'),
		'1975-23414574932-3-64531', '3478'
);


insert into Faculty 
values ( 
		'201142356', 'Asha', 'Haaq', 
		to_date('13-10-2013', 'dd-mm-yyyy'),
		to_date('21-7-1980', 'dd-mm-yyyy'),
		'1980-56214282247-5-26482', '2468'
);

-- RECORDS OF STUDENTS


insert into student 
values (
	'201944525', 'Ali', 'Almansoori',
	to_date('10-8-2019', 'dd-mm-yyyy'),
	to_date('10-1-2000', 'dd-mm-yyyy'),
	'2000-10114545551-4-14578', 
	'201712356', '2468'
);

insert into student 
values (
	'201849030', 'Ahmad', 'Almarzooqi',
	to_date('10-8-2018', 'dd-mm-yyyy'),
	to_date('10-1-1998', 'dd-mm-yyyy'),
	'1998-50760934160-4-75121', 
	'201714257', '2354'
);

insert into student 
values (
	'201979853', 'Rashed', 'Alharbi',
	to_date('24-7-2019', 'dd-mm-yyyy'),
	to_date('10-4-2001', 'dd-mm-yyyy'),
	'2001-59601132222-4-51768', 
	'201912586', '2558'
);

insert into student
values (
	'202031368', 'Tarriq', 'Almansoori',
	to_date('10-3-2020', 'dd-mm-yyyy'),
	to_date('4-1-2002', 'dd-mm-yyyy'),
	'2002-93585574205-4-50020', 
	'202065312', '2366'
);

insert into student 
values (
	'201969706', 'Fandi', 'Almazrouei',
	to_date('29-5-2019', 'dd-mm-yyyy'),
	to_date('1-12-1999', 'dd-mm-yyyy'),
	'1999-93822151756-4-10455', 
	'201812735', '3455'
);

insert into student 
values (
	'202032708', 'Abdulahh', 'Alzabii',
	to_date('10-8-2020', 'dd-mm-yyyy'),
	to_date('19-3-2000', 'dd-mm-yyyy'),
	'2000-59048480194-4-54960', 
	'201555487', '3654'
);

insert into student 
values (
	'201768616', 'Ahmed', 'Alkaabi',
	to_date('10-8-2017', 'dd-mm-yyyy'),
	to_date('17-5-1997', 'dd-mm-yyyy'),
	'1997-46317017898-4-19162', 
	'201612586', '3478'
);

insert into student 
values (
	'202181184', 'Ali', 'Alharbi',
	to_date('12-10-2021', 'dd-mm-yyyy'),
	to_date('10-6-2001', 'dd-mm-yyyy'),
	'2001-53628950238-4-41924', 
	'202114912', '3549'
);

insert into student
values (
	'201933482', 'Ateeq', 'Alharamy',
	to_date('24-11-2019', 'dd-mm-yyyy'),
	to_date('7-2-2002', 'dd-mm-yyyy'),
	'2002-89743233956-4-58309', 
	'201754739', '4512'
);

insert into student 
values (
	'201843391', 'Amer', 'Trriq',
	to_date('10-8-2018', 'dd-mm-yyyy'),
	to_date('15-6-2000', 'dd-mm-yyyy'),
	'2000-89162558722-4-98642', 
	'201712586', '4663'
);

insert into student
values (
	'202043341', 'Sarah', 'Qais',
	to_date('10-8-2020', 'dd-mm-yyyy'),
	to_date('15-6-2002', 'dd-mm-yyyy'),
	'2002-89164512722-4-98541', 
	'201514912', '2366'
);

-- ACADAMIC REORDS

INSERT INTO ACADAMIC_RECORD 
values (
	'2468', '201944525',
	'Active', '24', 'Not Met',
	'12', '2.99'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'2354', '201849030',
	'Active', '36', 'Not Met',
	'15', '2.22'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'2558', '201979853',
	'Active', '42', 'Not Met',
	'15', '2.83'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'2366', '202031368',
	'Active', '110', 'Not Met',
	'9', '3.40'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'3455', '201969706',
	'Active', '21', 'Not Met',
	'15', '1.67'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'3654', '202032708',
	'Active', '31', 'Not Met',
	'15', '3.89'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'3478', '201768616',
	'Active', '75', 'Not Met',
	'15', '2.32'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'3549', '202181184',
	'Active', '82', 'Not Met',
	'12', '2.67'

);

--

INSERT INTO ACADAMIC_RECORD 
values (
	'4512', '201933482',
	'National Service', '0', 'Not Met',
	'0', '0.00'

);

INSERT INTO ACADAMIC_RECORD 
values (
	'4663', '201843391',
	'National Service', '0', 'Not Met',
	'0', '0.00'

);

--

INSERT INTO ACADAMIC_RECORD 
values (
	'2366', '202043341',
	'Graduated', '120', 'Met',
	'0', '3.80'

);


-- Insertation in COURSES
/**
	USED ONLY 4 STUDENTS TO FILL THIS TABLE
	S1: 201944525
	S2: 201979853
	S3: 201849030
	S4: 202031368
**/

INSERT INTO COURSES
VALUES (
	'29345', '201944525',
	'Arabic', 'ARA465', '205',
	'84', 'B+'

);

INSERT INTO COURSES
VALUES (
	'20345', '201944525',
	'Technical Communication', 'GEN185', '208',
	'67', 'D'

);


INSERT INTO COURSES
VALUES (
	'22327', '201944525',
	'Islamic Civilization', 'ISL135', '201',
	'96', 'A'

);

INSERT INTO COURSES
VALUES (
	'29867', '201944525',
	'Database Systems', 'CIT365', '206',
	'80', 'B'

);


INSERT INTO COURSES
VALUES (
	'27364', '201944525',
	'Business Statictics', 'MTH213', '204',
	'0', 'W'

);


INSERT INTO COURSES
VALUES (
	'21456', '201944525',
	'English', 'ENG240', '209',
	'89', 'A-'

);


--

INSERT INTO COURSES
VALUES (
	'29145', '201944525',
	'Arabic', 'ARA465', '205',
	'71.3', 'C'

);

INSERT INTO COURSES
VALUES (
	'20345', '201849030',
	'Technical Communication', 'GEN185', '208',
	'95', 'A'

);


INSERT INTO COURSES
VALUES (
	'22327', '201849030',
	'Islamic Civilization', 'ISL135', '201',
	'81.5', 'B'

);


INSERT INTO COURSES
VALUES (
	'29867', '201849030',
	'Database Systems', 'CIT365', '206',
	'73.5', 'C'

);



--


INSERT INTO COURSES
VALUES (
	'29845', '201979853',
	'Arabic', 'ARA465', '205',
	'74', 'C'

);

INSERT INTO COURSES
VALUES (
	'20345', '201979853',
	'Technical Communication', 'GEN185', '208',
	'84.6', 'B+'

);


INSERT INTO COURSES
VALUES (
	'22327', '201979853',
	'Islamic Civilization', 'ISL135', '201',
	'81', 'B+'

);


INSERT INTO COURSES
VALUES (
	'29867', '201979853',
	'Database Systems', 'CIT365', '206',
	'93.9', 'A'

);


INSERT INTO COURSES
VALUES (
	'27264', '201979853',
	'Business Statictics', 'MTH213', '204',
	'80', 'B'

);


INSERT INTO COURSES
VALUES (
	'21756', '201979853',
	'English', 'ENG240', '209',
	'75.4', 'C'

);




--

INSERT INTO COURSES
VALUES (
	'28364', '202031368',
	'Business Statictics', 'MTH213', '204',
	'94.61', 'A'

);


INSERT INTO COURSES
VALUES (
	'20246', '202031368',
	'English', 'ENG240', '209',
	'86.72', 'B+'

);


-- Insert the template of cgpaSecurityAudit TRIGGER
Insert into cgpaSecurityAudit 
values (
	1, 'Sample to start with', '202181184', 2.7, 5, 'Date', 'STATUS'
);


-- Display all tables and records

select * from campus;  
select * from college;
select * from faculty;
select * from student;
select * from acadamic_record;
select * from courses;
select * from cgpaSecurityAudit;





