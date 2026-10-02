package com.lankajobshub.controller;

import com.lankajobshub.model.User;
import com.lankajobshub.service.AnalyticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/analytics")
public class AnalyticsController {

    @Autowired
    private AnalyticsService analyticsService;

    @GetMapping("/dashboard")
    public String showAnalyticsDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }

        // Get role-specific analytics
        Map<String, Object> analytics = analyticsService.getRoleSpecificAnalytics(user.getRole(), user.getId());
        model.addAttribute("analytics", analytics);
        model.addAttribute("user", user);
        
        return "analytics/dashboard";
    }

    @GetMapping("/api/job-analytics")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getJobAnalytics() {
        Map<String, Object> analytics = analyticsService.getJobAnalytics();
        return ResponseEntity.ok(analytics);
    }

    @GetMapping("/api/application-analytics")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getApplicationAnalytics() {
        Map<String, Object> analytics = analyticsService.getApplicationAnalytics();
        return ResponseEntity.ok(analytics);
    }

    @GetMapping("/api/user-analytics")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getUserAnalytics() {
        Map<String, Object> analytics = analyticsService.getUserAnalytics();
        return ResponseEntity.ok(analytics);
    }

    @GetMapping("/api/company-analytics")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCompanyAnalytics() {
        Map<String, Object> analytics = analyticsService.getCompanyAnalytics();
        return ResponseEntity.ok(analytics);
    }

    @GetMapping("/api/dashboard-summary")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDashboardSummary() {
        Map<String, Object> summary = analyticsService.getDashboardSummary();
        return ResponseEntity.ok(summary);
    }
}
