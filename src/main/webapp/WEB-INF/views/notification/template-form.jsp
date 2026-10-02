<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification Template - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
</head>
<body class="management-shell">
    <main class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10">
        <div class="workspace-nav mb-8">
            <a href="/lankajobshub/dashboard" class="workspace-nav-link focus-ring">Dashboard</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
            <a href="/lankajobshub/notifications/templates" class="workspace-nav-link active focus-ring">Templates</a>
        </div>

        <div class="mb-8">
            <p class="text-blue-700 font-semibold">Communication template</p>
            <h1 class="mt-2 text-3xl lg:text-4xl font-bold text-slate-950">${template.id == null ? 'New Template' : 'Edit Template'}</h1>
            <p class="mt-2 text-slate-500">Prepare pending, scheduled, or draft messages for recruitment updates.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <form action="${formAction}" method="post" class="ui-card rounded-3xl bg-white p-6 lg:p-8 space-y-6">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="grid md:grid-cols-2 gap-5">
                <div>
                    <label class="field-label">Template name *</label>
                    <input type="text" name="name" value="${template.name}" required class="ui-input focus-ring">
                </div>
                <div>
                    <label class="field-label">Notification type *</label>
                    <select name="type" required class="ui-input focus-ring">
                        <c:forEach items="${types}" var="type">
                            <option value="${type}" ${template.type == type ? 'selected' : ''}>${type.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label class="field-label">Status *</label>
                    <select name="status" required class="ui-input focus-ring">
                        <c:forEach items="${statuses}" var="status">
                            <option value="${status}" ${template.status == status ? 'selected' : ''}>${status.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label class="field-label">Scheduled date/time</label>
                    <input type="datetime-local" name="scheduledAt" value="${template.scheduledAt != null ? template.scheduledAt.toString().substring(0, 16) : ''}" data-min-now="true" class="ui-input focus-ring">
                </div>
                <div class="md:col-span-2">
                    <label class="field-label">Title *</label>
                    <input type="text" name="title" value="${template.title}" required class="ui-input focus-ring">
                </div>
                <div class="md:col-span-2">
                    <label class="field-label">Message *</label>
                    <textarea name="message" rows="7" required class="ui-input focus-ring">${template.message}</textarea>
                </div>
            </div>
            <div class="flex flex-col sm:flex-row justify-end gap-3">
                <a href="/lankajobshub/notifications/templates" class="ui-btn-secondary focus-ring px-6 py-3">Cancel</a>
                <button type="submit" class="ui-btn-primary focus-ring px-6 py-3">Save Template</button>
            </div>
        </form>
    </main>
    <script src="/lankajobshub/static/js/validation.js"></script>
</body>
</html>
