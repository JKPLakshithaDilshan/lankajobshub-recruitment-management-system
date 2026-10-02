<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Job - LankaJobsHub</title>
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
                    <a href="/lankajobshub/jobs" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Find Jobs</a>
                    <a href="/lankajobshub/dashboard" class="ui-btn-secondary focus-ring px-4 py-2">Dashboard</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10">
        <div class="workspace-nav mb-8">
            <a href="/lankajobshub/users/profile" class="workspace-nav-link focus-ring">Overview/Profile</a>
            <a href="/lankajobshub/jobs" class="workspace-nav-link focus-ring">Find Jobs</a>
            <a href="/lankajobshub/applications/my-applications" class="workspace-nav-link active focus-ring">My Applications</a>
            <a href="/lankajobshub/interviews" class="workspace-nav-link focus-ring">Interviews</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
        </div>

        <div class="mb-8">
            <p class="text-blue-700 font-semibold">Submit application</p>
            <h1 class="mt-2 text-3xl lg:text-4xl font-bold text-slate-950">Apply for Job</h1>
            <p class="mt-2 text-slate-500">Write a focused cover letter for this vacancy.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <div class="grid lg:grid-cols-3 gap-6">
            <aside class="ui-card rounded-3xl bg-white p-6 lg:p-8 h-fit">
                <h2 class="text-xl font-bold text-slate-950">${job.title}</h2>
                <div class="mt-4 flex flex-wrap gap-2">
                    <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">${job.jobType.displayName}</span>
                    <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">${job.experienceLevel.displayName}</span>
                </div>
                <dl class="mt-5 space-y-3 text-sm">
                    <div><dt class="text-slate-500">Location</dt><dd class="font-semibold text-slate-900">${job.location}</dd></div>
                    <c:if test="${not empty job.company}">
                        <div><dt class="text-slate-500">Company</dt><dd class="font-semibold text-slate-900">${job.company.name}</dd></div>
                    </c:if>
                </dl>
            </aside>

            <section class="lg:col-span-2 ui-card rounded-3xl bg-white p-6 lg:p-8">
                <form action="/lankajobshub/applications/apply/${job.id}" method="post" class="space-y-6">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div>
                        <label for="coverLetter" class="field-label">Cover Letter *</label>
                        <textarea id="coverLetter" name="coverLetter" rows="8" required class="ui-input focus-ring" placeholder="Write a compelling cover letter explaining why you are a strong fit for this position."></textarea>
                        <p class="text-sm text-slate-500 mt-2">Tell the recruiter why you are interested in this role and what makes you a great fit.</p>
                    </div>
                    <div>
                        <label for="additionalNotes" class="field-label">Additional Notes</label>
                        <textarea id="additionalNotes" name="additionalNotes" rows="4" class="ui-input focus-ring" placeholder="Any additional information you would like to share."></textarea>
                        <p class="text-sm text-slate-500 mt-2">Optional: include relevant experience, certifications, or availability.</p>
                    </div>
                    <div class="flex flex-col sm:flex-row justify-end gap-3">
                        <a href="/lankajobshub/jobs/${job.id}" class="ui-btn-secondary focus-ring px-6 py-3">Cancel</a>
                        <button type="submit" class="ui-btn-primary focus-ring px-6 py-3">Submit Application</button>
                    </div>
                </form>
            </section>
        </div>
    </main>
</body>
</html>
