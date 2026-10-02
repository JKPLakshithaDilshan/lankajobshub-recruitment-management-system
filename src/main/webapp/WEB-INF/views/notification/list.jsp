<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - LankaJobsHub</title>
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
            <a href="/lankajobshub/applications/my-applications" class="workspace-nav-link focus-ring">My Applications</a>
            <a href="/lankajobshub/interviews" class="workspace-nav-link focus-ring">Interviews</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link active focus-ring">Notifications</a>
            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                <a href="/lankajobshub/notifications/templates" class="workspace-nav-link focus-ring">Templates</a>
            </c:if>
        </div>

        <div class="mb-8">
            <p class="text-blue-700 font-semibold">Inbox</p>
            <h1 class="mt-2 text-3xl lg:text-4xl font-bold text-slate-950">Notifications</h1>
            <p class="mt-2 text-slate-500">Follow application, interview, and account updates.</p>
        </div>

        <c:if test="${not empty success}">
            <div class="ui-alert ui-alert-success mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert-error mb-6">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty notifications}">
                <div class="ui-card rounded-3xl bg-white p-10 text-center">
                    <h2 class="text-2xl font-bold text-slate-950">No notifications</h2>
                    <p class="mt-3 text-slate-500">Your inbox is up to date.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid gap-4">
                    <c:forEach items="${notifications}" var="notification">
                        <article class="rounded-3xl bg-white p-6 ${notification.read ? 'ui-soft-card' : 'ui-card border-l-4 border-l-blue-600'}">
                            <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-5">
                                <div class="min-w-0">
                                    <div class="flex flex-wrap items-center gap-2">
                                        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">${notification.type.displayName}</span>
                                        <c:choose>
                                            <c:when test="${notification.read}">
                                                <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-600">Read</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="rounded-full bg-blue-600 px-3 py-1 text-xs font-semibold text-white">Unread</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h2 class="mt-3 text-xl font-bold text-slate-950">${notification.title}</h2>
                                    <p class="mt-2 text-slate-600">${notification.message}</p>
                                    <p class="mt-3 text-sm text-slate-500">${notification.createdAt}</p>
                                </div>
                                <div class="flex flex-col sm:flex-row lg:flex-col gap-3 shrink-0">
                                    <a href="/lankajobshub/notifications/${notification.id}" class="ui-btn-secondary focus-ring px-4 py-2">View</a>
                                    <c:choose>
                                        <c:when test="${notification.read}">
                                            <form action="/lankajobshub/notifications/${notification.id}/unread" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="w-full ui-btn-secondary focus-ring px-4 py-2">Mark Unread</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="/lankajobshub/notifications/${notification.id}/read" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="w-full ui-btn-secondary focus-ring px-4 py-2">Mark Read</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                    <form action="/lankajobshub/notifications/${notification.id}/delete" method="post" onsubmit="return confirm('Delete this notification?')">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="w-full rounded-xl border border-red-200 px-4 py-2 font-semibold text-red-700 hover:bg-red-50 focus-ring">Delete</button>
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
