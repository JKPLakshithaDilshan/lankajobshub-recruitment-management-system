package com.lankajobshub.service;

import com.lankajobshub.model.*;
import com.lankajobshub.model.Company.CompanyStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AnalyticsService {

    @Autowired
    private JobService jobService;

    @Autowired
    private JobApplicationService applicationService;

    @Autowired
    private UserService userService;

    // Job Analytics
    public Map<String, Object> getJobAnalytics() {
        Map<String, Object> analytics = new HashMap<>();
        
        // Total jobs by status
        Map<String, Long> jobsByStatus = new HashMap<>();
        for (JobStatus status : JobStatus.values()) {
            jobsByStatus.put(status.name(), (long) jobService.findByStatus(status).size());
        }
        analytics.put("jobsByStatus", jobsByStatus);

        // Jobs by experience level
        Map<String, Long> jobsByExperience = new HashMap<>();
        for (ExperienceLevel level : ExperienceLevel.values()) {
            jobsByExperience.put(level.name(), (long) jobService.findByExperienceLevel(level).size());
        }
        analytics.put("jobsByExperience", jobsByExperience);

        // Jobs by type
        Map<String, Long> jobsByType = new HashMap<>();
        for (JobType type : JobType.values()) {
            jobsByType.put(type.name(), (long) jobService.findByJobType(type).size());
        }
        analytics.put("jobsByType", jobsByType);

        // Recent job postings (last 30 days)
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);
        List<Job> allJobs = jobService.findAllActiveJobs();
        List<Job> recentJobs = allJobs.stream()
                .filter(job -> job.getPostedDate() != null && job.getPostedDate().isAfter(thirtyDaysAgo))
                .collect(Collectors.toList());
        analytics.put("recentJobs", recentJobs.size());

        return analytics;
    }

    // Application Analytics
    public Map<String, Object> getApplicationAnalytics() {
        Map<String, Object> analytics = new HashMap<>();
        
        // Applications by status
        Map<String, Long> applicationsByStatus = new HashMap<>();
        for (ApplicationStatus status : ApplicationStatus.values()) {
            applicationsByStatus.put(status.name(), (long) applicationService.findByStatus(status).size());
        }
        analytics.put("applicationsByStatus", applicationsByStatus);

        // Applications over time (last 7 days)
        LocalDateTime sevenDaysAgo = LocalDateTime.now().minusDays(7);
        List<JobApplication> allApplications = applicationService.findRecentApplications();
        List<JobApplication> recentApplications = allApplications.stream()
                .filter(app -> app.getAppliedDate() != null && app.getAppliedDate().isAfter(sevenDaysAgo))
                .collect(Collectors.toList());
        
        // Group by day
        Map<String, Long> applicationsByDay = recentApplications.stream()
            .collect(Collectors.groupingBy(
                app -> app.getAppliedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")),
                Collectors.counting()
            ));
        analytics.put("applicationsByDay", applicationsByDay);

        // Top jobs by application count (simplified)
        Map<String, Long> topJobs = new HashMap<>();
        List<Job> allJobs = jobService.findAllActiveJobs();
        for (Job job : allJobs) {
            long count = applicationService.countApplicationsByJobId(job.getId());
            if (count > 0) {
                topJobs.put(job.getTitle(), count);
            }
        }
        analytics.put("topJobs", topJobs);

        return analytics;
    }

    // User Analytics
    public Map<String, Object> getUserAnalytics() {
        Map<String, Object> analytics = new HashMap<>();
        
        // Users by role
        Map<String, Long> usersByRole = new HashMap<>();
        for (UserRole role : UserRole.values()) {
            usersByRole.put(role.name(), (long) userService.findByRole(role).size());
        }
        analytics.put("usersByRole", usersByRole);

        // Users by status (simplified - count active users)
        Map<String, Long> usersByStatus = new HashMap<>();
        List<User> allUsers = userService.findAll();
        long activeUsers = allUsers.stream().filter(user -> user.getStatus() == UserStatus.ACTIVE).count();
        usersByStatus.put("ACTIVE", activeUsers);
        usersByStatus.put("INACTIVE", (long) allUsers.size() - activeUsers);
        analytics.put("usersByStatus", usersByStatus);

        // Recent user registrations (last 30 days)
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);
        List<User> recentUsers = allUsers.stream()
                .filter(user -> user.getCreatedDate() != null && user.getCreatedDate().isAfter(thirtyDaysAgo))
                .collect(Collectors.toList());
        analytics.put("recentUsers", recentUsers.size());

        return analytics;
    }

    // Company Analytics
    public Map<String, Object> getCompanyAnalytics() {
        Map<String, Object> analytics = new HashMap<>();
        
        // Companies by status (simplified)
        Map<String, Long> companiesByStatus = new HashMap<>();
        companiesByStatus.put("ACTIVE", 0L); // Placeholder
        analytics.put("companiesByStatus", companiesByStatus);

        return analytics;
    }

    // Dashboard Summary
    public Map<String, Object> getDashboardSummary() {
        Map<String, Object> summary = new HashMap<>();
        
        summary.put("totalJobs", (long) jobService.findAllActiveJobs().size());
        summary.put("totalApplications", applicationService.countAllApplications());
        summary.put("totalUsers", (long) userService.findAll().size());
        summary.put("activeJobs", (long) jobService.findByStatus(JobStatus.ACTIVE).size());
        summary.put("pendingApplications", (long) applicationService.findByStatus(ApplicationStatus.PENDING).size());
        
        return summary;
    }

    // Role-specific analytics
    public Map<String, Object> getRoleSpecificAnalytics(UserRole role, Long userId) {
        Map<String, Object> analytics = new HashMap<>();
        
        switch (role) {
            case ADMIN:
                analytics.putAll(getAdminAnalytics());
                break;
            case CLIENT_RELATIONS_EXECUTIVE:
                analytics.putAll(getClientRelationsAnalytics(userId));
                break;
            case COMPANY_HIRING_MANAGER:
                analytics.putAll(getHiringManagerAnalytics(userId));
                break;
            case RECRUITMENT_MANAGER:
                analytics.putAll(getRecruitmentManagerAnalytics(userId));
                break;
            case HR_ASSISTANT:
                analytics.putAll(getHRAssistantAnalytics(userId));
                break;
            case JOB_SEEKER:
                analytics.putAll(getJobSeekerAnalytics(userId));
                break;
        }
        
        return analytics;
    }

    private Map<String, Object> getAdminAnalytics() {
        Map<String, Object> analytics = new HashMap<>();
        analytics.putAll(getJobAnalytics());
        analytics.putAll(getUserAnalytics());
        analytics.putAll(getApplicationAnalytics());
        return analytics;
    }

    private Map<String, Object> getClientRelationsAnalytics(Long userId) {
        Map<String, Object> analytics = new HashMap<>();
        // Company-specific analytics
        return analytics;
    }

    private Map<String, Object> getHiringManagerAnalytics(Long userId) {
        Map<String, Object> analytics = new HashMap<>();
        // Jobs posted by this hiring manager
        List<Job> myJobs = jobService.findByPostedBy(userId);
        analytics.put("myJobs", myJobs.size());
        
        // Applications for my jobs
        long totalApplications = myJobs.stream()
            .mapToLong(job -> applicationService.countApplicationsByJobId(job.getId()))
            .sum();
        analytics.put("totalApplications", totalApplications);
        
        return analytics;
    }

    private Map<String, Object> getRecruitmentManagerAnalytics(Long userId) {
        Map<String, Object> analytics = new HashMap<>();
        // Similar to hiring manager but with more detailed metrics
        return analytics;
    }

    private Map<String, Object> getHRAssistantAnalytics(Long userId) {
        Map<String, Object> analytics = new HashMap<>();
        // Pending applications to process
        long pendingApplications = applicationService.countAllApplications(); // Simplified
        analytics.put("pendingApplications", pendingApplications);
        
        return analytics;
    }

    private Map<String, Object> getJobSeekerAnalytics(Long userId) {
        Map<String, Object> analytics = new HashMap<>();
        // My applications
        List<JobApplication> myApplications = applicationService.findByApplicantId(userId);
        analytics.put("myApplications", myApplications.size());
        
        // Applications by status
        Map<ApplicationStatus, Long> myApplicationsByStatus = myApplications.stream()
            .collect(Collectors.groupingBy(
                JobApplication::getStatus,
                Collectors.counting()
            ));
        analytics.put("myApplicationsByStatus", myApplicationsByStatus);
        
        return analytics;
    }
}
