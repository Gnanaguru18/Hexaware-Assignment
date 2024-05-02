-- 1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”
create database CareerHub

-- 2. Create tables for Companies, Jobs, Applicants and Applications.
create table Companies(
CompanyID int,
CompanyName varchar(50),
Location varchar(50),
primary key (CompanyID)
);

create table Jobs(
JobID int,
CompanyID int,
JobTitle varchar(50),
JobDescription varchar(50),
JobLocation varchar(50),
Salary decimal(7,2),
JobType varchar(50),
PostedDate date,
primary key (JobID),
foreign key (CompanyID) references companies(CompanyID)
);

create table Applicants(
ApplicantID int,
FirstName varchar(50),
LastName varchar(50),
Email varchar(50),
Phone varchar(50),
Resume text,
City varchar(50),
State varchar(50),
primary key (ApplicantID)
);

create table Applications(
ApplicationID int,
JobID int,
ApplicantID int,
ApplicationDate date,
CoverLetter text,
primary key (ApplicationID),
foreign key (JobID) references Jobs(JobID),
foreign key (ApplicantID) references Applicants(ApplicantID)
);

-- 3. Define appropriate primary keys, foreign keys, and constraints. 

-- 4. Ensure the script handles potential errors, such as if the database or tables already exist.
INSERT INTO Companies (CompanyID,CompanyName, Location) VALUES
(11,'Tech Innovations', 'San Francisco'),
(12,'Data Driven Inc', 'New York'),
(13,'GreenTech Solutions', 'Austin'),
(14,'CodeCrafters', 'Boston'),
(15,'HexaWare Technologies', 'Chennai');

INSERT INTO Jobs (JobID,CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1,11, 'Frontend Developer', 'Develop user-facing features', 'San Francisco', 75000, 'Full-time', '2023-01-10'),
(2,12, 'Data Analyst', 'Interpret data models', 'New York', 68000, 'Full-time', '2023-02-20'),
(3,13, 'Environmental Engineer', 'Develop environmental solutions', 'Austin', 85000, 'Full-time', '2023-03-15'),
(4,11, 'Backend Developer', 'Handle server-side logic', 'Remote', 77000, 'Full-time', '2023-04-05'),
(5,14, 'Software Engineer', 'Develop and test software systems', 'Boston', 90000, 'Full-time', '2023-01-18'),
(6,15, 'HR Coordinator', 'Manage hiring processes', 'Chennai', 45000, 'Contract', '2023-04-25'),
(7,12, 'Senior Data Analyst', 'Lead data strategies', 'New York', 95000, 'Full-time', '2023-01-22');

INSERT INTO Applicants (ApplicantID,FirstName, LastName, Email, Phone, Resume,City,State) VALUES
(21,'John', 'Doe', 'john.doe@example.com', '123-456-7890', 'Experienced web developer with 5 years of experience.','San Francisco','State 1'),
(22,'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 'Data enthusiast with 3 years of experience in data analysis.','New York','State 2'),
(23,'Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012', 'Environmental engineer with 4 years of field experience.','Chennai','Tamil Nadu'),
(24,'Bob', 'Brown', 'bob.brown@example.com', '456-789-0123', 'Seasoned software engineer with 8 years of experience.','Austin','State 3');

INSERT INTO Applications (ApplicationID,JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(31,1, 21, '2023-04-01', 'I am excited to apply for the Frontend Developer position.'),
(32,2, 22, '2023-04-02', 'I am interested in the Data Analyst position.'),
(33,3, 23, '2023-04-03', 'I am eager to bring my expertise to your team as an Environmental Engineer.'),
(34,4, 24, '2023-04-04', 'I am applying for the Backend Developer role to leverage my skills.'),
(35,5, 21, '2023-04-05', 'I am also interested in the Software Engineer position at CodeCrafters.');

-- 5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications.
select JobTitle,count(applicationID) as ApplicationCount
from jobs j left join Applications a
on j.JobID= a.JobID
group by JobTitle

-- 6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range. Allow parameters for the minimum and maximum salary values. Display the job title, company name, location, and salary for each matching job.
declare @u decimal(7,2)=65000;
declare @l decimal(7,2)=95000;
select JobTitle,CompanyName,JobLocation,Salary
from Jobs j inner join Companies c
on j.CompanyID=c.CompanyID
where Salary >@u and salary<@l;

-- 7.Write an SQL query that retrieves the job application history for a specific applicant. Allow a parameter for the ApplicantID, and return a result set with the job titles, company names, and application dates for all the jobs the applicant has applied to.
declare @a int=21;

select CompanyName,JobTitle,ApplicationDate
from Companies c inner join (select CompanyID,a.JobID,JobTitle,ApplicationDate
						from Applications a inner join Jobs j
						on a.JobID=j.JobID
						where ApplicantID=@a) i
on c.CompanyID=i.CompanyID

-- 8. Create an SQL query that calculates and displays the average salary offered by all companies for job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.
select CompanyName,AverageSalary
from Companies c inner join (select CompanyID,avg(salary) as AverageSalary
							from Jobs
							group by CompanyID) i
on c.CompanyID=i.CompanyID

-- 9. Write an SQL query to identify the company that has posted the most job listings. Display the company name along with the count of job listings they have posted. Handle ties if multiple companies have the same maximum count.
select top 1 with TIES CompanyName, count(JobID) AS TotalCount
from Companies c inner join Jobs j 
on c.CompanyID = j.CompanyID
group by CompanyName
order by count(JobID) desc;


-- 10. Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience.
declare @c varchar(50)='New York';
select concat(firstname,' ',lastname) as Name
from Applicants 
where ApplicantID in(select ApplicantID
					from jobs j inner join Applications a
					on j.JobID=a.JobID
					where JobLocation=@c)
and (Resume like '%3%' or 
Resume like '%4%' or
Resume like '%5%' or 
Resume like '%6%' or 
Resume like '%7%' or
Resume like '%8%' or 
Resume like '%9%' or
Resume like '%10%')

-- 11.Retrieve a list of distinct job titles with salaries between $60,000 and $80,000
select distinct(jobtitle) 
from Jobs
where salary between 60000 and 80000

-- 12. Find the jobs that have not received any applications.
select JobTitle
from jobs 
where JobID not in (select JobID
					from Applications)

-- 13. Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for.
select concat(firstname,' ',lastname) as name,companyname,jobtitle
from Applicants a inner join Applications ap
on a.ApplicantID=ap.ApplicantID 
inner join jobs j
on ap.JobID=j.JobID
inner join Companies c
on c.CompanyID=j.CompanyID

-- 14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications
select companyname,count(jobid) as RolesPosted
from Companies c inner join Jobs j
on c.CompanyID=j.CompanyID
group by CompanyName

-- 15. List all applicants along with the companies and positions they have applied for, including those who have not applied
select concat(firstname,' ',lastname) as Name,CompanyName,JobTitle
from Applicants a left join (select ApplicantID,companyname,jobtitle
						from Applications ap
						inner join jobs j
						on ap.JobID=j.JobID
						inner join Companies c
						on c.CompanyID=j.CompanyID) i
on a.ApplicantID=i.ApplicantID

-- 16. Find companies that have posted jobs with a salary higher than the average salary of all jobs.
select companyname
from Companies
where CompanyID in(select CompanyID
				from Jobs 
				where salary > (select avg(salary)
								from Jobs))

-- 17. Display a list of applicants with their names and a concatenated string of their city and state.
select concat(FirstName,' ',LastName) as name, concat(city,', ',state) as CityAndState
from Applicants

-- 18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'
select *
from Jobs
where JobTitle like '%developer%'
or jobtitle like '%engineer%'

-- 19. Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants.
select concat(firstname,' ',lastname) as Name,CompanyName,JobTitle
from Applicants a left join (select ApplicantID,companyname,jobtitle
						from Applications ap
						inner join jobs j
						on ap.JobID=j.JobID
						inner join Companies c
						on c.CompanyID=j.CompanyID) i
on a.ApplicantID=i.ApplicantID
                    
-- 20. List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience. For example: city=Chennai
select FirstName,LastName, CompanyName, Location
from Applicants a inner join Applications ap
on a.ApplicantID = ap.ApplicantID
inner join Jobs j
ON ap.JobID = j.JobID
inner join Companies c on j.CompanyID = c.CompanyID
where (Resume like '%3%' or 
Resume like '%4%' or
Resume like '%5%' or 
Resume like '%6%' or 
Resume like '%7%' or
Resume like '%8%' or 
Resume like '%9%' or
Resume like '%10%')
and Location = 'Chennai';