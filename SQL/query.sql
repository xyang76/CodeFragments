/* Name: Xincheng Yang*/

--Q2:What is the phone number of the O'Shea's family?
SELECT phone 
  FROM FamilyPackage 
WHERE ID IN (SELECT family_id FROM RECCENTERMEMBER WHERE L_NAME='O''Shea');

--Q3:Give the name of the members who have enrolled in the most expensive class since data have been kept.
SELECT concat(f_name, concat(' ', l_name)) as NAME
  FROM RECCENTERMEMBER 
WHERE id IN(SELECT member_id FROM enrollment WHERE cost=(SELECT MAX(cost) FROM enrollment));

--Q4:Give the names of the instructors who is not a member of the RecCenter.
SELECT concat(f_name, concat(' ', l_name)) as NAME 
  FROM INSTRUCTOR
WHERE ID NOT IN(
  SELECT i.id 
  FROM 
    INSTRUCTOR i, 
    RECCENTERMEMBER r 
  WHERE i.F_NAME=r.F_NAME AND i.L_NAME = r.L_NAME);
/* Or this alternative version
SELECT concat(f_name, concat(' ', l_name)) as NAME
  FROM Instructor 
WHERE member_id IS NULL;
*/

--Q5:Display the names of members that have enrolled in at least 3 different types of classes.
SELECT concat(f_name, concat(' ', l_name)) as NAME
FROM 
  RECCENTERMEMBER r, 
  (SELECT member_id FROM enrollment GROUP BY MEMBER_ID HAVING count(class_id)>=3) t
WHERE r.ID=t.member_id; 

--Q6:Show all people ever enrolled in a craft class.
SELECT concat(r.f_name, concat(' ', r.l_name)) as NAME
FROM 
  RECCENTERMEMBER r,
      --use DISTINCT to eliminate student who enrolled at least 2 craft classes.
  (SELECT DISTINCT e.member_id, e.class_id 
  FROM 
    class,
    enrollment e 
  WHERE class.type='Craft' AND class.id=e.class_id) t
WHERE r.id = t.member_id;

--Q7:Give the names of the members who were born before 1980 but after 1950.
SELECT concat(r.f_name, concat(' ', r.l_name)) as NAME
  FROM RECCENTERMEMBER r
WHERE r.DOB >= TO_DATE('01-Jan-1950') AND r.DOB < TO_DATE('01-Jan-1980'); 

--Q8:Give the distinct types of classes that were offered in 2008 and 2009 along with their descriptions.
SELECT t.type, t.description 
FROM
  type t,  
  (SELECT distinct type FROM class WHERE year=2008 OR year=2009) c
WHERE t.type = c.type;


