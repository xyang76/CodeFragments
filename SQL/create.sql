/* Name: Xincheng Yang*/

/* Part1: Create TABLES, We should execute this part first.*/
CREATE TABLE RecCenterMember(
  id INTEGER PRIMARY KEY,
  f_name VARCHAR2(20) NOT NULL,
  l_name VARCHAR2(20) NOT NULL,
  dob DATE NOT NULL,
  family_id INTEGER
)

CREATE TABLE Class(
  id INTEGER PRIMARY KEY,
  title VARCHAR2(40) NOT NULL,
  type VARCHAR2(20) NOT NULL,
  instructor INTEGER NOT NULL,
  season VARCHAR2(6) NOT NULL,
  year NUMBER(4) NOT NULL
)

CREATE TABLE Instructor(
  id INTEGER PRIMARY KEY,
  f_name VARCHAR2(20) NOT NULL,
  l_name VARCHAR2(20) NOT NULL,
  member_id INTEGER
)

CREATE TABLE Type(
  type VARCHAR2(20) PRIMARY KEY,
  description VARCHAR2(500) NOT NULL
)

CREATE TABLE FamilyPackage(
  id INTEGER PRIMARY KEY,
  address VARCHAR2(100) NOT NULL,
  phone VARCHAR2(15) UNIQUE CHECK(phone like '___-___-____') 
)

CREATE TABLE Enrollment(
  class_id INTEGER,
  member_id INTEGER,
  cost INTEGER NOT NULL,
  CONSTRAINT PK_Enrollment PRIMARY KEY(class_id, member_id)
)

/* Part2: Add FK CONSTRAINTS*/
ALTER TABLE RecCenterMember ADD CONSTRAINT FK_FamilyId FOREIGN KEY(family_id) REFERENCES FamilyPackage(id);

ALTER TABLE Class ADD CONSTRAINT FK_Type FOREIGN KEY(type) REFERENCES Type(type);
ALTER TABLE Class ADD CONSTRAINT FK_Instructor FOREIGN KEY(instructor) REFERENCES Instructor(id);

ALTER TABLE Instructor ADD CONSTRAINT FK_memberId FOREIGN KEY(member_id) REFERENCES RecCenterMember(id);

ALTER TABLE Enrollment ADD CONSTRAINT FK_classId FOREIGN KEY(class_id) REFERENCES Class(id);
ALTER TABLE Enrollment ADD CONSTRAINT FK_Enrollment_memberId FOREIGN KEY(member_id) REFERENCES RecCenterMember(id);
