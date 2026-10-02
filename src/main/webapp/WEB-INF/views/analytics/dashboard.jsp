<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics Dashboard - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
    <style>
        .chart-container {
            position: relative;
            height: 400px;
            width: 100%;
        }
    </style>
</head>
<body class="management-shell">
    <nav class="sticky top-0 z-40 border-b border-slate-200 bg-white/95 backdrop-blur">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="flex items-center">
                    <a href="/lankajobshub/" class="flex items-center gap-3 focus-ring rounded-lg">
                        <img src="/lankajobshub/static/images/lankajobshub-logo.svg" alt="LankaJobsHub logo" class="h-11 w-11 rounded-xl shadow-lg shadow-blue-200">
                        <span class="hidden sm:block text-xl font-bold text-slate-950">LankaJobsHub</span>
                    </a>
                </div>
                <div class="flex items-center gap-2 sm:gap-3">
                    <a href="/lankajobshub/dashboard" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Dashboard</a>
                    <a href="/lankajobshub/users/profile" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring"><c:choose><c:when test="${not empty user.fullName}">${user.fullName}</c:when><c:otherwise>Profile</c:otherwise></c:choose></a>
                    <a href="/lankajobshub/users/logout" class="ui-btn-secondary focus-ring px-4 py-2">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="workspace-nav mb-8">
            <a href="/lankajobshub/dashboard" class="workspace-nav-link focus-ring">Dashboard</a>
            <a href="/lankajobshub/analytics/dashboard" class="workspace-nav-link active focus-ring">Analytics</a>
            <c:if test="${user.role == 'ADMIN'}">
                <a href="/lankajobshub/users/admin" class="workspace-nav-link focus-ring">Users</a>
            </c:if>
            <a href="/lankajobshub/jobs" class="workspace-nav-link focus-ring">Jobs</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
        </div>

        <div class="mb-8">
            <p class="text-sm font-bold uppercase tracking-[0.18em] text-blue-700">Platform Insights</p>
            <h1 class="mt-3 text-3xl lg:text-4xl font-black tracking-tight text-slate-950">Analytics Dashboard</h1>
            <p class="mt-3 max-w-3xl text-slate-500">Comprehensive insights and performance metrics for <c:choose><c:when test="${not empty user.fullName}">${user.fullName}</c:when><c:otherwise>${user.role.displayName}</c:otherwise></c:choose>.</p>
        </div>

        <!-- Summary Stats -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="management-stat">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2-2v2m8 0V6a2 2 0 012 2v6a2 2 0 01-2 2H8a2 2 0 01-2-2V8a2 2 0 012-2V6"></path>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-semibold text-slate-500">Total Jobs</p>
                        <p class="text-3xl font-bold text-blue-700" id="totalJobs">-</p>
                    </div>
                </div>
            </div>

            <div class="management-stat">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-green-100 text-green-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-semibold text-slate-500">Applications</p>
                        <p class="text-3xl font-bold text-blue-700" id="totalApplications">-</p>
                    </div>
                </div>
            </div>

            <div class="management-stat">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-purple-100 text-purple-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-semibold text-slate-500">Users</p>
                        <p class="text-3xl font-bold text-blue-700" id="totalUsers">-</p>
                    </div>
                </div>
            </div>

            <div class="management-stat">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-yellow-100 text-yellow-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-semibold text-slate-500">Pending</p>
                        <p class="text-3xl font-bold text-blue-700" id="pendingApplications">-</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
            <!-- Jobs by Status Chart -->
            <div class="ui-card rounded-3xl bg-white p-6">
                <h3 class="text-lg font-bold text-slate-950 mb-4">Jobs by Status</h3>
                <div class="chart-container">
                    <canvas id="jobsByStatusChart"></canvas>
                </div>
            </div>

            <!-- Applications by Status Chart -->
            <div class="ui-card rounded-3xl bg-white p-6">
                <h3 class="text-lg font-bold text-slate-950 mb-4">Applications by Status</h3>
                <div class="chart-container">
                    <canvas id="applicationsByStatusChart"></canvas>
                </div>
            </div>

            <!-- Users by Role Chart -->
            <div class="ui-card rounded-3xl bg-white p-6">
                <h3 class="text-lg font-bold text-slate-950 mb-4">Users by Role</h3>
                <div class="chart-container">
                    <canvas id="usersByRoleChart"></canvas>
                </div>
            </div>

            <!-- Applications Over Time Chart -->
            <div class="ui-card rounded-3xl bg-white p-6">
                <h3 class="text-lg font-bold text-slate-950 mb-4">Applications Over Time</h3>
                <div class="chart-container">
                    <canvas id="applicationsOverTimeChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Role-specific Content -->
        <c:choose>
            <c:when test="${user.role == 'ADMIN'}">
                <div class="ui-card rounded-3xl bg-white p-6">
                    <h3 class="text-lg font-bold text-slate-950 mb-4">System Overview</h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="text-center">
                            <div class="text-3xl font-bold text-blue-600" id="activeJobs">-</div>
                            <div class="text-sm text-slate-500">Active Jobs</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-green-600" id="recentJobs">-</div>
                            <div class="text-sm text-slate-500">Recent Jobs (30 days)</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-purple-600" id="recentUsers">-</div>
                            <div class="text-sm text-slate-500">Recent Users (30 days)</div>
                        </div>
                    </div>
                </div>
            </c:when>
            
            <c:when test="${user.role == 'JOB_SEEKER'}">
                <div class="ui-card rounded-3xl bg-white p-6">
                    <h3 class="text-lg font-bold text-slate-950 mb-4">My Application Status</h3>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div class="text-center p-4 bg-blue-50 rounded-lg">
                            <div class="text-2xl font-bold text-blue-600" id="myApplications">-</div>
                            <div class="text-sm text-gray-600">Total Applications</div>
                        </div>
                        <div class="text-center p-4 bg-yellow-50 rounded-lg">
                            <div class="text-2xl font-bold text-yellow-600" id="pendingMyApplications">-</div>
                            <div class="text-sm text-gray-600">Pending</div>
                        </div>
                        <div class="text-center p-4 bg-green-50 rounded-lg">
                            <div class="text-2xl font-bold text-green-600" id="shortlistedMyApplications">-</div>
                            <div class="text-sm text-gray-600">Shortlisted</div>
                        </div>
                        <div class="text-center p-4 bg-red-50 rounded-lg">
                            <div class="text-2xl font-bold text-red-600" id="rejectedMyApplications">-</div>
                            <div class="text-sm text-gray-600">Rejected</div>
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>
    </div>

    <script>
        // Load analytics data
        async function loadAnalyticsData() {
            try {
                const [summary, jobs, applications, users] = await Promise.all([
                    fetch('/lankajobshub/analytics/api/dashboard-summary').then(r => r.json()),
                    fetch('/lankajobshub/analytics/api/job-analytics').then(r => r.json()),
                    fetch('/lankajobshub/analytics/api/application-analytics').then(r => r.json()),
                    fetch('/lankajobshub/analytics/api/user-analytics').then(r => r.json())
                ]);

                // Update summary stats
                document.getElementById('totalJobs').textContent = summary.totalJobs || 0;
                document.getElementById('totalApplications').textContent = summary.totalApplications || 0;
                document.getElementById('totalUsers').textContent = summary.totalUsers || 0;
                document.getElementById('pendingApplications').textContent = summary.pendingApplications || 0;

                // Create charts
                createJobsByStatusChart(jobs.jobsByStatus);
                createApplicationsByStatusChart(applications.applicationsByStatus);
                createUsersByRoleChart(users.usersByRole);
                createApplicationsOverTimeChart(applications.applicationsByDay);

                // Role-specific updates
                if ('${user.role}' === 'ADMIN') {
                    document.getElementById('activeJobs').textContent = summary.activeJobs || 0;
                    document.getElementById('recentJobs').textContent = jobs.recentJobs || 0;
                    document.getElementById('recentUsers').textContent = users.recentUsers || 0;
                }

            } catch (error) {
                console.error('Error loading analytics data:', error);
            }
        }

        function createJobsByStatusChart(data) {
            const ctx = document.getElementById('jobsByStatusChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: Object.keys(data),
                    datasets: [{
                        data: Object.values(data),
                        backgroundColor: [
                            '#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#06B6D4'
                        ],
                        borderWidth: 2,
                        borderColor: '#fff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    },
                    animation: {
                        animateRotate: true,
                        animateScale: true
                    }
                }
            });
        }

        function createApplicationsByStatusChart(data) {
            const ctx = document.getElementById('applicationsByStatusChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: Object.keys(data),
                    datasets: [{
                        label: 'Applications',
                        data: Object.values(data),
                        backgroundColor: [
                            '#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#06B6D4', '#F97316', '#EC4899'
                        ],
                        borderWidth: 1,
                        borderColor: '#fff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    animation: {
                        duration: 2000,
                        easing: 'easeInOutQuart'
                    }
                }
            });
        }

        function createUsersByRoleChart(data) {
            const ctx = document.getElementById('usersByRoleChart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: Object.keys(data),
                    datasets: [{
                        data: Object.values(data),
                        backgroundColor: [
                            '#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#06B6D4'
                        ],
                        borderWidth: 2,
                        borderColor: '#fff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    },
                    animation: {
                        animateRotate: true,
                        animateScale: true
                    }
                }
            });
        }

        function createApplicationsOverTimeChart(data) {
            const ctx = document.getElementById('applicationsOverTimeChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Object.keys(data),
                    datasets: [{
                        label: 'Applications',
                        data: Object.values(data),
                        borderColor: '#3B82F6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    animation: {
                        duration: 2000,
                        easing: 'easeInOutQuart'
                    }
                }
            });
        }

        // Load data when page loads
        document.addEventListener('DOMContentLoaded', loadAnalyticsData);

        // Refresh data every 5 minutes
        setInterval(loadAnalyticsData, 300000);
    </script>
</body>
</html>
