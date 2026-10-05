# HireDesk — Job Portal & Recruitment Management System

## Database Management System — SQL & NoSQL

**Student Name:** Akhila Anish Das  
**Roll No.:** 150096725016  
**Program:** B.Tech CSE & AI  
**Institute:** School of FutureTech  
**Semester:** III  

---

## 1. Project Overview

HireDesk is a Job Portal and Recruitment Management System developed as a Database Management System project.

The system manages candidates, skills, companies, job postings, job-required skills, and job applications using a normalized relational database.

The project demonstrates important DBMS concepts including:

- Entity Relationship Modeling
- Relational Database Design
- Normalization
- Primary Keys
- Foreign Keys
- Unique Constraints
- Composite Primary Keys
- SQL DDL
- SQL DML
- JOIN operations
- Subqueries
- Aggregate Functions
- GROUP BY
- HAVING
- Indexing
- Referential Integrity

---

## 2. Problem Statement

Recruitment platforms need to manage large amounts of candidate, skill, company, job, and application information.

A poorly designed database can lead to:

- Duplicate skill information
- Repeated candidate data
- Difficult skill-based searching
- Slow recruitment queries
- Inconsistent application records
- Poor tracking of application status

HireDesk solves these problems by organizing recruitment data into related and normalized tables.

---

## 3. Objectives

The main objectives of HireDesk are:

1. Store candidate information efficiently.
2. Maintain a centralized list of skills.
3. Store company and job posting information.
4. Associate candidates with multiple skills.
5. Associate job postings with their required skills.
6. Track candidate applications.
7. Track application status.
8. Find candidates who possess all required skills for a job.
9. Use JOINs and aggregate functions for recruitment analysis.
10. Improve search performance using indexes.
11. Maintain data integrity using primary and foreign key constraints.
12. Reduce redundancy through normalization.

---

## 4. Technologies Used

### Database

PostgreSQL

### Language

SQL

### DBMS Concepts

- Relational Database
- ER Diagram
- Normalization
- Primary Key
- Foreign Key
- Unique Key
- Composite Key
- JOIN
- Subquery
- Aggregate Functions
- GROUP BY
- HAVING
- Indexing

---

## 5. Database Name

```sql
hiredesk_db
````

---

## 6. Database Entities

The HireDesk database contains seven relational tables:

1. Candidate
2. Skill
3. Company
4. JobPosting
5. CandidateSkill
6. JobRequiredSkill
7. Application

---

## 7. Entity Description

### 7.1 Candidate

Stores information about job candidates.

Attributes:

* CandidateID — Primary Key
* CandidateName
* Email — Unique
* Phone
* Location

---

### 7.2 Skill

Stores the unique skills available in the recruitment system.

Attributes:

* SkillID — Primary Key
* SkillName — Unique

---

### 7.3 Company

Stores company information.

Attributes:

* CompanyID — Primary Key
* CompanyName — Unique
* Location
* Industry

---

### 7.4 JobPosting

Stores job vacancy information posted by companies.

Attributes:

* JobPostingID — Primary Key
* CompanyID — Foreign Key
* Title
* Description
* PostedOn

---

### 7.5 CandidateSkill

Associates candidates with their skills.

Attributes:

* CandidateID — Primary Key, Foreign Key
* SkillID — Primary Key, Foreign Key

CandidateSkill is a junction table used to represent the many-to-many relationship between Candidate and Skill.

---

### 7.6 JobRequiredSkill

Associates job postings with the skills required for each job.

Attributes:

* JobPostingID — Primary Key, Foreign Key
* SkillID — Primary Key, Foreign Key

JobRequiredSkill is a junction table used to represent the many-to-many relationship between JobPosting and Skill.

---

### 7.7 Application

Stores candidate applications for job postings.

Attributes:

* ApplicationID — Primary Key
* CandidateID — Foreign Key
* JobPostingID — Foreign Key
* AppliedOn
* Status

---

## 8. Entity Relationships

### Company — JobPosting

One company can post many job postings.

**Relationship:** 1 : M

---

### Candidate — Skill

A candidate can have many skills, and a skill can belong to many candidates.

**Relationship:** M : N

This relationship is resolved using the CandidateSkill junction table.

---

### JobPosting — Skill

A job posting can require many skills, and a skill can be required by many job postings.

**Relationship:** M : N

This relationship is resolved using the JobRequiredSkill junction table.

---

### Candidate — Application

One candidate can submit multiple applications.

**Relationship:** 1 : M

---

### JobPosting — Application

One job posting can receive multiple applications.

**Relationship:** 1 : M

---

## 9. Relational Schema

### Candidate

```text
Candidate(
    CandidateID PK,
    CandidateName,
    Email UNIQUE,
    Phone,
    Location
)
```

### Skill

```text
Skill(
    SkillID PK,
    SkillName UNIQUE
)
```

### Company

```text
Company(
    CompanyID PK,
    CompanyName UNIQUE,
    Location,
    Industry
)
```

### JobPosting

```text
JobPosting(
    JobPostingID PK,
    CompanyID FK,
    Title,
    Description,
    PostedOn
)
```

### CandidateSkill

```text
CandidateSkill(
    CandidateID PK, FK,
    SkillID PK, FK
)
```

### JobRequiredSkill

```text
JobRequiredSkill(
    JobPostingID PK, FK,
    SkillID PK, FK
)
```

### Application

```text
Application(
    ApplicationID PK,
    CandidateID FK,
    JobPostingID FK,
    AppliedOn,
    Status
)
```

---

## 10. Normalization

The database is designed using normalization principles to reduce redundancy and improve data integrity.

### First Normal Form — 1NF

The original candidate skill information could contain multiple skills stored together as comma-separated values.

For example:

```text
Java, SQL, React
```

This violates atomicity.

To achieve 1NF, skills are stored separately in the Skill table and candidate-skill associations are stored in CandidateSkill.

---

### Second Normal Form — 2NF

The junction tables use composite primary keys.

CandidateSkill uses:

```text
(CandidateID, SkillID)
```

JobRequiredSkill uses:

```text
(JobPostingID, SkillID)
```

Non-key attributes do not depend on only a part of the composite key.

---

### Third Normal Form — 3NF

Non-key attributes depend on their respective primary keys and not on other non-key attributes.

For example:

* Company details are stored in Company.
* Candidate details are stored in Candidate.
* Skill information is stored in Skill.
* Job information is stored in JobPosting.
* Application information is stored in Application.

This reduces duplication and update anomalies.

---

## 11. Primary Keys

Primary keys uniquely identify records.

The database uses:

* CandidateID
* SkillID
* CompanyID
* JobPostingID
* ApplicationID

CandidateSkill uses a composite primary key:

```text
(CandidateID, SkillID)
```

JobRequiredSkill uses a composite primary key:

```text
(JobPostingID, SkillID)
```

---

## 12. Foreign Keys

Foreign keys maintain relationships between tables.

Examples:

```text
JobPosting.CompanyID
        ↓
Company.CompanyID
```

```text
CandidateSkill.CandidateID
        ↓
Candidate.CandidateID
```

```text
CandidateSkill.SkillID
        ↓
Skill.SkillID
```

```text
JobRequiredSkill.JobPostingID
        ↓
JobPosting.JobPostingID
```

```text
JobRequiredSkill.SkillID
        ↓
Skill.SkillID
```

```text
Application.CandidateID
        ↓
Candidate.CandidateID
```

```text
Application.JobPostingID
        ↓
JobPosting.JobPostingID
```

---

## 13. Sample Data

The database contains sample records for:

### Companies

* TechNova Solutions
* DataSphere Technologies
* InnovateX Labs
* CloudCore Systems

### Candidates

* Aarav Sharma
* Riya Patel
* Neha Singh
* Kabir Mehta
* Ananya Iyer

### Skills

* Java
* Python
* SQL
* React
* Node.js
* MongoDB
* C++

### Job Postings

* Java Full Stack Developer
* Data Analyst
* React Developer
* Backend Developer

The sample data is used to demonstrate recruitment searches, applications, JOIN operations, aggregation, and subqueries.

---

## 14. Candidate-Skill JOIN Query

The CandidateSkill table is joined with Candidate and Skill to display the skills possessed by each candidate.

```sql
SELECT c.CandidateID,
       c.CandidateName,
       s.SkillName
FROM Candidate c
JOIN CandidateSkill cs
    ON c.CandidateID = cs.CandidateID
JOIN Skill s
    ON cs.SkillID = s.SkillID
ORDER BY c.CandidateID;
```

### Purpose

This query demonstrates:

* INNER JOIN
* Junction table usage
* Candidate-skill relationships
* Relational data retrieval

---

## 15. Candidate Matching Query

One of the main requirements of HireDesk is to find candidates who possess every skill required for a particular job posting.

For example, JobPostingID 1 requires:

* Java
* SQL
* React

The query uses JOIN, GROUP BY, COUNT, DISTINCT, and HAVING.

```sql
SELECT c.CandidateID,
       c.CandidateName
FROM Candidate c
JOIN CandidateSkill cs
    ON c.CandidateID = cs.CandidateID
JOIN JobRequiredSkill jrs
    ON cs.SkillID = jrs.SkillID
WHERE jrs.JobPostingID = 1
GROUP BY c.CandidateID, c.CandidateName
HAVING COUNT(DISTINCT cs.SkillID) = (
    SELECT COUNT(*)
    FROM JobRequiredSkill
    WHERE JobPostingID = 1
);
```

### Result

For JobPostingID 1, the candidates matching all required skills are:

* Aarav Sharma
* Neha Singh

### Concepts Demonstrated

* JOIN
* Subquery
* GROUP BY
* HAVING
* COUNT
* DISTINCT
* Many-to-many relationship handling

---

## 16. Application Status Query

Application information is combined with candidate and job posting information using JOIN operations.

```sql
SELECT a.ApplicationID,
       c.CandidateName,
       j.Title,
       a.AppliedOn,
       a.Status
FROM Application a
JOIN Candidate c
    ON a.CandidateID = c.CandidateID
JOIN JobPosting j
    ON a.JobPostingID = j.JobPostingID
ORDER BY a.ApplicationID;
```

### Purpose

This query allows recruiters to view:

* Application ID
* Candidate name
* Job title
* Application date
* Application status

---

## 17. Aggregate Query

The total number of applications received by each job posting can be calculated using an aggregate function.

```sql
SELECT j.JobPostingID,
       j.Title,
       COUNT(a.ApplicationID) AS TotalApplications
FROM JobPosting j
LEFT JOIN Application a
    ON j.JobPostingID = a.JobPostingID
GROUP BY j.JobPostingID, j.Title
ORDER BY TotalApplications DESC;
```

### Concepts Demonstrated

* LEFT JOIN
* COUNT()
* GROUP BY
* ORDER BY
* Aggregate analysis

---

## 18. Subquery

The database can identify candidates who possess more than two skills.

```sql
SELECT c.CandidateID,
       c.CandidateName
FROM Candidate c
WHERE c.CandidateID IN (
    SELECT CandidateID
    FROM CandidateSkill
    GROUP BY CandidateID
    HAVING COUNT(SkillID) > 2
);
```

### Concepts Demonstrated

* Subquery
* IN
* GROUP BY
* HAVING
* COUNT()

---

## 19. Indexing

Indexes are created to improve search performance.

### JobPosting Title Index

```sql
CREATE INDEX idx_jobposting_title
ON JobPosting(Title);
```

This index improves searches involving job titles.

### CandidateSkill SkillID Index

```sql
CREATE INDEX idx_candidateskill_skillid
ON CandidateSkill(SkillID);
```

This index improves skill-based searches and JOIN operations involving SkillID.

---

## 20. Data Integrity

The database maintains data integrity using:

### PRIMARY KEY

Ensures that each record has a unique identifier.

### FOREIGN KEY

Maintains valid relationships between related tables.

### UNIQUE

Prevents duplicate values for:

* Candidate Email
* Skill Name
* Company Name

### NOT NULL

Ensures required fields contain values.

### Composite Primary Keys

Prevent duplicate candidate-skill and job-skill combinations.

---

## 21. SQL Concepts Demonstrated

The HireDesk project demonstrates the following SQL concepts:

* CREATE DATABASE
* CREATE TABLE
* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* NOT NULL
* INSERT
* SELECT
* INNER JOIN
* LEFT JOIN
* Subqueries
* GROUP BY
* HAVING
* COUNT
* DISTINCT
* ORDER BY
* CREATE INDEX

---

## 22. Testing and Verification

The database can be verified by checking:

1. All seven tables are created successfully.
2. Candidate records are inserted correctly.
3. Skill records are inserted correctly.
4. Company records are inserted correctly.
5. Job postings are inserted correctly.
6. Candidate-skill relationships are created correctly.
7. Job-required-skill relationships are created correctly.
8. Application records are inserted correctly.
9. Candidate-skill JOIN query returns the expected relationships.
10. Required-skill matching query returns candidates having all required skills.
11. Application status JOIN displays candidate and job information.
12. Aggregate query calculates application counts.
13. Subquery identifies candidates with more than two skills.
14. Required indexes are created successfully.

---

## 23. Expected Outcomes

The HireDesk database provides:

* Organized recruitment data management
* Reduced data redundancy
* Normalized relational structure
* Efficient candidate-skill searching
* Job-required-skill matching
* Application tracking
* Application status management
* Faster indexed searches
* Referential integrity
* Useful recruitment analytics

---

## 24. Advantages

### Reduced Redundancy

Skills and company information are stored separately instead of being repeatedly stored in other tables.

### Better Data Integrity

Primary keys, foreign keys, unique constraints, and NOT NULL constraints maintain valid data.

### Efficient Skill Matching

The normalized CandidateSkill and JobRequiredSkill tables make it possible to identify candidates matching all required skills.

### Scalable Structure

The database can be extended with additional candidates, companies, skills, jobs, and applications.

### Faster Searching

Indexes improve searches involving job titles and candidate skills.

### Better Recruitment Tracking

Application records connect candidates with job postings and maintain application status.

---

## 25. Project Structure

```text
HireDesk/
│
├── hiredesk.sql
├── README.md
├── ER_Diagram.png
├── Documentation.docx
└── HireDesk_Presentation.pptx
```

---

## 26. How to Run the Project

### Step 1 — Open PostgreSQL

Open PostgreSQL using the terminal or PostgreSQL client.

### Step 2 — Create the Database

```sql
CREATE DATABASE hiredesk_db;
```

### Step 3 — Connect to the Database

```sql
\c hiredesk_db
```

### Step 4 — Execute the SQL Script

Run the HireDesk SQL script containing:

* Table creation
* Sample data
* JOIN queries
* Candidate matching query
* Aggregate query
* Subquery
* Index creation

### Step 5 — Verify the Tables

```sql
\dt
```

The database should contain:

```text
candidate
skill
company
jobposting
candidateskill
jobrequiredskill
application
```

---

## 27. Conclusion

HireDesk demonstrates how a normalized relational database can be designed for a Job Portal and Recruitment Management System.

The project uses seven related tables to manage candidates, skills, companies, job postings, required skills, and applications.

The system demonstrates practical DBMS concepts including ER modeling, normalization, primary and foreign keys, many-to-many relationships, JOINs, subqueries, aggregate functions, GROUP BY, HAVING, and indexing.

The candidate skill-matching query is the key feature of the system because it allows recruiters to identify candidates who possess every skill required for a particular job posting.

Overall, HireDesk provides a structured, normalized, efficient, and scalable database design for recruitment management.

---

## 28. Final Project Summary

**Project:** HireDesk — Job Portal & Recruitment Management System

**Database:** PostgreSQL

**Number of Tables:** 7

**Main Entities:**

* Candidate
* Skill
* Company
* JobPosting
* CandidateSkill
* JobRequiredSkill
* Application

**Main DBMS Concepts:**

* ER Diagram
* 1NF
* 2NF
* 3NF
* Primary Keys
* Foreign Keys
* Composite Keys
* Unique Constraints
* JOINs
* Subqueries
* Aggregate Functions
* GROUP BY
* HAVING
* Indexing

**Main Feature:**

Candidate matching based on all required skills for a selected job posting.

**Outcome:**

A normalized PostgreSQL recruitment database capable of managing candidate information, skills, companies, job postings, job requirements, and applications efficiently.