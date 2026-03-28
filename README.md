SHG Operational Grading System

A dynamic web application for evaluating Self-Help Groups (SHGs) based on meeting attendance and loan repayment discipline.
This system helps track and evaluate SHG groups through a web interface. Group leaders can login, mark meeting attendance, track loan repayments, and get automated grades based on performance.

Key Functionalities

1. Group Login & Validation
- Group leader enters Group ID and Leader Name
- System validates credentials against MySQL database
- Only authorized leaders can access the system
2. Meeting Attendance Tracking
- 60-second timer to mark attendance
- Leader checks which members attended
- Score calculated based on attendance percentage and time taken
3. Loan Repayment Tracking
- Leader enters loan amount and interest rate
- 60-second timer to mark which members paid
- System calculates monthly payment per member
- Score calculated based on payment percentage and time taken
4. Automatic Score Calculation
- Meeting Score = (Attended/Total × 7) + ((60 - TimeTaken)/60 × 3)
- Repayment Score = (Paid/Total × 7) + ((60 - TimeTaken)/60 × 3)
- Final Grade = (Meeting Score + Repayment Score) / 2
5. Grade Generation
- A: 8.5 - 10.0 (Excellent Performance)
- B: 7.0 - 8.4 (Good Performance)
- C: 5.0 - 6.9 (Average Performance)
- D: 0.0 - 4.9 (Needs Improvement)

Technologies Used
- Java (Servlets, JSP) for Backend logic and web pages
- JDBC for Database connectivity
- MySQL for Data storage (groups and members)
- Bootstrap 5 for Responsive user interface
- JavaScript for 60-second countdown timer
- Apache Tomcat for Web server

Scoring Formula
Meeting/Repayment Score = (Attended/Total) × 7 + ((60 - TimeTaken)/60) × 3

Component  |  Weight  |  Explanation
-----------|----------|--------------
Attendance | 7 points | Based on percentage of members present
Time       | 3 points | Based on how quickly attendance is marked

 Database Setup
Run in MySQL:

CREATE DATABASE shg_grading_system;
USE shg_grading_system;

CREATE TABLE shg_groups (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL,
    leader_name VARCHAR(100) NOT NULL,
    formed_date DATE NOT NULL
);

CREATE TABLE group_members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    group_id INT NOT NULL,
    member_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (group_id) REFERENCES shg_groups(group_id)
);

INSERT INTO shg_groups VALUES
(101, 'Mahila Shakti', 'Rani', '2018-05-12'),
(102, 'Sri Lakshmi', 'Sita', '2019-03-18'),
(103, 'Durga Devi', 'Latha', '2017-11-25'),
(104, 'Sai Jyothi', 'Anitha', '2020-07-10'),
(105, 'Sri Venkateswara', 'Sunitha', '2016-01-30');

INSERT INTO group_members (group_id, member_name) VALUES
(101, 'Rani'), (101, 'Sita'), (101, 'Latha'), (101, 'Anitha'), (101, 'Sunitha'),
(102, 'Sita'), (102, 'Kavitha'), (102, 'Radha'), (102, 'Meena'), (102, 'Anusha'),
(103, 'Latha'), (103, 'Padma'), (103, 'Suma'), (103, 'Geetha'), (103, 'Bhavani'),
(104, 'Anitha'), (104, 'Sandhya'), (104, 'Haritha'), (104, 'Divya'), (104, 'Kalyani'),
(105, 'Sunitha'), (105, 'Sravani'), (105, 'Madhavi'), (105, 'Lakshmi'), (105, 'Renuka');

How to Run
- Import in Eclipse → File → Import → Existing Projects
- Add MySQL Connector JAR to WEB-INF/lib/
- Update password in SHGModel.java
- Run on Tomcat server
- Access: http://localhost:8080/SHG_Operational_Grading_System/

Test Credentials
Group ID	Leader
101	      Rani
102	      Sita
103	      Latha
104	      Anitha
105	      Sunitha

Project Structure:
SHGGradingSystem/
├── src/main/java/com.gqt/
│   ├── SHGModel.java
│   ├── ValidateGroup.java
│   ├── StartMeeting.java
│   ├── StartRepayment.java
│   └── FinalGrade.java
└── src/main/webapp/
    ├── index.html
    ├── dashboard.jsp
    ├── meeting.jsp
    ├── repayment.jsp
    ├── meetingResult.jsp
    ├── repaymentResult.jsp
    ├── finalResult.jsp
    └── error.jsp
