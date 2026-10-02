package com.lankajobshub.config;

import com.lankajobshub.model.User;
import com.lankajobshub.model.Company;
import com.lankajobshub.model.Job;
import com.lankajobshub.model.JobStatus;
import com.lankajobshub.model.JobType;
import com.lankajobshub.model.ExperienceLevel;
import com.lankajobshub.model.JobApplication;
import com.lankajobshub.model.UserRole;
import com.lankajobshub.model.UserStatus;
import com.lankajobshub.repository.JobApplicationRepository;
import com.lankajobshub.repository.JobRepository;
import com.lankajobshub.repository.UserRepository;
import com.lankajobshub.repository.CompanyRepository;
import com.lankajobshub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UserService userService;
    private final UserRepository userRepository;
    private final JobRepository jobRepository;
    private final JobApplicationRepository jobApplicationRepository;
    private final CompanyRepository companyRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public DataInitializer(
            UserService userService,
            UserRepository userRepository,
            JobRepository jobRepository,
            JobApplicationRepository jobApplicationRepository,
            CompanyRepository companyRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.userService = userService;
        this.userRepository = userRepository;
        this.jobRepository = jobRepository;
        this.jobApplicationRepository = jobApplicationRepository;
        this.companyRepository = companyRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) throws Exception {
        ensureAdminUser();
        purgeNonJobSeekersExceptAdmin();
        seedDemoData();
        removeOrphanCompanies();
    }

    private void ensureAdminUser() {
        String adminEmail = "admin@lankajobshub.com";
        User existing = userService.findByEmail(adminEmail).orElse(null);
        if (existing == null) {
            User admin = new User();
            admin.setEmail(adminEmail);
            admin.setPassword(passwordEncoder.encode("admin123"));
            admin.setRole(UserRole.ADMIN);
            admin.setStatus(UserStatus.ACTIVE);
            userRepository.save(admin);
        } else {
            boolean needsPasswordReset = !passwordEncoder.matches("admin123", existing.getPassword());
            if (needsPasswordReset || existing.getRole() != UserRole.ADMIN || existing.getStatus() != UserStatus.ACTIVE) {
                existing.setRole(UserRole.ADMIN);
                existing.setStatus(UserStatus.ACTIVE);
                if (needsPasswordReset) {
                    existing.setPassword(passwordEncoder.encode("admin123"));
                }
                userRepository.save(existing);
            }
        }
    }

    private void purgeNonJobSeekersExceptAdmin() {
        String adminEmail = "admin@lankajobshub.com";

        List<User> users = userRepository.findAll();
        for (User user : users) {
            if (adminEmail.equalsIgnoreCase(user.getEmail())) {
                continue; // keep admin
            }
            if (user.getRole() != UserRole.JOB_SEEKER) {
                // Clean dependent data first to avoid FK issues
                jobApplicationRepository.findByApplicantId(user.getId())
                        .forEach(app -> jobApplicationRepository.deleteById(app.getId()));

                jobRepository.findByPostedById(user.getId())
                        .forEach(job -> jobRepository.deleteById(job.getId()));

                // Finally delete the user
                userRepository.deleteById(user.getId());
            }
        }
    }

    private void removeOrphanCompanies() {
        // Companies are removed automatically due to FK ON DELETE CASCADE from jobs in schema.sql
        // If JPA created schema without cascade, you may need a repository call to delete companies without jobs.
        // Skipping explicit delete here to avoid accidental data loss.
    }

    private void seedDemoData() {
        // If there are already jobs, skip seeding
        if (jobRepository.count() > 0) {
            return;
        }

        User admin = userService.findByEmail("admin@lankajobshub.com").orElse(null);
        if (admin == null) {
            return;
        }

        // Ensure at least one JOB_SEEKER exists for applications
        List<User> seekers = userRepository.findByRole(UserRole.JOB_SEEKER);
        User sampleSeeker = seekers.stream().findFirst().orElseGet(() -> {
            User u = new User();
            u.setEmail("seeker@example.com");
            u.setPassword(passwordEncoder.encode("user12345"));
            u.setRole(UserRole.JOB_SEEKER);
            u.setStatus(UserStatus.ACTIVE);
            return userRepository.save(u);
        });

        // Create company
        Company company = companyRepository.findByName("LankaJobsHub Tech").orElseGet(() -> {
            Company c = new Company();
            c.setName("LankaJobsHub Tech");
            c.setContactPerson("Admin Team");
            return companyRepository.save(c);
        });

        // Create a few jobs (ACTIVE + active=true) posted by admin
        Job j1 = new Job();
        j1.setTitle("Senior Java Developer");
        j1.setDescription("Build and maintain Spring Boot services.");
        j1.setRequirements("Java, Spring Boot, MySQL");
        j1.setResponsibilities("Develop features, write tests, review code");
        j1.setJobType(JobType.FULL_TIME);
        j1.setExperienceLevel(ExperienceLevel.SENIOR);
        j1.setLocation("Colombo");
        j1.setIndustry("Technology");
        j1.setCompany(company);
        j1.setPostedBy(admin);
        j1.setStatus(JobStatus.ACTIVE);
        j1.setActive(true);
        jobRepository.save(j1);

        Job j2 = new Job();
        j2.setTitle("Frontend Engineer");
        j2.setDescription("React/TypeScript UI work.");
        j2.setRequirements("React, TypeScript, CSS");
        j2.setResponsibilities("Implement UI components, collaborate with backend");
        j2.setJobType(JobType.FULL_TIME);
        j2.setExperienceLevel(ExperienceLevel.MID_LEVEL);
        j2.setLocation("Kandy");
        j2.setIndustry("Technology");
        j2.setCompany(company);
        j2.setPostedBy(admin);
        j2.setStatus(JobStatus.ACTIVE);
        j2.setActive(true);
        jobRepository.save(j2);

        // Create one application for visibility
        JobApplication app = new JobApplication();
        app.setJob(j1);
        app.setApplicant(sampleSeeker);
        app.setCoverLetter("Excited to apply for Senior Java Developer.");
        app.setAdditionalNotes("Available immediately.");
        jobApplicationRepository.save(app);
    }
}
