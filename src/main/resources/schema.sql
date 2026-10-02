-- Create database if not exists
CREATE DATABASE IF NOT EXISTS `LankaJobsHub.com`;
USE `LankaJobsHub.com`;

-- Users table
CREATE TABLE IF NOT EXISTS `users` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('ADMIN', 'CLIENT_RELATIONS_EXECUTIVE', 'COMPANY_HIRING_MANAGER', 'RECRUITMENT_MANAGER', 'HR_ASSISTANT', 'JOB_SEEKER') NOT NULL,
  `status` ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED', 'DELETED') NOT NULL DEFAULT 'ACTIVE',
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  `phone_number` VARCHAR(20),
  `profile_photo_path` VARCHAR(255),
  `bio` TEXT,
  `full_name` VARCHAR(100),
  `resume_path` VARCHAR(255),
  `linkedin_url` VARCHAR(255),
  `github_url` VARCHAR(255),
  `last_login` TIMESTAMP NULL,
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_user_email` (`email`),
  INDEX `idx_user_role` (`role`)
);

-- Companies table
CREATE TABLE IF NOT EXISTS `companies` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `address` VARCHAR(255),
  `contact_person` VARCHAR(100),
  `phone_number` VARCHAR(20),
  `website_url` VARCHAR(255),
  `logo_path` VARCHAR(255),
  `status` ENUM('ACTIVE', 'INACTIVE', 'PENDING', 'SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_company_name` (`name`),
  INDEX `idx_company_status` (`status`)
);

-- Jobs table
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `requirements` TEXT,
  `responsibilities` TEXT,
  `job_type` ENUM('FULL_TIME', 'PART_TIME', 'CONTRACT', 'INTERNSHIP', 'FREELANCE', 'TEMPORARY') NOT NULL,
  `experience_level` ENUM('ENTRY_LEVEL', 'JUNIOR', 'MID_LEVEL', 'SENIOR', 'LEAD', 'MANAGER', 'DIRECTOR', 'EXECUTIVE') NOT NULL,
  `salary_min` DECIMAL(12,2),
  `salary_max` DECIMAL(12,2),
  `location` VARCHAR(100),
  `industry` VARCHAR(100),
  `company_id` BIGINT NOT NULL,
  `posted_by` BIGINT NOT NULL,
  `status` ENUM('ACTIVE', 'INACTIVE', 'PENDING', 'CLOSED', 'DRAFT') NOT NULL DEFAULT 'ACTIVE',
  `posted_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `closing_date` TIMESTAMP NULL,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  INDEX `idx_job_title` (`title`),
  INDEX `idx_job_location` (`location`),
  INDEX `idx_job_type` (`job_type`),
  INDEX `idx_job_experience` (`experience_level`),
  INDEX `idx_job_status` (`status`),
  INDEX `idx_job_company` (`company_id`),
  INDEX `idx_job_posted_date` (`posted_date`)
);

-- Candidates table (extends users for job seekers)
CREATE TABLE IF NOT EXISTS `candidates` (
  `id` BIGINT PRIMARY KEY,
  `resume_path` VARCHAR(255),
  `skills` TEXT,
  `education` TEXT,
  `experience` TEXT,
  `preferred_job_type` ENUM('FULL_TIME', 'PART_TIME', 'CONTRACT', 'INTERNSHIP', 'FREELANCE', 'TEMPORARY'),
  `preferred_location` VARCHAR(100),
  `expected_salary` DECIMAL(12,2),
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

-- Job Applications table
CREATE TABLE IF NOT EXISTS `job_applications` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `job_id` BIGINT NOT NULL,
  `applicant_id` BIGINT NOT NULL,
  `cover_letter` TEXT,
  `additional_notes` TEXT,
  `status` ENUM('PENDING', 'REVIEWING', 'SHORTLISTED', 'INTERVIEW_SCHEDULED', 'INTERVIEWED', 'OFFERED', 'ACCEPTED', 'REJECTED', 'WITHDRAWN') NOT NULL DEFAULT 'PENDING',
  `applied_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_date` TIMESTAMP NULL DEFAULT NULL,
  `reviewed_by` BIGINT NULL,
  `rejection_reason` TEXT,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`applicant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  UNIQUE KEY `unique_application` (`job_id`, `applicant_id`),
  INDEX `idx_application_status` (`status`),
  INDEX `idx_application_date` (`applied_date`)
);

-- Interviews table
CREATE TABLE IF NOT EXISTS `interviews` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `application_id` BIGINT NOT NULL,
  `interviewer_id` BIGINT NOT NULL,
  `scheduled_date` DATETIME NOT NULL,
  `duration_minutes` INT NOT NULL DEFAULT 60,
  `location` VARCHAR(255),
  `meeting_link` VARCHAR(255),
  `panel_info` TEXT,
  `interview_type` ENUM('IN_PERSON', 'PHONE', 'VIDEO') NOT NULL,
  `status` ENUM('SCHEDULED', 'COMPLETED', 'CANCELLED', 'RESCHEDULED') NOT NULL DEFAULT 'SCHEDULED',
  `notes` TEXT,
  `feedback` TEXT,
  `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`application_id`) REFERENCES `job_applications` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`interviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  INDEX `idx_interview_date` (`scheduled_date`),
  INDEX `idx_interview_status` (`status`)
);

-- Notifications table
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `recipient_id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `message` TEXT NOT NULL,
  `type` ENUM('APPLICATION', 'INTERVIEW', 'SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  `is_read` BOOLEAN NOT NULL DEFAULT FALSE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  INDEX `idx_notification_recipient` (`recipient_id`),
  INDEX `idx_notification_created_at` (`created_at`),
  INDEX `idx_notification_read` (`is_read`)
);

-- Notification Templates table
CREATE TABLE IF NOT EXISTS `notification_templates` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `message` TEXT NOT NULL,
  `type` ENUM('APPLICATION', 'INTERVIEW', 'SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  `status` ENUM('DRAFT', 'PENDING', 'SCHEDULED') NOT NULL DEFAULT 'DRAFT',
  `scheduled_at` DATETIME NULL,
  `updated_by` BIGINT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  INDEX `idx_notification_template_status` (`status`),
  INDEX `idx_notification_template_type` (`type`)
);
