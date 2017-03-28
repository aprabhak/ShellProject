CREATE TABLE Candidate(
CandidateID INT NOT NULL,
CandidateName VARCHAR(20) NOT NULL,
Referral BOOLEAN NOT NULL,
PRIMARY KEY (CandidateID)
);

CREATE TABLE Position(
PositionID INT NOT NULL,
PositionName VARCHAR(20) NOT NULL,
Outcome INT NOT NULL,
CandidateID INT,
PRIMARY KEY (PositionID),
FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);


CREATE TABLE Employee(
EmployeeID INT NOT NULL,
EmployeeName VARCHAR(20) NOT NULL,
Bonus BOOLEAN NOT NULL,
CandidateID INT,
PositionID INT,
PRIMARY KEY (EmployeeID),
FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
FOREIGN KEY (PositionID) REFERENCES Position(PositionID)
);

CREATE TABLE Groupe(
GroupID INT NOT NULL,
GroupName VARCHAR(20) NOT NULL,
PositionID INT,
FOREIGN KEY (PositionID) REFERENCES Position(PositionID)
);

CREATE TABLE Interviewer(
InterviewerID INT NOT NULL,
InterviewerName VARCHAR(20) NOT NULL,
Feedback BOOLEAN NOT NULL,
CandidateID INT,
FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);