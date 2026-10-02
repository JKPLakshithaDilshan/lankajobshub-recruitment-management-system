<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification Templates - LankaJobsHub</title>
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
                    <a href="/lankajobshub/notifications" class="hidden sm:inline-flex px-4 py-2 rounded-lg text-slate-700 hover:text-blue-600 font-medium focus-ring">Inbox</a>
                    <a href="/lankajobshub/users/logout" class="ui-btn-secondary focus-ring px-4 py-2">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10">
        <div class="workspace-nav mb-8">
            <a href="/lankajobshub/dashboard" class="workspace-nav-link focus-ring">Dashboard</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
            <a href="/lankajobshub/notifications/templates" class="workspace-nav-link active focus-ring">Templates</a>
        </div>

        <div class="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-4 mb-8">
            <div>
                <p class="text-blue-700 font-semibold">Communication management</p>
                <h1 class="mt-2 text-3xl lg:text-4xl font-bold text-slate-950">Notification Templates</h1>
                <p class="mt-2 text-slate-500">Create, edit, schedule, or discard draft message templates.</p>
            </div>
            <a href="/lankajobshub/notifications/templates/new" class="ui-btn-primary focus-ring px-6 py-3">New Template</a>
        </div>

        <c:if test="${not empty success}">
            <div class="ui-alert ui-alert-success mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty templates}">
                <div class="ui-card rounded-3xl bg-white p-10 text-center">
                    <h2 class="text-2xl font-bold text-slate-950">No templates yet</h2>
                    <p class="mt-3 text-slate-500">Create a draft or scheduled communication template.</p>
                    <a href="/lankajobshub/notifications/templates/new" class="ui-btn-primary focus-ring mt-6 px-6 py-3">Create Template</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid gap-5">
                    <c:forEach items="${templates}" var="template">
                        <article class="ui-soft-card rounded-3xl bg-white p-6">
                            <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-5">
                                <div>
                                    <div class="flex flex-wrap gap-2">
                                        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">${template.type.displayName}</span>
                                        <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">${template.status.displayName}</span>
                                    </div>
                                    <h2 class="mt-3 text-2xl font-bold text-slate-950">${template.name}</h2>
                                    <p class="mt-1 font-semibold text-slate-700">${template.title}</p>
                                    <p class="mt-3 text-slate-600 whitespace-pre-line">${template.message}</p>
                                    <p class="mt-3 text-sm text-slate-500">
                                        <c:if test="${template.scheduledAt != null}">Scheduled: ${template.scheduledAt}</c:if>
                                        <c:if test="${template.updatedBy != null}"> Updated by ${template.updatedBy.email}</c:if>
                                    </p>
                                </div>
                                <div class="flex flex-col sm:flex-row lg:flex-col gap-3 shrink-0">
                                    <a href="/lankajobshub/notifications/templates/${template.id}/edit" class="ui-btn-secondary focus-ring px-5 py-3">Edit</a>
                                    <form action="/lankajobshub/notifications/templates/${template.id}/delete" method="post" onsubmit="return confirm('Delete this template?')">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="w-full rounded-xl border border-red-200 px-5 py-3 font-semibold text-red-700 hover:bg-red-50 focus-ring">Delete</button>
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
