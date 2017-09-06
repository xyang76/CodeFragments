/* Name: Xincheng Yang*/

/*Table FamilyPackage*/
INSERT INTO FamilyPackage(id, address, phone)
  VALUES('1','23 Beacon St.Hillside IL','708-555-9384');
INSERT INTO FamilyPackage(id, address, phone)
  VALUES('2','4930 Dickens Ave Chicago IL','312-555-9403');
INSERT INTO FamilyPackage(id, address, phone)
  VALUES('3','345 Fullerton St. Chicago IL','773-555-0032');
INSERT INTO FamilyPackage(id, address, phone)
  VALUES('4','34 Maple Ln Elmhurst IL','312-555-9382');
INSERT INTO FamilyPackage(id, address, phone)
  VALUES('5','563 Harvard Ave Lisle IL','630-555-9321');

/*Table FamilyPackage*/
INSERT INTO TYPE
  VALUES('Craft','Knitting, sewing, ect');
INSERT INTO TYPE
  VALUES('Art','Paining, sculpting, ect');
INSERT INTO TYPE
  VALUES('Exercise','Any courses having to do with physical activity');
INSERT INTO TYPE
  VALUES('Languages','Anything to do with writing, literature, or communication');
INSERT INTO TYPE
  VALUES('Kids','Courses geared towards children 13 and younger');

/*Table ReccenterMember. This table is too long so I use UNION*/
INSERT INTO ReccenterMember
  (id, f_name, l_name, Dob, Family_id)
SELECT 1,'Abby', 'Smith', TO_DATE('05/21/1983','MM/DD/YYYY'),1 FROM DUAL UNION
SELECT 2,'Mike', 'O''Shea', TO_DATE('07/04/1968','MM/DD/YYYY'),2 FROM DUAL UNION
SELECT 3,'April', 'O''Shea', TO_DATE('06/23/1954','MM/DD/YYYY'),2 FROM DUAL UNION
SELECT 4,'Vijay', 'Gupta', TO_DATE('08/01/1945','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 5,'Lisa', 'Tang', TO_DATE('11/05/2000','MM/DD/YYYY'),3 FROM DUAL UNION
SELECT 6,'Harry', 'Smith', TO_DATE('02/03/1972','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 7,'Justin', 'Smith', TO_DATE('02/02/1983','MM/DD/YYYY'),1 FROM DUAL UNION
SELECT 8,'Lisa', 'Brown', TO_DATE('12/28/1959','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 9,'Harry', 'Tang', TO_DATE('04/03/1948','MM/DD/YYYY'),3 FROM DUAL UNION
SELECT 10,'Dongmei', 'Tang', TO_DATE('06/02/1942','MM/DD/YYYY'),3 FROM DUAL UNION
SELECT 11,'Laura', 'Dickinson', TO_DATE('11/11/1998','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 12,'Victor', 'Garcia', TO_DATE('04/05/2006','MM/DD/YYYY'),5 FROM DUAL UNION
SELECT 13,'Emily', 'Citrin', TO_DATE('05/04/1993','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 14,'Maria', 'Garcia', TO_DATE('07/07/2007','MM/DD/YYYY'),5 FROM DUAL UNION
SELECT 15,'Classie', 'O''Shea', TO_DATE('06/02/1988','MM/DD/YYYY'),2 FROM DUAL UNION
SELECT 16,'Cassandra', 'McDonald', TO_DATE('07/01/1990','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 17,'Jessie', 'Knapp', TO_DATE('09/12/1981','MM/DD/YYYY'),4 FROM DUAL UNION
SELECT 18,'Monica', 'Knapp', TO_DATE('09/17/1982','MM/DD/YYYY'),4 FROM DUAL UNION
SELECT 19,'Leslie', 'Blackburn', TO_DATE('01/19/1986','MM/DD/YYYY'),null FROM DUAL UNION
SELECT 20,'Sandra', 'Svoboda', TO_DATE('09/09/1999','MM/DD/YYYY'),null FROM DUAL;

/*Table Instructor*/
INSERT INTO Instructor
  VALUES('1','Annie', 'Heard', null);
INSERT INTO Instructor
  VALUES('2','Monica', 'Knapp', 18);
INSERT INTO Instructor
  VALUES('3','James', 'Robertson', null);
INSERT INTO Instructor
  VALUES('4','April', 'O''Shea', 2);
INSERT INTO Instructor
  VALUES('5','Harry', 'Tang', 9);
  
/*Table Class*/
INSERT INTO Class
  (id, title, type, instructor, season, year)
SELECT 1,'Needle points', 'Craft',2,'Spring','2010' FROM DUAL UNION
SELECT 2,'Photography', 'Art', 1,'Fall','2008' FROM DUAL UNION
SELECT 3,'Woodworking', 'Craft',4,'Spring','2009' FROM DUAL UNION
SELECT 4,'Chinese (Intro.)', 'Languages', 1,'Winter','2008' FROM DUAL UNION
SELECT 5,'Team games', 'Kids', 1,'Summer','2008' FROM DUAL UNION
SELECT 6,'Yoga (Intro.)', 'Exercise', 2,'Fall','2009' FROM DUAL UNION
SELECT 7,'Origami (Adv.)', 'Craft', 4,'Fall','2009' FROM DUAL UNION
SELECT 8,'Oil painting', 'Art', 3,'Spring','2009' FROM DUAL UNION
SELECT 9,'Yoga (Adv.)', 'Exercise', 1,'Spring','2008' FROM DUAL UNION
SELECT 10,'Chinese (Intro.)', 'Languages', 3,'Spring','2009' FROM DUAL;

/*Table Class*/
INSERT INTO Enrollment
  (class_id, member_id, cost)
SELECT 3,3,'20' FROM DUAL UNION
SELECT 1,9,'15' FROM DUAL UNION
SELECT 2,9,'20' FROM DUAL UNION
SELECT 4,10,'30' FROM DUAL UNION
SELECT 3,10,'10' FROM DUAL UNION
SELECT 5,5,'10' FROM DUAL UNION
SELECT 4,9,'30' FROM DUAL UNION
SELECT 1,11,'25' FROM DUAL UNION
SELECT 2,19,'40' FROM DUAL UNION
SELECT 7,14,'10' FROM DUAL UNION
SELECT 8,12,'5' FROM DUAL UNION
SELECT 1,1,'30' FROM DUAL UNION
SELECT 6,1,'15' FROM DUAL UNION
SELECT 9,1,'20' FROM DUAL UNION
SELECT 8,1,'25' FROM DUAL UNION
SELECT 1,13,'18' FROM DUAL UNION
SELECT 2,20,'9' FROM DUAL UNION
SELECT 10,4,'15' FROM DUAL UNION
SELECT 1,2,'3' FROM DUAL;
