<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - LankaJobsHub</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
    <c:set var="u" value="${user}"/>
    <c:if test="${empty u}">
        <c:redirect url="/users/login"/>
    </c:if>
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
            <a href="/lankajobshub/users/profile" class="workspace-nav-link active focus-ring">Overview/Profile</a>
            <a href="/lankajobshub/jobs" class="workspace-nav-link focus-ring">Find Jobs</a>
            <a href="/lankajobshub/applications/my-applications" class="workspace-nav-link focus-ring">My Applications</a>
            <a href="/lankajobshub/interviews" class="workspace-nav-link focus-ring">Interviews</a>
            <a href="/lankajobshub/notifications" class="workspace-nav-link focus-ring">Notifications</a>
        </div>

        <section class="ui-card rounded-3xl bg-white p-6 lg:p-8 mb-6">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                <div class="flex items-center gap-5">
                    <c:choose>
                        <c:when test="${not empty u.profilePhotoPath}">
                            <img class="h-20 w-20 rounded-2xl object-cover border border-slate-200" src="${pageContext.request.contextPath}/${u.profilePhotoPath}" alt="Profile photo"/>
                        </c:when>
                        <c:otherwise>
                            <div class="h-20 w-20 rounded-2xl bg-blue-50 flex items-center justify-center text-2xl font-bold text-blue-700">
                                LJ
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <p class="text-sm font-semibold text-blue-700">${u.role.displayName}</p>
                        <h1 class="mt-1 text-3xl lg:text-4xl font-bold text-slate-950">${not empty u.fullName ? u.fullName : u.email}</h1>
                        <p class="mt-2 text-slate-500">${u.email}<c:if test="${not empty u.phoneNumber}"> • ${u.phoneNumber}</c:if></p>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-3">
                    <c:if test="${not empty u.resumePath}">
                        <a href="${pageContext.request.contextPath}/${u.resumePath}" target="_blank" class="ui-btn-secondary focus-ring px-5 py-3">View Resume</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/users/profile/edit" class="ui-btn-primary focus-ring px-5 py-3">Edit Profile</a>
                </div>
            </div>
        </section>

        <div class="grid lg:grid-cols-3 gap-6">
            <section class="lg:col-span-2 space-y-6">
                <div class="ui-soft-card rounded-3xl bg-white p-6">
                    <h2 class="text-xl font-bold text-slate-950 mb-5">Personal Information</h2>
                    <div class="grid sm:grid-cols-2 gap-5">
                        <div><p class="text-sm text-slate-500">Full name</p><p class="font-semibold text-slate-900">${not empty u.fullName ? u.fullName : 'Not added yet'}</p></div>
                        <div><p class="text-sm text-slate-500">Email</p><p class="font-semibold text-slate-900 break-all">${u.email}</p></div>
                        <div><p class="text-sm text-slate-500">Phone</p><p class="font-semibold text-slate-900">${not empty u.phoneNumber ? u.phoneNumber : 'Not added yet'}</p></div>
                        <div><p class="text-sm text-slate-500">LinkedIn</p><p class="font-semibold break-all"><c:choose><c:when test="${not empty u.linkedinUrl}"><a class="text-blue-700 hover:text-blue-900" href="${u.linkedinUrl}" target="_blank">${u.linkedinUrl}</a></c:when><c:otherwise><span class="empty-value">Not added yet</span></c:otherwise></c:choose></p></div>
                        <div><p class="text-sm text-slate-500">GitHub</p><p class="font-semibold break-all"><c:choose><c:when test="${not empty u.githubUrl}"><a class="text-blue-700 hover:text-blue-900" href="${u.githubUrl}" target="_blank">${u.githubUrl}</a></c:when><c:otherwise><span class="empty-value">Not added yet</span></c:otherwise></c:choose></p></div>
                        <div class="sm:col-span-2"><p class="text-sm text-slate-500">Bio</p><p class="font-semibold text-slate-900 whitespace-pre-line">${not empty u.bio ? u.bio : 'Not added yet'}</p></div>
                    </div>
                </div>

                <c:if test="${u.role == 'JOB_SEEKER'}">
                    <div class="ui-soft-card rounded-3xl bg-white p-6">
                        <h2 class="text-xl font-bold text-slate-950 mb-5">Skills</h2>
                        <p class="text-slate-700 whitespace-pre-line">${not empty candidateProfile.skills ? candidateProfile.skills : 'Not added yet'}</p>
                    </div>
                    <div class="ui-soft-card rounded-3xl bg-white p-6">
                        <h2 class="text-xl font-bold text-slate-950 mb-5">Education</h2>
                        <p class="text-slate-700 whitespace-pre-line">${not empty candidateProfile.education ? candidateProfile.education : 'Not added yet'}</p>
                    </div>
                    <div class="ui-soft-card rounded-3xl bg-white p-6">
                        <h2 class="text-xl font-bold text-slate-950 mb-5">Work Experience</h2>
                        <p class="text-slate-700 whitespace-pre-line">${not empty candidateProfile.workExperience ? candidateProfile.workExperience : 'Not added yet'}</p>
                    </div>
                </c:if>
            </section>

            <aside class="space-y-6">
                <c:if test="${u.role == 'JOB_SEEKER'}">
                    <div class="ui-card rounded-3xl bg-white p-6">
                        <h2 class="text-xl font-bold text-slate-950 mb-5">Career Preferences</h2>
                        <dl class="space-y-4 text-sm">
                            <div><dt class="text-slate-500">Preferred job type</dt><dd class="font-semibold text-slate-900">${candidateProfile.preferredJobType != null ? candidateProfile.preferredJobType.displayName : 'Not added yet'}</dd></div>
                            <div><dt class="text-slate-500">Preferred location</dt><dd class="font-semibold text-slate-900">${not empty candidateProfile.preferredLocation ? candidateProfile.preferredLocation : 'Not added yet'}</dd></div>
                            <div><dt class="text-slate-500">Expected salary</dt><dd class="font-semibold text-slate-900">${candidateProfile.expectedSalary != null ? candidateProfile.expectedSalary : 'Not added yet'}</dd></div>
                        </dl>
                    </div>
                </c:if>
                <div class="ui-card rounded-3xl bg-white p-6">
                    <h2 class="text-xl font-bold text-slate-950 mb-5">Resume/CV</h2>
                    <c:choose>
                        <c:when test="${not empty u.resumePath}">
                            <p class="text-slate-600 mb-4 break-all">${u.resumePath}</p>
                            <a href="${pageContext.request.contextPath}/${u.resumePath}" target="_blank" class="ui-btn-primary focus-ring w-full px-5 py-3">View Resume</a>
                        </c:when>
                        <c:otherwise>
                            <p class="empty-value">No resume uploaded yet.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="ui-card rounded-3xl bg-white p-6 border-red-200">
                    <h2 class="text-xl font-bold text-red-700 mb-3">Delete Account</h2>
                    <p class="text-sm text-slate-500 mb-4">This permanently removes your account and signs you out. You can register again after deletion.</p>
                    <form action="${pageContext.request.contextPath}/users/profile/delete" method="post"
                          onsubmit="return confirm('Delete your account permanently? This cannot be undone.');">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button type="submit" class="w-full rounded-xl bg-red-600 px-5 py-3 font-semibold text-white hover:bg-red-700 focus-ring">Delete My Account</button>
                    </form>
                </div>
            </aside>
        </div>
    </main>
</body>
</html>
