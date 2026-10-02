-- LankaJobsHub demo data
-- Run manually after schema creation. Demo password for non-admin users: password
-- Built-in admin is managed by DataInitializer: admin@lankajobshub.com / admin123

USE `LankaJobsHub.com`;

-- Users
INSERT IGNORE INTO users (email, password, role, status, full_name, phone_number, bio, linkedin_url, github_url, created_date) VALUES
('admin@lankajobshub.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'ADMIN', 'ACTIVE', 'System Administrator', '+94 11 000 0000', 'Platform administrator for LankaJobsHub.', NULL, NULL, CURRENT_TIMESTAMP),
('cre@techcorp.lk', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'CLIENT_RELATIONS_EXECUTIVE', 'ACTIVE', 'Naveen Perera', '+94 77 101 2020', 'Client relations executive managing company profiles.', NULL, NULL, CURRENT_TIMESTAMP),
('hiring@techcorp.lk', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'COMPANY_HIRING_MANAGER', 'ACTIVE', 'Anjali Fernando', '+94 77 202 3030', 'Hiring manager for technology vacancies.', NULL, NULL, CURRENT_TIMESTAMP),
('recruitment@innovate.lk', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'RECRUITMENT_MANAGER', 'ACTIVE', 'Kasun Silva', '+94 77 303 4040', 'Recruitment manager coordinating applications and interviews.', NULL, NULL, CURRENT_TIMESTAMP),
('hr@digital.lk', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'HR_ASSISTANT', 'ACTIVE', 'Madhavi Jayasinghe', '+94 77 404 5050', 'HR assistant supporting interview scheduling.', NULL, NULL, CURRENT_TIMESTAMP),
('john.doe@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'JOB_SEEKER', 'ACTIVE', 'John Doe', '+94 77 111 2222', 'Java developer looking for backend engineering roles.', 'https://linkedin.com/in/johndoe', 'https://github.com/johndoe', CURRENT_TIMESTAMP),
('jane.smith@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'JOB_SEEKER', 'ACTIVE', 'Jane Smith', '+94 77 222 3333', 'Frontend developer focused on React and user experience.', 'https://linkedin.com/in/janesmith', 'https://github.com/janesmith', CURRENT_TIMESTAMP),
('mike.wilson@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'JOB_SEEKER', 'ACTIVE', 'Mike Wilson', '+94 77 333 4444', 'DevOps engineer with cloud infrastructure experience.', 'https://linkedin.com/in/mikewilson', 'https://github.com/mikewilson', CURRENT_TIMESTAMP),
('sarah.jones@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'JOB_SEEKER', 'ACTIVE', 'Sarah Jones', '+94 77 444 5555', 'UI/UX designer with product design experience.', 'https://linkedin.com/in/sarahjones', NULL, CURRENT_TIMESTAMP);

-- Companies
INSERT INTO companies (name, description, address, contact_person, phone_number, website_url, status, created_date)
SELECT 'TechCorp Lanka', 'Enterprise software development and cloud engineering company.', 'Colombo 03, Sri Lanka', 'Anjali Fernando', '+94 11 234 5678', 'https://techcorp.lk', 'ACTIVE', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE name = 'TechCorp Lanka');

INSERT INTO companies (name, description, address, contact_person, phone_number, website_url, status, created_date)
SELECT 'Innovate Lanka', 'Product engineering company building modern SaaS platforms.', 'Kandy, Sri Lanka', 'Kasun Silva', '+94 81 345 6789', 'https://innovate.lk', 'ACTIVE', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Innovate Lanka');

INSERT INTO companies (name, description, address, contact_person, phone_number, website_url, status, created_date)
SELECT 'Digital Solutions', 'Digital transformation and consulting services for local businesses.', 'Galle, Sri Lanka', 'Madhavi Jayasinghe', '+94 91 456 7890', 'https://digitalsolutions.lk', 'ACTIVE', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Digital Solutions');

INSERT INTO companies (name, description, address, contact_person, phone_number, website_url, status, created_date)
SELECT 'Talent Hub', 'Recruitment and HR advisory company for Sri Lankan employers.', 'Colombo 07, Sri Lanka', 'Naveen Perera', '+94 11 567 8901', 'https://talenthub.lk', 'ACTIVE', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Talent Hub');

-- Candidate profiles
INSERT INTO candidates (id, skills, education, experience, preferred_job_type, preferred_location, expected_salary)
SELECT id, 'Java\nSpring Boot\nMySQL\nREST APIs', 'BSc in Software Engineering - University of Colombo', 'Backend Developer - 3 years\nIntern Software Engineer - 1 year', 'FULL_TIME', 'Colombo', 180000
FROM users WHERE email = 'john.doe@email.com'
ON DUPLICATE KEY UPDATE skills = VALUES(skills), education = VALUES(education), experience = VALUES(experience), preferred_job_type = VALUES(preferred_job_type), preferred_location = VALUES(preferred_location), expected_salary = VALUES(expected_salary);

INSERT INTO candidates (id, skills, education, experience, preferred_job_type, preferred_location, expected_salary)
SELECT id, 'React\nTypeScript\nTailwind CSS\nFigma', 'BSc in Information Technology - SLIIT', 'Frontend Developer - 4 years', 'FULL_TIME', 'Colombo', 160000
FROM users WHERE email = 'jane.smith@email.com'
ON DUPLICATE KEY UPDATE skills = VALUES(skills), education = VALUES(education), experience = VALUES(experience), preferred_job_type = VALUES(preferred_job_type), preferred_location = VALUES(preferred_location), expected_salary = VALUES(expected_salary);

INSERT INTO candidates (id, skills, education, experience, preferred_job_type, preferred_location, expected_salary)
SELECT id, 'AWS\nDocker\nKubernetes\nCI/CD', 'BEng in Computer Systems - University of Moratuwa', 'DevOps Engineer - 5 years', 'FULL_TIME', 'Kandy', 230000
FROM users WHERE email = 'mike.wilson@email.com'
ON DUPLICATE KEY UPDATE skills = VALUES(skills), education = VALUES(education), experience = VALUES(experience), preferred_job_type = VALUES(preferred_job_type), preferred_location = VALUES(preferred_location), expected_salary = VALUES(expected_salary);

INSERT INTO candidates (id, skills, education, experience, preferred_job_type, preferred_location, expected_salary)
SELECT id, 'UI Design\nUX Research\nWireframing\nDesign Systems', 'Diploma in Interaction Design - AOD', 'UI/UX Designer - 3 years', 'CONTRACT', 'Galle', 130000
FROM users WHERE email = 'sarah.jones@email.com'
ON DUPLICATE KEY UPDATE skills = VALUES(skills), education = VALUES(education), experience = VALUES(experience), preferred_job_type = VALUES(preferred_job_type), preferred_location = VALUES(preferred_location), expected_salary = VALUES(expected_salary);

-- Jobs
INSERT INTO jobs (title, description, requirements, responsibilities, job_type, experience_level, salary_min, salary_max, location, industry, company_id, posted_by, status, posted_date, closing_date, is_active)
SELECT 'Senior Software Engineer', 'Build and maintain enterprise Java applications for regional clients.', 'Java, Spring Boot, MySQL, REST APIs, 5+ years experience', 'Design services, review code, mentor junior developers, coordinate releases.', 'FULL_TIME', 'SENIOR', 180000, 280000, 'Colombo', 'Technology',
(SELECT id FROM companies WHERE name = 'TechCorp Lanka'), (SELECT id FROM users WHERE email = 'hiring@techcorp.lk'), 'ACTIVE', CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 30 DAY), TRUE
WHERE NOT EXISTS (SELECT 1 FROM jobs WHERE title = 'Senior Software Engineer' AND company_id = (SELECT id FROM companies WHERE name = 'TechCorp Lanka'));

INSERT INTO jobs (title, description, requirements, responsibilities, job_type, experience_level, salary_min, salary_max, location, industry, company_id, posted_by, status, posted_date, closing_date, is_active)
SELECT 'Frontend Developer', 'Create responsive user interfaces for recruitment and HR products.', 'React, TypeScript, HTML, CSS, 3+ years experience', 'Build reusable components, improve performance, collaborate with designers.', 'FULL_TIME', 'MID_LEVEL', 120000, 190000, 'Colombo', 'Technology',
(SELECT id FROM companies WHERE name = 'Innovate Lanka'), (SELECT id FROM users WHERE email = 'recruitment@innovate.lk'), 'ACTIVE', CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 21 DAY), TRUE
WHERE NOT EXISTS (SELECT 1 FROM jobs WHERE title = 'Frontend Developer' AND company_id = (SELECT id FROM companies WHERE name = 'Innovate Lanka'));

INSERT INTO jobs (title, description, requirements, responsibilities, job_type, experience_level, salary_min, salary_max, location, industry, company_id, posted_by, status, posted_date, closing_date, is_active)
SELECT 'DevOps Engineer', 'Manage cloud infrastructure and automated deployment pipelines.', 'AWS, Docker, Kubernetes, CI/CD, Linux, 4+ years experience', 'Maintain cloud environments, automate deployments, monitor reliability.', 'FULL_TIME', 'SENIOR', 200000, 320000, 'Kandy', 'Cloud Infrastructure',
(SELECT id FROM companies WHERE name = 'Digital Solutions'), (SELECT id FROM users WHERE email = 'hr@digital.lk'), 'ACTIVE', CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 25 DAY), TRUE
WHERE NOT EXISTS (SELECT 1 FROM jobs WHERE title = 'DevOps Engineer' AND company_id = (SELECT id FROM companies WHERE name = 'Digital Solutions'));

INSERT INTO jobs (title, description, requirements, responsibilities, job_type, experience_level, salary_min, salary_max, location, industry, company_id, posted_by, status, posted_date, closing_date, is_active)
SELECT 'UI UX Designer', 'Design clean and accessible digital experiences for web applications.', 'Figma, UX research, wireframing, prototyping, design systems', 'Create wireframes, test prototypes, work with product and engineering teams.', 'CONTRACT', 'MID_LEVEL', 100000, 160000, 'Galle', 'Design',
(SELECT id FROM companies WHERE name = 'Digital Solutions'), (SELECT id FROM users WHERE email = 'hr@digital.lk'), 'ACTIVE', CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 18 DAY), TRUE
WHERE NOT EXISTS (SELECT 1 FROM jobs WHERE title = 'UI UX Designer' AND company_id = (SELECT id FROM companies WHERE name = 'Digital Solutions'));

INSERT INTO jobs (title, description, requirements, responsibilities, job_type, experience_level, salary_min, salary_max, location, industry, company_id, posted_by, status, posted_date, closing_date, is_active)
SELECT 'Junior QA Analyst', 'Support manual and automated testing for web products.', 'Testing fundamentals, bug reporting, basic SQL, attention to detail', 'Write test cases, execute regression tests, report defects.', 'FULL_TIME', 'ENTRY_LEVEL', 70000, 110000, 'Colombo', 'Quality Assurance',
(SELECT id FROM companies WHERE name = 'Talent Hub'), (SELECT id FROM users WHERE email = 'cre@techcorp.lk'), 'PENDING', CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 28 DAY), FALSE
WHERE NOT EXISTS (SELECT 1 FROM jobs WHERE title = 'Junior QA Analyst' AND company_id = (SELECT id FROM companies WHERE name = 'Talent Hub'));

-- Applications
INSERT INTO job_applications (job_id, applicant_id, cover_letter, additional_notes, status, applied_date, reviewed_date, reviewed_by, rejection_reason, is_active)
SELECT j.id, u.id, 'I am excited to apply for this backend role. My Spring Boot and API experience aligns closely with your requirements.', 'Available for interviews on weekdays.', 'SHORTLISTED', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY), r.id, NULL, TRUE
FROM jobs j, users u, users r
WHERE j.title = 'Senior Software Engineer' AND u.email = 'john.doe@email.com' AND r.email = 'hiring@techcorp.lk'
ON DUPLICATE KEY UPDATE status = VALUES(status), reviewed_date = VALUES(reviewed_date), reviewed_by = VALUES(reviewed_by);

INSERT INTO job_applications (job_id, applicant_id, cover_letter, additional_notes, status, applied_date, reviewed_date, reviewed_by, rejection_reason, is_active)
SELECT j.id, u.id, 'I have strong React and TypeScript experience and would like to contribute to this product team.', 'Portfolio available on request.', 'REVIEWING', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY), NULL, NULL, NULL, TRUE
FROM jobs j, users u
WHERE j.title = 'Frontend Developer' AND u.email = 'jane.smith@email.com'
ON DUPLICATE KEY UPDATE status = VALUES(status), additional_notes = VALUES(additional_notes);

INSERT INTO job_applications (job_id, applicant_id, cover_letter, additional_notes, status, applied_date, reviewed_date, reviewed_by, rejection_reason, is_active)
SELECT j.id, u.id, 'My AWS and Kubernetes experience makes me a good fit for this DevOps position.', 'AWS Solutions Architect Associate certified.', 'INTERVIEW_SCHEDULED', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 6 DAY), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY), r.id, NULL, TRUE
FROM jobs j, users u, users r
WHERE j.title = 'DevOps Engineer' AND u.email = 'mike.wilson@email.com' AND r.email = 'hr@digital.lk'
ON DUPLICATE KEY UPDATE status = VALUES(status), reviewed_date = VALUES(reviewed_date), reviewed_by = VALUES(reviewed_by);

INSERT INTO job_applications (job_id, applicant_id, cover_letter, additional_notes, status, applied_date, reviewed_date, reviewed_by, rejection_reason, is_active)
SELECT j.id, u.id, 'I have designed SaaS dashboards and mobile-first workflows similar to your product requirements.', 'Can share case studies during interview.', 'REJECTED', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 8 DAY), DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY), r.id, 'Portfolio experience did not match the current product domain.', TRUE
FROM jobs j, users u, users r
WHERE j.title = 'UI UX Designer' AND u.email = 'sarah.jones@email.com' AND r.email = 'hr@digital.lk'
ON DUPLICATE KEY UPDATE status = VALUES(status), reviewed_date = VALUES(reviewed_date), reviewed_by = VALUES(reviewed_by), rejection_reason = VALUES(rejection_reason);

-- Interviews
INSERT INTO interviews (application_id, interviewer_id, scheduled_date, duration_minutes, location, meeting_link, panel_info, interview_type, status, notes, feedback, created_date, updated_date)
SELECT ja.id, r.id, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 3 DAY), 60, 'TechCorp Lanka, Colombo 03', NULL, 'Anjali Fernando - Hiring Manager\nSenior Engineer - Technical Panel', 'IN_PERSON', 'SCHEDULED', 'Bring portfolio or recent project examples.', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM job_applications ja
JOIN jobs j ON ja.job_id = j.id
JOIN users u ON ja.applicant_id = u.id
JOIN users r ON r.email = 'hiring@techcorp.lk'
WHERE j.title = 'Senior Software Engineer' AND u.email = 'john.doe@email.com'
  AND NOT EXISTS (SELECT 1 FROM interviews i WHERE i.application_id = ja.id);

INSERT INTO interviews (application_id, interviewer_id, scheduled_date, duration_minutes, location, meeting_link, panel_info, interview_type, status, notes, feedback, created_date, updated_date)
SELECT ja.id, r.id, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 45, NULL, 'https://meet.example.com/devops-demo', 'Madhavi Jayasinghe - HR\nCloud Lead - Technical Interview', 'VIDEO', 'SCHEDULED', 'Prepare to discuss CI/CD pipeline design.', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM job_applications ja
JOIN jobs j ON ja.job_id = j.id
JOIN users u ON ja.applicant_id = u.id
JOIN users r ON r.email = 'hr@digital.lk'
WHERE j.title = 'DevOps Engineer' AND u.email = 'mike.wilson@email.com'
  AND NOT EXISTS (SELECT 1 FROM interviews i WHERE i.application_id = ja.id);

-- Notifications
INSERT INTO notifications (recipient_id, title, message, type, is_read, created_at)
SELECT id, 'Welcome to LankaJobsHub', 'Your demo account is ready. Explore jobs, applications, interviews, and notifications.', 'SYSTEM', FALSE, CURRENT_TIMESTAMP
FROM users
WHERE email IN ('john.doe@email.com', 'jane.smith@email.com', 'mike.wilson@email.com', 'sarah.jones@email.com');

INSERT INTO notifications (recipient_id, title, message, type, is_read, created_at)
SELECT u.id, 'Interview scheduled', 'Your interview for DevOps Engineer has been scheduled. Check the Interviews page for details.', 'INTERVIEW', FALSE, CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'mike.wilson@email.com';

INSERT INTO notifications (recipient_id, title, message, type, is_read, created_at)
SELECT u.id, 'New application received', 'John Doe applied for Senior Software Engineer.', 'APPLICATION', FALSE, CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'hiring@techcorp.lk';

-- Notification templates
INSERT INTO notification_templates (name, title, message, type, status, scheduled_at, updated_by, created_at, updated_at)
SELECT 'Interview Reminder', 'Upcoming interview reminder', 'Reminder: You have an interview scheduled soon. Please review the interview details in your LankaJobsHub account.', 'INTERVIEW', 'SCHEDULED', DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), u.id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'admin@lankajobshub.com'
  AND NOT EXISTS (SELECT 1 FROM notification_templates WHERE name = 'Interview Reminder');

INSERT INTO notification_templates (name, title, message, type, status, scheduled_at, updated_by, created_at, updated_at)
SELECT 'Application Status Draft', 'Application status update', 'Your application status has changed. Log in to LankaJobsHub to review the latest update.', 'APPLICATION', 'DRAFT', NULL, u.id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM users u
WHERE u.email = 'admin@lankajobshub.com'
  AND NOT EXISTS (SELECT 1 FROM notification_templates WHERE name = 'Application Status Draft');
