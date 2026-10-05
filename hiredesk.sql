\q
CREATE DATABASE hiredesk_db;
\c hiredesk_db
CREATE TABLE Candidate (
    CandidateID SERIAL PRIMARY KEY,
    CandidateName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Location VARCHAR(100)
);
CREATE TABLE Skill (
    SkillID SERIAL PRIMARY KEY,
    SkillName VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE Company (
    CompanyID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(100) UNIQUE NOT NULL,
    Location VARCHAR(100),
    Industry VARCHAR(100)
);
CREATE TABLE JobPosting (
    JobPostingID SERIAL PRIMARY KEY,
    CompanyID INT NOT NULL,
    Title VARCHAR(150) NOT NULL,
    Description TEXT,
    PostedOn DATE NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);
CREATE TABLE CandidateSkill (
    CandidateID INT NOT NULL,
    SkillID INT NOT NULL,

    PRIMARY KEY (CandidateID, SkillID),

    FOREIGN KEY (CandidateID)
        REFERENCES Candidate(CandidateID),

    FOREIGN KEY (SkillID)
        REFERENCES Skill(SkillID)
);
CREATE TABLE JobRequiredSkill (
    JobPostingID INT NOT NULL,
    SkillID INT NOT NULL,

    PRIMARY KEY (JobPostingID, SkillID),

    FOREIGN KEY (JobPostingID)
        REFERENCES JobPosting(JobPostingID),

    FOREIGN KEY (SkillID)
        REFERENCES Skill(SkillID)
);
CREATE TABLE Application (
    ApplicationID SERIAL PRIMARY KEY,
    CandidateID INT NOT NULL,
    JobPostingID INT NOT NULL,
    AppliedOn DATE NOT NULL,
    Status VARCHAR(30) NOT NULL,

    FOREIGN KEY (CandidateID)
        REFERENCES Candidate(CandidateID),

    FOREIGN KEY (JobPostingID)
        REFERENCES JobPosting(JobPostingID)
);
INSERT INTO Company (CompanyName, Location, Industry)
VALUES
('TechNova Solutions', 'Mumbai', 'Information Technology'),
('DataSphere Technologies', 'Pune', 'Data Analytics'),
('InnovateX Labs', 'Bengaluru', 'Software Development'),
('CloudCore Systems', 'Hyderabad', 'Cloud Computing');
INSERT INTO Candidate
(CandidateName, Email, Phone, Location)
VALUES
('Aarav Sharma', 'aarav@gmail.com', '9876543210', 'Mumbai'),
('Riya Patel', 'riya@gmail.com', '9876543211', 'Pune'),
('Neha Singh', 'neha@gmail.com', '9876543212', 'Navi Mumbai'),
('Kabir Mehta', 'kabir@gmail.com', '9876543213', 'Bengaluru'),
('Ananya Iyer', 'ananya@gmail.com', '9876543214', 'Hyderabad');
INSERT INTO Skill (SkillName)
VALUES
('Java'),
('Python'),
('SQL'),
('React'),
('Node.js'),
('MongoDB'),
('C++');
SELECT * FROM Company;
SELECT * FROM Candidate;
SELECT * FROM Skill;
INSERT INTO CandidateSkill (CandidateID, SkillID)
VALUES
(1, 1),
(1, 3),
(1, 4),

(2, 2),
(2, 3),
(2, 6),

(3, 1),
(3, 3),
(3, 4),
(3, 5),

(4, 7),
(4, 3),
(4, 2),

(5, 1),
(5, 3),
(5, 5),
(5, 6);
INSERT INTO JobPosting
(CompanyID, Title, Description, PostedOn)
VALUES
(1, 'Java Full Stack Developer',
 'Develop and maintain Java based web applications.',
 '2026-09-01'),

(2, 'Data Analyst',
 'Analyze business data and create reports.',
 '2026-09-03'),

(3, 'React Developer',
 'Build modern web applications using React.',
 '2026-09-05'),

(4, 'Backend Developer',
 'Develop backend services using Node.js and MongoDB.',
 '2026-09-07');
INSERT INTO JobRequiredSkill (JobPostingID, SkillID)
VALUES
(1, 1),
(1, 3),
(1, 4),

(2, 2),
(2, 3),

(3, 4),
(3, 1),

(4, 5),
(4, 6);
INSERT INTO Application
(CandidateID, JobPostingID, AppliedOn, Status)
VALUES
(1, 1, '2026-09-10', 'Applied'),
(3, 1, '2026-09-10', 'Shortlisted'),
(2, 2, '2026-09-11', 'Interview'),
(4, 2, '2026-09-12', 'Applied'),
(3, 3, '2026-09-13', 'Shortlisted'),
(5, 4, '2026-09-14', 'Interview'),
(2, 4, '2026-09-15', 'Applied');
\dt
SELECT * FROM Candidate;
SELECT * FROM Skill;
SELECT * FROM Company;
SELECT * FROM JobPosting;
SELECT * FROM CandidateSkill;
SELECT * FROM JobRequiredSkill;
SELECT * FROM Application;
SELECT
    c.CandidateID,
    c.CandidateName,
    s.SkillName
FROM Candidate c
JOIN CandidateSkill cs
    ON c.CandidateID = cs.CandidateID
JOIN Skill s
    ON cs.SkillID = s.SkillID
ORDER BY c.CandidateID;
SELECT
    c.CandidateID,
    c.CandidateName
FROM Candidate c
JOIN CandidateSkill cs
    ON c.CandidateID = cs.CandidateID
JOIN JobRequiredSkill jrs
    ON cs.SkillID = jrs.SkillID
WHERE jrs.JobPostingID = 1
GROUP BY
    c.CandidateID,
    c.CandidateName
HAVING COUNT(DISTINCT cs.SkillID) = (
    SELECT COUNT(*)
    FROM JobRequiredSkill
    WHERE JobPostingID = 1
);
SELECT
    a.ApplicationID,
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
SELECT
    j.JobPostingID,
    j.Title,
    COUNT(a.ApplicationID) AS TotalApplications
FROM JobPosting j
LEFT JOIN Application a
    ON j.JobPostingID = a.JobPostingID
GROUP BY
    j.JobPostingID,
    j.Title
ORDER BY TotalApplications DESC;
SELECT
    c.CandidateID,
    c.CandidateName
FROM Candidate c
WHERE c.CandidateID IN (
    SELECT CandidateID
    FROM CandidateSkill
    GROUP BY CandidateID
    HAVING COUNT(SkillID) > 2
);
CREATE INDEX idx_jobposting_title
ON JobPosting(Title);
CREATE INDEX idx_candidateskill_skillid
ON CandidateSkill(SkillID);
\di
\s hiredesk.sql
