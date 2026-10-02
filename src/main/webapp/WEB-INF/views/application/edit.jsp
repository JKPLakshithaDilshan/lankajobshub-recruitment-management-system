<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Application - LankaJobsHub</title>
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
                    <a href="/lankajobshub/applications/my-applications" class="ui-btn-secondary focus-ring px-4 py-2">My Applications</a>
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
            <p class="text-blue-700 font-semibold">Update application</p>
            <h1 class="mt-2 text-3xl lg:text-4xl font-bold text-slate-950">${application.job.title}</h1>
            <p class="mt-2 text-slate-500">Edit your cover letter and notes while this application is still active.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <div class="grid lg:grid-cols-3 gap-6">
            <aside class="ui-card rounded-3xl bg-white p-6 lg:p-8 h-fit">
                <h2 class="text-xl font-bold text-slate-950">${application.job.title}</h2>
                <dl class="mt-5 space-y-3 text-sm">
                    <div><dt class="text-slate-500">Company</dt><dd class="font-semibold text-slate-900">${application.job.company != null ? application.job.company.name : 'LankaJobsHub'}</dd></div>
                    <div><dt class="text-slate-500">Location</dt><dd class="font-semibold text-slate-900">${application.job.location}</dd></div>
                    <div><dt class="text-slate-500">Status</dt><dd class="font-semibold text-slate-900">${application.status.displayName}</dd></div>
                </dl>
            </aside>

            <section class="lg:col-span-2 ui-card rounded-3xl bg-white p-6 lg:p-8">
                <form action="/lankajobshub/applications/${application.id}/edit" method="post" class="space-y-6">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div>
                        <label for="coverLetter" class="field-label">Cover Letter *</label>
                        <textarea id="coverLetter" name="coverLetter" rows="8" required class="ui-input focus-ring">${application.coverLetter}</textarea>
                    </div>
                    <div>
                        <label for="additionalNotes" class="field-label">Additional Notes</label>
                        <textarea id="additionalNotes" name="additionalNotes" rows="4" class="ui-input focus-ring">${application.additionalNotes}</textarea>
                    </div>
                    <div class="flex flex-col sm:flex-row justify-end gap-3">
                        <a href="/lankajobshub/applications/my-applications" class="ui-btn-secondary focus-ring px-6 py-3">Cancel</a>
                        <button type="submit" class="ui-btn-primary focus-ring px-6 py-3">Update Application</button>
                    </div>
                </form>
            </section>
        </div>
    </main>
</body>
</html>
