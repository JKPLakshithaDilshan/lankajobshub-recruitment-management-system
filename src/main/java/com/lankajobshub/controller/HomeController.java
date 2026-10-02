package com.lankajobshub.controller;

import com.lankajobshub.service.JobService;
import com.lankajobshub.service.UserService;
import com.lankajobshub.service.JobApplicationService;
import com.lankajobshub.model.User;
import com.lankajobshub.model.Job;
import com.lankajobshub.model.JobApplication;
import com.lankajobshub.model.JobType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HomeController {

    @Autowired
    private JobService jobService;

    @Autowired
    private UserService userService;

    @Autowired
    private JobApplicationService applicationService;

    @GetMapping("/")
    public String home(Model model) {
        List<Job> activeJobs = jobService.findAllActiveJobs();
        Map<JobType, Long> jobTypeCounts = activeJobs.stream()
                .filter(job -> job.getJobType() != null)
                .collect(Collectors.groupingBy(Job::getJobType, Collectors.counting()));

        model.addAttribute("recentJobs", activeJobs.stream().limit(6).toList());
        model.addAttribute("totalJobs", activeJobs.size());
        model.addAttribute("totalApplications", applicationService.countAllApplications());
        model.addAttribute("totalUsers", userService.findAll().size());
        model.addAttribute("jobTypes", JobType.values());
        model.addAttribute("jobTypeCounts", jobTypeCounts);
        model.addAttribute("featuredCompanies", activeJobs.stream()
                .map(Job::getCompany)
                .filter(company -> company != null)
                .distinct()
                .limit(6)
                .toList());
        return "home";
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "Test endpoint working! LankaJobsHub is running successfully.";
    }

    @GetMapping("/test-data")
    @ResponseBody
    public String testData() {
        StringBuilder result = new StringBuilder();
        result.append("=== LankaJobsHub Data Test ===\n");
        result.append("Users: ").append(userService.findAll().size()).append("\n");
        result.append("Jobs: ").append(jobService.findAllActiveJobs().size()).append("\n");
        result.append("Applications: ").append(applicationService.countAllApplications()).append("\n");
        
        // Show some sample data
        result.append("\n=== Sample Users ===\n");
        userService.findAll().stream().limit(3).forEach(user -> 
            result.append("- ").append(user.getEmail()).append(" (").append(user.getRole()).append(")\n"));
        
        result.append("\n=== Sample Jobs ===\n");
        jobService.findAllActiveJobs().stream().limit(3).forEach(job -> 
            result.append("- ").append(job.getTitle()).append(" (").append(job.getStatus()).append(")\n"));
        
        return result.toString();
    }

    @GetMapping("/test-email")
    @ResponseBody
    public String testEmail() {
        StringBuilder result = new StringBuilder();
        result.append("=== Email Notification Test ===\n");
        
        // Test welcome email
        User testUser = userService.findAll().get(0);
        result.append("Sending welcome email to: ").append(testUser.getEmail()).append("\n");
        
        // Test job posted notification
        Job testJob = jobService.findAllActiveJobs().get(0);
        result.append("Sending job posted notification for: ").append(testJob.getTitle()).append("\n");
        
        // Test application notification
        if (!applicationService.findAll().isEmpty()) {
            JobApplication testApp = applicationService.findAll().get(0);
            result.append("Sending application notification for: ").append(testApp.getJob().getTitle()).append("\n");
        }
        
        result.append("\nCheck the application logs for email notifications.\n");
        return result.toString();
    }
} 
