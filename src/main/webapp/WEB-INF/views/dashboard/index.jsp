<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
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
                    <a href="/lankajobshub/jobs" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Browse Jobs</a>
                    <a href="/lankajobshub/analytics/dashboard" class="hidden md:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Analytics</a>
                    <a href="/lankajobshub/notifications" class="hidden md:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Notifications</a>
                    <a href="/lankajobshub/users/profile" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring"><c:choose><c:when test="${not empty user.fullName}">${user.fullName}</c:when><c:otherwise>Profile</c:otherwise></c:choose></a>
                    <a href="/lankajobshub/users/logout" class="ui-btn-secondary focus-ring px-4 py-2">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <c:if test="${user.role != 'JOB_SEEKER' && user.role != 'ADMIN'}">
            <div class="workspace-nav mb-8">
                <a href="/lankajobshub/dashboard" class="workspace-nav-link active focus-ring">Dashboard</a>
                <a href="/lankajobshub/jobs/my-jobs" class="workspace-nav-link focus-ring">My Vacancies</a>
                <a href="/lankajobshub/jobs/post" class="workspace-nav-link focus-ring">Post Job</a>
                <a href="/lankajobshub/interviews" class="workspace-nav-link focus-ring">Interviews</a>
                <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
                <a href="/lankajobshub/users/profile" class="workspace-nav-link focus-ring">Profile</a>
            </div>
        </c:if>
        <c:if test="${user.role == 'ADMIN'}">
            <div class="workspace-nav mb-8">
                <a href="/lankajobshub/dashboard" class="workspace-nav-link active focus-ring">Dashboard</a>
                <a href="/lankajobshub/users/admin" class="workspace-nav-link focus-ring">Users</a>
                <a href="/lankajobshub/analytics/dashboard" class="workspace-nav-link focus-ring">Analytics</a>
                <a href="/lankajobshub/jobs" class="workspace-nav-link focus-ring">Jobs</a>
                <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
            </div>
        </c:if>
        <!-- Welcome Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Welcome back, <c:choose><c:when test="${not empty user.fullName}">${user.fullName}</c:when><c:otherwise>${user.email}</c:otherwise></c:choose>!</h1>
            <p class="text-gray-600">Here's what's happening with your account.</p>
        </div>

        <!-- Stats Cards -->
        <c:if test="${user.role != 'ADMIN'}">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2-2v2m8 0V6a2 2 0 012 2v6a2 2 0 01-2 2H8a2 2 0 01-2-2V8a2 2 0 012-2V6"></path>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Total Jobs</p>
                        <p class="text-2xl font-semibold text-gray-900">${totalJobs}</p>
                    </div>
                </div>
            </div>

            <c:if test="${user.role == 'JOB_SEEKER'}">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-green-100 text-green-600">
                            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">My Applications</p>
                            <p class="text-2xl font-semibold text-gray-900">${totalApplications}</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${user.role == 'ADMIN'}">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-purple-100 text-purple-600">
                            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Total Users</p>
                            <p class="text-2xl font-semibold text-gray-900">${totalUsers}</p>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        </c:if>

        <!-- Role-based Content -->
        <c:choose>
            <c:when test="${user.role == 'ADMIN'}">
                <div class="grid md:grid-cols-3 gap-5 mb-8">
                    <div class="management-stat">
                        <p class="text-sm font-semibold text-slate-500">Total Jobs</p>
                        <p class="mt-2 text-3xl font-bold text-blue-700">${totalJobs}</p>
                    </div>
                    <div class="management-stat">
                        <p class="text-sm font-semibold text-slate-500">Total Users</p>
                        <p class="mt-2 text-3xl font-bold text-blue-700">${totalUsers}</p>
                    </div>
                    <div class="management-stat">
                        <p class="text-sm font-semibold text-slate-500">Pending Jobs</p>
                        <p class="mt-2 text-3xl font-bold text-blue-700">${totalPendingJobs}</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="ui-card rounded-3xl bg-white p-6">
                        <div class="flex items-center justify-between gap-4 mb-5">
                            <div>
                                <h3 class="text-xl font-bold text-slate-950">Recent Jobs</h3>
                                <p class="mt-1 text-sm text-slate-500">Latest vacancies visible to administrators.</p>
                            </div>
                            <a href="/lankajobshub/jobs" class="text-sm font-semibold text-blue-700 hover:text-blue-900 focus-ring rounded-lg">View all</a>
                        </div>
                        <div class="space-y-4">
                            <c:forEach items="${recentJobs}" var="job">
                                <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                                    <h4 class="font-semibold text-slate-950">${job.title}</h4>
                                    <p class="mt-1 text-sm text-slate-500">${job.location} • ${job.jobType.displayName}</p>
                                    <p class="mt-2 text-xs font-medium text-slate-400">Posted ${job.postedDate}</p>
                                </div>
                            </c:forEach>
                            <c:if test="${empty recentJobs}">
                                <div class="empty-state rounded-2xl p-6 text-center">No recent jobs to show.</div>
                            </c:if>
                        </div>
                    </div>

                    <div class="ui-card rounded-3xl bg-white p-6">
                        <div class="flex items-center justify-between gap-4 mb-5">
                            <div>
                                <h3 class="text-xl font-bold text-slate-950">Recent Users</h3>
                                <p class="mt-1 text-sm text-slate-500">Newest accounts created in the platform.</p>
                            </div>
                            <a href="/lankajobshub/users/admin" class="text-sm font-semibold text-blue-700 hover:text-blue-900 focus-ring rounded-lg">Manage</a>
                        </div>
                        <div class="space-y-4">
                            <c:forEach items="${recentUsers}" var="userItem">
                                <div class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
                                    <h4 class="font-semibold text-slate-950"><c:choose><c:when test="${not empty userItem.fullName}">${userItem.fullName}</c:when><c:otherwise>${userItem.email}</c:otherwise></c:choose></h4>
                                    <p class="mt-1 text-sm text-slate-500">${userItem.role.displayName}</p>
                                    <p class="mt-2 text-xs font-medium text-slate-400">Joined ${userItem.createdDate}</p>
                                </div>
                            </c:forEach>
                            <c:if test="${empty recentUsers}">
                                <div class="empty-state rounded-2xl p-6 text-center">No recent users to show.</div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="ui-card rounded-3xl bg-white p-6 mt-6">
                    <h3 class="text-xl font-bold text-slate-950">Admin Actions</h3>
                    <div class="mt-5 grid md:grid-cols-3 gap-4">
                        <a href="/lankajobshub/users/admin" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">Manage Users</p>
                            <p class="mt-1 text-sm text-slate-500">Review and remove user accounts</p>
                        </a>
                        <a href="/lankajobshub/users/create" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">Create User</p>
                            <p class="mt-1 text-sm text-slate-500">Add authorized team members</p>
                        </a>
                        <a href="/lankajobshub/analytics/dashboard" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">View Analytics</p>
                            <p class="mt-1 text-sm text-slate-500">Monitor platform activity</p>
                        </a>
                    </div>
                </div>
            </c:when>

            <c:when test="${user.role == 'JOB_SEEKER'}">
                <!-- Job Seeker Dashboard -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Available Jobs -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Recommended Jobs</h3>
                        <div class="space-y-4">
                            <c:forEach items="${availableJobs}" var="job">
                                <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                    <h4 class="font-medium text-gray-900">${job.title}</h4>
                                    <p class="text-sm text-gray-600">${job.location} • ${job.jobType.displayName}</p>
                                    <div class="flex items-center justify-between mt-2">
                                        <span class="text-xs text-gray-500">${job.experienceLevel.displayName}</span>
                                        <a href="/lankajobshub/jobs/${job.id}" class="text-blue-600 hover:text-blue-800 text-sm">View Details</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="/lankajobshub/jobs" class="mt-4 inline-block text-blue-600 hover:text-blue-800">Browse all jobs →</a>
                    </div>

                    <!-- My Applications -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">My Applications</h3>
                        <div class="space-y-4">
                            <c:forEach items="${myApplications}" var="application">
                                <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                    <h4 class="font-medium text-gray-900">${application.job.title}</h4>
                                    <p class="text-sm text-gray-600">Applied ${application.appliedDate}</p>
                                    <span class="inline-block mt-1 px-2 py-1 text-xs rounded-full 
                                        ${application.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' : 
                                          application.status == 'ACCEPTED' ? 'bg-green-100 text-green-800' : 
                                          application.status == 'REJECTED' ? 'bg-red-100 text-red-800' : 
                                          'bg-gray-100 text-gray-800'}">
                                        ${application.status.displayName}
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-5 mb-8">
                    <div class="management-stat">
                        <p class="text-sm font-semibold text-slate-500">Vacancies</p>
                        <p class="mt-2 text-3xl font-bold text-blue-700">${totalJobs}</p>
                    </div>
                    <div class="management-stat">
                        <p class="text-sm font-semibold text-slate-500">Applications</p>
                        <p class="mt-2 text-3xl font-bold text-blue-700">${totalApplications != null ? totalApplications : 'Review by job'}</p>
                    </div>
                    <div class="management-stat">
                        <p class="text-sm font-semibold text-slate-500">Workspace</p>
                        <p class="mt-2 text-lg font-bold text-slate-950">${user.role.displayName}</p>
                    </div>
                </div>

                <div class="ui-card rounded-3xl bg-white p-6 lg:p-8">
                    <div class="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-4 mb-6">
                        <div>
                            <h3 class="text-2xl font-bold text-slate-950">Recruiter Workspace</h3>
                            <p class="mt-2 text-slate-500">Manage vacancies, review applications, schedule interviews, and monitor updates.</p>
                        </div>
                        <a href="/lankajobshub/jobs/post" class="ui-btn-primary focus-ring px-5 py-3">Post New Job</a>
                    </div>
                    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
                        <a href="/lankajobshub/jobs/post" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">Post New Job</p>
                            <p class="mt-1 text-sm text-slate-500">Advertise a vacancy</p>
                        </a>
                        <a href="/lankajobshub/jobs/my-jobs" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">Manage Jobs</p>
                            <p class="mt-1 text-sm text-slate-500">Edit vacancies and review applications</p>
                        </a>
                        <a href="/lankajobshub/interviews" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">View Interviews</p>
                            <p class="mt-1 text-sm text-slate-500">Manage interview workflow</p>
                        </a>
                        <a href="/lankajobshub/notifications" class="ui-soft-card rounded-2xl bg-white p-5 hover:shadow-xl transition focus-ring">
                            <p class="font-bold text-slate-950">Notifications</p>
                            <p class="mt-1 text-sm text-slate-500">Check latest updates</p>
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Quick Actions -->
        <div class="mt-8 bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <a href="/lankajobshub/jobs" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                    <div class="p-2 rounded-full bg-blue-100 text-blue-600 mr-3">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                        </svg>
                    </div>
                    <div>
                        <p class="font-medium text-gray-900">Browse Jobs</p>
                        <p class="text-sm text-gray-600">Find new opportunities</p>
                    </div>
                </a>

                <c:if test="${user.role != 'JOB_SEEKER'}">
                    <a href="/lankajobshub/jobs/post" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                        <div class="p-2 rounded-full bg-green-100 text-green-600 mr-3">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="font-medium text-gray-900">Post a Job</p>
                            <p class="text-sm text-gray-600">Hire new talent</p>
                        </div>
                    </a>
                </c:if>

                <c:if test="${user.role == 'ADMIN' || user.role == 'CLIENT_RELATIONS_EXECUTIVE' || user.role == 'COMPANY_HIRING_MANAGER' || user.role == 'RECRUITMENT_MANAGER'}">
                    <a href="/lankajobshub/users/create" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                        <div class="p-2 rounded-full bg-purple-100 text-purple-600 mr-3">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="font-medium text-gray-900">Create User</p>
                            <p class="text-sm text-gray-600">Add new team member</p>
                        </div>
                    </a>
                </c:if>

                <c:if test="${user.role == 'CLIENT_RELATIONS_EXECUTIVE'}">
                    <a href="/lankajobshub/companies" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                        <div class="p-2 rounded-full bg-indigo-100 text-indigo-600 mr-3">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V7M16 3H8a1 1 0 00-1 1v16h10V4a1 1 0 00-1-1z" />
                            </svg>
                        </div>
                        <div>
                            <p class="font-medium text-gray-900">Manage Companies</p>
                            <p class="text-sm text-gray-600">Add or remove companies</p>
                        </div>
                    </a>
                </c:if>

                <a href="/lankajobshub/users/profile" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                    <div class="p-2 rounded-full bg-purple-100 text-purple-600 mr-3">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <div>
                        <p class="font-medium text-gray-900">My Profile</p>
                        <p class="text-sm text-gray-600">Update your information</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
