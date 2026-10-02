<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
</head>
<body>
    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-10">
        <a href="/lankajobshub/notifications" class="ui-nav-link focus-ring rounded text-sm font-semibold">Back to Notifications</a>

        <section class="ui-card rounded-3xl bg-white p-6 lg:p-8 mt-4">
            <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4 mb-6">
                <div>
                    <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-semibold text-blue-700">${notification.type.displayName}</span>
                    <h1 class="mt-4 text-3xl lg:text-4xl font-bold text-slate-950">${notification.title}</h1>
                    <p class="mt-2 text-sm text-slate-500">${notification.createdAt}</p>
                </div>
            </div>

            <div class="rounded-2xl bg-slate-50 p-5">
                <p class="text-slate-700 leading-relaxed whitespace-pre-line">${notification.message}</p>
            </div>

            <div class="mt-6 flex flex-col sm:flex-row gap-3">
                <form action="/lankajobshub/notifications/${notification.id}/unread" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="ui-btn-secondary focus-ring px-5 py-3">Mark Unread</button>
                </form>
                <form action="/lankajobshub/notifications/${notification.id}/delete" method="post" onsubmit="return confirm('Delete this notification?')">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="rounded-xl border border-red-200 px-5 py-3 font-semibold text-red-700 hover:bg-red-50 focus-ring">Delete</button>
                </form>
            </div>
        </section>
    </main>
</body>
</html>
