<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
</head>
<body>
    <nav class="sticky top-0 z-50 bg-white/95 backdrop-blur border-b border-slate-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-20">
                <a href="/lankajobshub/" class="flex items-center gap-3 focus-ring rounded-lg">
                    <img src="/lankajobshub/static/images/lankajobshub-logo.svg" alt="LankaJobsHub logo" class="h-11 w-11 rounded-xl shadow-lg shadow-blue-200">
                    <span class="hidden sm:block text-xl font-bold text-slate-950">LankaJobsHub</span>
                </a>
                <div class="flex items-center gap-3">
                    <a href="/lankajobshub/dashboard" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Dashboard</a>
                    <a href="/lankajobshub/users/logout" class="ui-btn-secondary focus-ring px-4 py-2">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10">
        <div class="workspace-nav mb-8">
            <a href="/lankajobshub/users/profile" class="workspace-nav-link focus-ring">Overview/Profile</a>
            <a href="/lankajobshub/jobs" class="workspace-nav-link focus-ring">Find Jobs</a>
            <a href="/lankajobshub/applications/my-applications" class="workspace-nav-link active focus-ring">My Applications</a>
            <a href="/lankajobshub/interviews" class="workspace-nav-link focus-ring">Interviews</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
        </div>

        <div class="mb-8">
            <p class="text-blue-700 font-semibold">Application history</p>
            <h1 class="mt-2 text-3xl lg:text-4xl font-bold text-slate-950">My Applications</h1>
            <p class="mt-2 text-slate-500">Track submitted applications, review statuses, and interview progress.</p>
        </div>

        <c:if test="${not empty success}">
            <div class="ui-alert ui-alert-success mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty applications}">
                <div class="ui-card rounded-3xl bg-white p-10 text-center">
                    <div class="mx-auto mb-5 h-14 w-14 rounded-2xl bg-blue-50"></div>
                    <h2 class="text-2xl font-bold text-slate-950">No applications yet</h2>
                    <p class="mt-3 text-slate-500">Start applying for jobs to see your application timeline here.</p>
                    <a href="/lankajobshub/jobs" class="ui-btn-primary focus-ring mt-6 px-6 py-3">Find Jobs</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid gap-5">
                    <c:forEach items="${applications}" var="application">
                        <article class="ui-soft-card rounded-3xl bg-white p-6">
                            <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-5">
                                <div class="min-w-0">
                                    <p class="text-sm font-semibold text-slate-500">
                                        <c:choose>
                                            <c:when test="${not empty application.job.company}">${application.job.company.name}</c:when>
                                            <c:otherwise>LankaJobsHub</c:otherwise>
                                        </c:choose>
                                    </p>
                                    <h2 class="mt-1 text-2xl font-bold text-slate-950">
                                        <a href="/lankajobshub/jobs/${application.job.id}" class="hover:text-blue-700 focus-ring rounded">${application.job.title}</a>
                                    </h2>
                                    <div class="mt-3 flex flex-wrap gap-2">
                                        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">${application.status.displayName}</span>
                                        <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">${application.job.jobType.displayName}</span>
                                        <span class="rounded-full bg-white border border-slate-200 px-3 py-1 text-xs font-semibold text-slate-600">${application.job.location}</span>
                                    </div>
                                </div>
                                <div class="flex flex-col sm:flex-row lg:flex-col gap-3 lg:items-stretch">
                                    <a href="/lankajobshub/jobs/${application.job.id}" class="ui-btn-secondary focus-ring px-5 py-3">View Job</a>
                                    <c:if test="${application.status == 'PENDING' || application.status == 'REVIEWING'}">
                                        <a href="/lankajobshub/applications/${application.id}/edit" class="ui-btn-secondary focus-ring px-5 py-3">Edit</a>
                                        <form action="/lankajobshub/applications/${application.id}/withdraw" method="post" onsubmit="return confirm('Are you sure you want to withdraw this application?')">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button type="submit" class="w-full rounded-xl border border-red-200 px-5 py-3 font-semibold text-red-700 hover:bg-red-50 focus-ring">Withdraw</button>
                                        </form>
                                        <form action="/lankajobshub/applications/${application.id}/delete" method="post" onsubmit="return confirm('Delete this application permanently?')">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button type="submit" class="w-full rounded-xl bg-red-600 px-5 py-3 font-semibold text-white hover:bg-red-700 focus-ring">Delete</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>

                            <div class="mt-5 grid md:grid-cols-3 gap-3 text-sm">
                                <div class="rounded-2xl bg-slate-50 p-3"><span class="block text-xs font-semibold uppercase text-slate-400">Applied</span><span class="mt-1 block font-semibold text-slate-800">${application.appliedDate.toString().substring(0, 10)}</span></div>
                                <div class="rounded-2xl bg-slate-50 p-3"><span class="block text-xs font-semibold uppercase text-slate-400">Reviewed</span><span class="mt-1 block font-semibold text-slate-800">${application.reviewedDate != null ? application.reviewedDate.toString().substring(0, 10) : 'Not reviewed yet'}</span></div>
                                <div class="rounded-2xl bg-slate-50 p-3"><span class="block text-xs font-semibold uppercase text-slate-400">Experience</span><span class="mt-1 block font-semibold text-slate-800">${application.job.experienceLevel.displayName}</span></div>
                            </div>

                            <c:if test="${not empty application.coverLetter}">
                                <p class="mt-5 text-slate-600">${application.coverLetter.length() > 200 ? application.coverLetter.substring(0, 200).concat('...') : application.coverLetter}</p>
                            </c:if>
                            <c:if test="${not empty application.rejectionReason}">
                                <div class="mt-5 rounded-2xl border border-red-200 bg-red-50 p-4 text-sm text-red-800">
                                    <strong>Rejection reason:</strong> ${application.rejectionReason}
                                </div>
                            </c:if>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>
