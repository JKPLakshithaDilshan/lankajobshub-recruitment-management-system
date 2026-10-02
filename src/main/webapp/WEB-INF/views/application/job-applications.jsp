<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applications - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
</head>
<body class="management-shell">
    <nav class="sticky top-0 z-50 bg-white/95 backdrop-blur border-b border-slate-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-20">
                <a href="/lankajobshub/" class="flex items-center gap-3 focus-ring rounded-lg">
                    <img src="/lankajobshub/static/images/lankajobshub-logo.svg" alt="LankaJobsHub logo" class="h-11 w-11 rounded-xl shadow-lg shadow-blue-200">
                    <span class="hidden sm:block text-xl font-bold text-slate-950">LankaJobsHub</span>
                </a>
                <div class="flex items-center gap-3">
                    <a href="/lankajobshub/jobs/my-jobs" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">My Vacancies</a>
                    <a href="/lankajobshub/users/logout" class="ui-btn-secondary focus-ring px-4 py-2">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10">
        <div class="workspace-nav mb-8">
            <a href="/lankajobshub/dashboard" class="workspace-nav-link focus-ring">Dashboard</a>
            <a href="/lankajobshub/jobs/my-jobs" class="workspace-nav-link focus-ring">My Vacancies</a>
            <a href="/lankajobshub/jobs/post" class="workspace-nav-link focus-ring">Post Job</a>
            <a href="/lankajobshub/interviews" class="workspace-nav-link focus-ring">Interviews</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
            <a href="/lankajobshub/users/profile" class="workspace-nav-link focus-ring">Profile</a>
        </div>

        <div class="mb-8">
            <a href="/lankajobshub/jobs/my-jobs" class="ui-nav-link focus-ring rounded text-sm font-semibold">Back to My Vacancies</a>
            <h1 class="mt-3 text-3xl lg:text-4xl font-bold text-slate-950">Applications</h1>
            <c:if test="${not empty job}">
                <p class="mt-2 text-slate-500">${job.title}</p>
            </c:if>
        </div>

        <c:if test="${not empty success}">
            <div class="ui-alert ui-alert-success mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty job}">
                <div class="ui-card rounded-3xl bg-white p-10 text-center">
                    <h2 class="text-2xl font-bold text-slate-950">Applications unavailable</h2>
                    <p class="mt-3 text-slate-500">You are not authorized to view these applications.</p>
                </div>
            </c:when>
            <c:when test="${empty applications}">
                <div class="ui-card rounded-3xl bg-white p-10 text-center">
                    <h2 class="text-2xl font-bold text-slate-950">No applications yet</h2>
                    <p class="mt-3 text-slate-500">Applications for this vacancy will appear here.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid gap-5">
                    <c:forEach items="${applications}" var="application">
                        <article class="ui-soft-card rounded-3xl bg-white p-6">
                            <div class="grid lg:grid-cols-12 gap-6">
                                <div class="lg:col-span-8">
                                    <div class="flex flex-wrap items-center gap-2 mb-3">
                                        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">${application.status.displayName}</span>
                                        <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">Applied ${application.appliedDate.toString().substring(0, 10)}</span>
                                    </div>
                                    <h2 class="text-2xl font-bold text-slate-950">
                                        <c:choose>
                                            <c:when test="${not empty application.applicant.fullName}">${application.applicant.fullName}</c:when>
                                            <c:otherwise>${application.applicant.email}</c:otherwise>
                                        </c:choose>
                                    </h2>
                                    <p class="mt-1 text-slate-500 break-all">${application.applicant.email}</p>

                                    <c:if test="${not empty application.applicant.resumePath}">
                                        <a href="${pageContext.request.contextPath}/${application.applicant.resumePath}" target="_blank" class="mt-3 inline-flex text-sm font-semibold text-blue-700 hover:text-blue-900 focus-ring rounded">View CV / Resume</a>
                                    </c:if>

                                    <c:if test="${not empty application.coverLetter}">
                                        <div class="mt-5 rounded-2xl bg-slate-50 p-4">
                                            <h3 class="font-bold text-slate-950">Cover Letter</h3>
                                            <p class="mt-2 text-slate-600 whitespace-pre-line">${application.coverLetter}</p>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty application.additionalNotes}">
                                        <div class="mt-4 rounded-2xl bg-slate-50 p-4">
                                            <h3 class="font-bold text-slate-950">Additional Notes</h3>
                                            <p class="mt-2 text-slate-600 whitespace-pre-line">${application.additionalNotes}</p>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty application.rejectionReason}">
                                        <div class="mt-4 rounded-2xl border border-red-200 bg-red-50 p-4 text-sm text-red-800">
                                            <strong>Rejection reason:</strong> ${application.rejectionReason}
                                        </div>
                                    </c:if>
                                    <p class="mt-4 text-sm text-slate-500">
                                        <c:if test="${application.reviewedDate != null}">Reviewed ${application.reviewedDate.toString().substring(0, 10)}</c:if>
                                        <c:if test="${application.reviewedBy != null}"> by ${application.reviewedBy.email}</c:if>
                                    </p>
                                </div>

                                <div class="lg:col-span-4">
                                    <form action="/lankajobshub/applications/${application.id}/status" method="post" class="ui-card rounded-2xl bg-white p-4 space-y-3">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div>
                                            <label class="field-label">Application status</label>
                                            <select name="status" class="ui-input focus-ring">
                                                <c:forEach items="${statuses}" var="status">
                                                    <option value="${status}" ${application.status == status ? 'selected' : ''}>${status.displayName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="field-label">Rejection reason</label>
                                            <textarea name="rejectionReason" rows="3" class="ui-input focus-ring" placeholder="Required when rejecting">${application.rejectionReason}</textarea>
                                        </div>
                                        <button type="submit" class="ui-btn-primary focus-ring w-full px-4 py-3">Update Status</button>
                                        <a href="/lankajobshub/interviews/schedule/${application.id}" class="ui-btn-secondary focus-ring w-full px-4 py-3">Schedule Interview</a>
                                    </form>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>
