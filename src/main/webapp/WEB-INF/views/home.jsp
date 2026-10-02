<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LankaJobsHub - Recruitment Company & Job Portal</title>
    <link rel="icon" type="image/svg+xml" href="/lankajobshub/static/images/favicon.svg">
    <link rel="apple-touch-icon" href="/lankajobshub/static/images/lankajobshub-logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700;800&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/lankajobshub/static/css/lankajobshub-ui.css">
    <style>
        :root{
            --ink:#0F172A;
            --paper:#FFFFFF;
            --paper-soft:#F8FAFC;
            --paper-blue:#EFF6FF;
            --navy:#0F2A5F;
            --navy-2:#071936;
            --blue:#2563EB;
            --blue-dark:#1D4ED8;
            --sky:#0EA5E9;
            --line:#E2E8F0;
            --muted:#64748B;
        }
        *{ box-sizing:border-box; }
        html{ scroll-behavior:smooth; }
        body{ font-family:'Manrope',sans-serif; background:var(--paper); color:var(--ink); }
        .font-display{ font-family:'Sora','Manrope',sans-serif; }

        .site-shell{ background:var(--paper); }
        .site-nav{ background:rgba(255,255,255,.94); backdrop-filter:blur(10px); -webkit-backdrop-filter:blur(10px); }
        .section-kicker{ color:var(--blue); font-weight:800; font-size:.82rem; letter-spacing:.08em; text-transform:uppercase; }
        .surface{
            background:var(--paper);
            border:1px solid var(--line);
            box-shadow:0 16px 40px rgba(15,42,95,.07);
        }
        .surface-soft{
            background:#fff;
            border:1px solid var(--line);
            box-shadow:0 8px 22px rgba(15,42,95,.045);
        }
        .hero-panel{
            background:linear-gradient(135deg,#0F2A5F 0%,#123676 52%,#2563EB 100%);
            border:1px solid rgba(255,255,255,.16);
        }

        .focus-ring:focus-visible{ outline:2px solid var(--blue); outline-offset:2px; }

        .lift{ transition:transform .2s ease, box-shadow .2s ease, border-color .2s ease; }
        .lift:hover{ transform:translateY(-2px); border-color:#BFDBFE; box-shadow:0 18px 38px rgba(15,42,95,.09); }
        .btn-primary{ background:var(--blue); color:#fff; transition:background .2s ease, box-shadow .2s ease; box-shadow:0 12px 24px rgba(37,99,235,.2); }
        .btn-primary:hover{ background:var(--blue-dark); }
        .btn-secondary{ background:#fff; color:var(--navy); border:1px solid var(--line); transition:border-color .2s ease, color .2s ease, background .2s ease; }
        .btn-secondary:hover{ border-color:#BFDBFE; color:var(--blue); background:var(--paper-blue); }
        .step-line{ background:linear-gradient(90deg, var(--blue) 0%, rgba(37,99,235,0.12) 100%); }
        .step-node{ border:2px solid var(--blue); color:var(--blue); }

        .scrollbar-x::-webkit-scrollbar{ height:6px; }
        .scrollbar-x::-webkit-scrollbar-thumb{ background:rgba(15,23,42,0.18); border-radius:999px; }
    </style>
</head>
<body class="site-shell">
<nav class="site-nav sticky top-0 z-50 border-b" style="border-color:var(--line);">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
            <a href="/lankajobshub/" class="flex items-center gap-3 focus-ring rounded-lg">
                <img src="/lankajobshub/static/images/lankajobshub-logo.svg" alt="LankaJobsHub logo" class="h-10 w-10 rounded-xl">
                <span>
                        <span class="block text-xl font-display font-bold" style="color:var(--navy);">LankaJobsHub</span>
                        <span class="hidden sm:block text-xs" style="color:var(--muted);">Recruitment company &amp; job portal</span>
                    </span>
            </a>

            <div class="hidden lg:flex items-center gap-8 text-[15px] font-medium" style="color:#3b4451;">
                <a href="/lankajobshub/" class="focus-ring rounded hover:text-[color:var(--blue)] transition-colors">Home</a>
                <a href="/lankajobshub/jobs" class="focus-ring rounded hover:text-[color:var(--blue)] transition-colors">Find jobs</a>
                <a href="/lankajobshub/companies" class="focus-ring rounded hover:text-[color:var(--blue)] transition-colors">Companies</a>
                <a href="#how-it-works" class="focus-ring rounded hover:text-[color:var(--blue)] transition-colors">How it works</a>
                <a href="#contact" class="focus-ring rounded hover:text-[color:var(--blue)] transition-colors">Contact</a>
            </div>

            <div class="flex items-center gap-3">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="/lankajobshub/dashboard" class="hidden sm:inline-flex px-4 py-2 rounded-full font-medium focus-ring hover:text-[color:var(--blue)] transition-colors" style="color:#3b4451;">Dashboard</a>
                        <a href="/lankajobshub/users/logout" class="btn-secondary inline-flex px-4 py-2 rounded-xl font-semibold focus-ring">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/lankajobshub/users/login" class="hidden sm:inline-flex px-4 py-2 rounded-full font-medium focus-ring hover:text-[color:var(--blue)] transition-colors" style="color:#3b4451;">Login</a>
                        <a href="/lankajobshub/users/register" class="btn-primary inline-flex px-5 py-2.5 rounded-xl font-semibold focus-ring">Get started</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<main>
    <!-- HERO -->
    <section class="relative overflow-hidden border-b" style="background:linear-gradient(180deg, var(--paper-blue) 0%, var(--paper) 82%); border-color:var(--line);">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-14 lg:py-20 relative z-10">
            <div class="grid lg:grid-cols-12 gap-10 items-center">
                <div class="lg:col-span-6">
                    <p class="section-kicker mb-4">Sri Lanka recruitment portal</p>
                    <h1 class="font-display font-bold leading-[1.06] text-4xl sm:text-5xl lg:text-[3.45rem]" style="color:var(--navy);">
                        The cleaner way to find jobs and manage hiring.
                    </h1>

                    <form action="/lankajobshub/jobs" method="GET" class="surface mt-8 rounded-2xl p-3">
                        <div class="grid md:grid-cols-12 gap-2">
                            <input name="keyword" type="text" placeholder="Job title or keyword"
                                   class="focus-ring md:col-span-4 w-full rounded-xl bg-white border border-slate-200 px-4 py-3 text-sm text-[color:var(--ink)] placeholder:text-slate-400 focus:border-[color:var(--blue)]">
                            <input name="location" type="text" placeholder="Location"
                                   class="focus-ring md:col-span-3 w-full rounded-xl bg-white border border-slate-200 px-4 py-3 text-sm text-[color:var(--ink)] placeholder:text-slate-400 focus:border-[color:var(--blue)]">
                            <select name="jobType" class="focus-ring md:col-span-2 w-full rounded-xl bg-white border border-slate-200 px-4 py-3 text-sm text-slate-700 focus:border-[color:var(--blue)]">
                                <option value="">Any</option>
                                <c:forEach items="${jobTypes}" var="type">
                                    <option value="${type}">${type.displayName}</option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="btn-primary focus-ring md:col-span-3 w-full rounded-xl px-4 py-3 text-sm font-semibold whitespace-nowrap">
                                Search jobs
                            </button>
                        </div>
                    </form>

                    <div class="mt-5 flex flex-wrap items-center gap-2 text-sm" style="color:var(--muted);">
                        <span>Popular:</span>
                        <a href="/lankajobshub/jobs?keyword=Software" class="focus-ring rounded-full border px-3 py-1.5 hover:text-[color:var(--blue)] transition-colors" style="border-color:var(--line); color:var(--navy);">Software</a>
                        <a href="/lankajobshub/jobs?keyword=Frontend" class="focus-ring rounded-full border px-3 py-1.5 hover:text-[color:var(--blue)] transition-colors" style="border-color:var(--line); color:var(--navy);">Frontend</a>
                        <a href="/lankajobshub/jobs?location=Colombo" class="focus-ring rounded-full border px-3 py-1.5 hover:text-[color:var(--blue)] transition-colors" style="border-color:var(--line); color:var(--navy);">Colombo</a>
                    </div>
                </div>

                <div class="lg:col-span-6 relative">
                    <div class="hero-panel rounded-[1.75rem] p-5 lg:p-6 shadow-2xl shadow-blue-950/10">
                        <img src="https://images.unsplash.com/photo-1758518730083-4c12527b6742?fm=jpg&q=70&w=1400&auto=format&fit=crop"
                             alt="Colleagues collaborating around a table in a modern office"
                             class="w-full h-[390px] lg:h-[460px] object-cover rounded-[1.25rem]">
                        <div class="grid grid-cols-3 gap-3 mt-5 text-white">
                            <div class="rounded-2xl bg-white/10 p-4 border border-white/15">
                                <div class="text-2xl font-display font-bold">${totalJobs}</div>
                                <div class="text-xs text-blue-100 mt-1">Open jobs</div>
                            </div>
                            <div class="rounded-2xl bg-white/10 p-4 border border-white/15">
                                <div class="text-2xl font-display font-bold">${totalApplications}</div>
                                <div class="text-xs text-blue-100 mt-1">Applications</div>
                            </div>
                            <div class="rounded-2xl bg-white/10 p-4 border border-white/15">
                                <div class="text-2xl font-display font-bold">${totalUsers}</div>
                                <div class="text-xs text-blue-100 mt-1">Users</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- STATS -->
    <section class="py-12" style="background:var(--paper);">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-12 gap-5">
                <div class="md:col-span-6 surface-soft rounded-2xl p-7 flex items-end justify-between">
                    <div>
                        <div class="text-5xl font-display font-bold" style="color:var(--navy);">${totalJobs}</div>
                        <div class="mt-2" style="color:var(--muted);">Jobs available right now</div>
                    </div>
                </div>
                <div class="md:col-span-3 surface-soft rounded-2xl p-7">
                    <div class="text-3xl font-display font-bold" style="color:var(--navy);">${featuredCompanies.size()}</div>
                    <div class="mt-2 text-sm" style="color:var(--muted);">Companies hiring</div>
                </div>
                <div class="md:col-span-3 surface-soft rounded-2xl p-7">
                    <div class="text-3xl font-display font-bold" style="color:var(--navy);">${totalApplications}</div>
                    <div class="mt-2 text-sm" style="color:var(--muted);">Applications submitted</div>
                </div>
            </div>
        </div>
    </section>

    <!-- CATEGORIES -->
    <section class="py-16 lg:py-20 border-y" style="background:var(--paper-soft); border-color:var(--line);">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row md:items-end md:justify-between gap-4 mb-9">
                <h2 class="font-display font-bold text-3xl" style="color:var(--navy);">Browse by category</h2>
                <a href="/lankajobshub/jobs" class="focus-ring font-semibold" style="color:var(--blue);">See all jobs →</a>
            </div>
            <div class="flex gap-4 overflow-x-auto scrollbar-x pb-3 lg:grid lg:grid-cols-3 lg:overflow-visible">
                <c:forEach items="${jobTypes}" var="type">
                    <a href="/lankajobshub/jobs?jobType=${type}" class="lift focus-ring surface-soft rounded-2xl p-6 min-w-[220px] lg:min-w-0 shrink-0">
                        <h3 class="text-lg font-semibold" style="color:var(--navy);">${type.displayName}</h3>
                        <p class="mt-2 text-sm" style="color:var(--muted);">${jobTypeCounts[type] != null ? jobTypeCounts[type] : 0} active jobs</p>
                    </a>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- FEATURED JOBS -->
    <section class="py-16 lg:py-20" style="background:var(--paper);">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row md:items-end md:justify-between gap-4 mb-9">
                <h2 class="font-display font-bold text-3xl" style="color:var(--navy);">Featured &amp; latest jobs</h2>
                <a href="/lankajobshub/jobs" class="btn-secondary focus-ring rounded-xl px-5 py-2.5 font-semibold">View all jobs</a>
            </div>
            <c:choose>
                <c:when test="${empty recentJobs}">
                    <div class="rounded-3xl border border-dashed p-10 text-center" style="border-color:var(--line);">
                        <h3 class="text-xl font-display font-bold" style="color:var(--navy);">No active jobs yet</h3>
                        <p class="mt-2" style="color:var(--muted);">Published vacancies will appear here once available.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach items="${recentJobs}" var="job">
                            <article class="lift surface-soft rounded-2xl p-6">
                                <div class="flex items-start justify-between gap-4">
                                    <div>
                                        <p class="text-sm" style="color:var(--muted);">
                                            <c:choose>
                                                <c:when test="${not empty job.company}">${job.company.name}</c:when>
                                                <c:otherwise>LankaJobsHub</c:otherwise>
                                            </c:choose>
                                        </p>
                                        <h3 class="text-xl font-display font-bold mt-1" style="color:var(--navy);">${job.title}</h3>
                                    </div>
                                    <span class="rounded-full px-3 py-1 text-xs font-semibold whitespace-nowrap" style="background:rgba(36,84,224,0.1); color:var(--blue);">${job.status.displayName}</span>
                                </div>
                                <div class="mt-5 space-y-1.5 text-sm" style="color:var(--muted);">
                                    <p>${job.location}</p>
                                    <p>${job.jobType.displayName} • ${job.experienceLevel.displayName}</p>
                                    <c:if test="${job.salaryMin != null || job.salaryMax != null}">
                                        <p>LKR ${job.salaryMin != null ? job.salaryMin : 'N/A'} - ${job.salaryMax != null ? job.salaryMax : 'N/A'}</p>
                                    </c:if>
                                    <c:if test="${job.deadline != null}">
                                        <p>Deadline: ${job.deadline.toString().substring(0, 10)}</p>
                                    </c:if>
                                </div>
                                <a href="/lankajobshub/jobs/${job.id}" class="btn-secondary focus-ring mt-6 inline-flex w-full justify-center rounded-xl px-4 py-3 font-semibold">View job</a>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- HOW IT WORKS (genuine sequence — timeline styling justified) -->
    <section id="how-it-works" class="py-16 lg:py-20 border-y" style="background:var(--paper-soft); border-color:var(--line);">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="font-display font-bold text-3xl mb-12" style="color:var(--navy);">How LankaJobsHub works</h2>
            <div class="relative">
                <div class="hidden md:block absolute top-5 left-0 right-0 h-0.5 step-line"></div>
                <div class="grid md:grid-cols-4 gap-8">
                    <div>
                        <div class="step-node h-10 w-10 rounded-full bg-[color:var(--paper-soft)] flex items-center justify-center font-display font-bold relative z-10">1</div>
                        <h3 class="text-lg font-semibold mt-4" style="color:var(--navy);">Create your profile</h3>
                        <p class="mt-2 text-sm" style="color:var(--muted);">Register and keep your candidate profile ready to apply.</p>
                    </div>
                    <div>
                        <div class="step-node h-10 w-10 rounded-full bg-[color:var(--paper-soft)] flex items-center justify-center font-display font-bold relative z-10">2</div>
                        <h3 class="text-lg font-semibold mt-4" style="color:var(--navy);">Search jobs</h3>
                        <p class="mt-2 text-sm" style="color:var(--muted);">Filter vacancies by title, location, and job type.</p>
                    </div>
                    <div>
                        <div class="step-node h-10 w-10 rounded-full bg-[color:var(--paper-soft)] flex items-center justify-center font-display font-bold relative z-10">3</div>
                        <h3 class="text-lg font-semibold mt-4" style="color:var(--navy);">Apply</h3>
                        <p class="mt-2 text-sm" style="color:var(--muted);">Submit applications and track their status.</p>
                    </div>
                    <div>
                        <div class="step-node h-10 w-10 rounded-full bg-[color:var(--paper-soft)] flex items-center justify-center font-display font-bold relative z-10">4</div>
                        <h3 class="text-lg font-semibold mt-4" style="color:var(--navy);">Interview</h3>
                        <p class="mt-2 text-sm" style="color:var(--muted);">Manage interview schedules and hiring outcomes.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- SEEKERS / EMPLOYERS -->
    <section class="py-16 lg:py-20" style="background:var(--paper);">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid lg:grid-cols-2 gap-6">
                <div class="rounded-3xl p-8 lg:p-10 text-white" style="background:var(--navy);">
                    <p class="font-medium" style="color:#bcd0ff;">For job seekers</p>
                    <h2 class="font-display font-bold text-3xl mt-3">Build your profile and apply with confidence.</h2>
                    <p class="mt-4" style="color:#d3ddf7;">Keep your profile, CV, applications, interviews, and notifications in one place.</p>
                    <a href="/lankajobshub/users/register" class="focus-ring mt-7 inline-flex rounded-full bg-white px-5 py-3 font-semibold hover:bg-slate-100 transition-colors" style="color:var(--navy);">Create profile</a>
                </div>
                <div class="rounded-3xl p-8 lg:p-10 text-white" style="background:#123676;">
                    <p class="font-medium" style="color:#bfe8fb;">For employers &amp; recruiters</p>
                    <h2 class="font-display font-bold text-3xl mt-3">Advertise vacancies and manage applicants faster.</h2>
                    <p class="mt-4" style="color:#d6eefc;">Post jobs, review candidates, schedule interviews, and communicate from a structured workflow.</p>
                    <a href="/lankajobshub/jobs/post" class="focus-ring mt-7 inline-flex rounded-full bg-white px-5 py-3 font-semibold hover:bg-slate-100 transition-colors" style="color:var(--sky);">Post a vacancy</a>
                </div>
            </div>
        </div>
    </section>

    <!-- FEATURED COMPANIES -->
    <c:if test="${not empty featuredCompanies}">
        <section class="py-16 lg:py-20 border-y" style="background:var(--paper-soft); border-color:var(--line);">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h2 class="font-display font-bold text-3xl mb-9" style="color:var(--navy);">Companies hiring now</h2>
                <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
                    <c:forEach items="${featuredCompanies}" var="company">
                        <a href="/lankajobshub/companies/${company.id}" class="lift focus-ring surface-soft rounded-2xl p-6">
                            <h3 class="text-lg font-semibold" style="color:var(--navy);">${company.name}</h3>
                            <c:if test="${not empty company.description}">
                                <p class="mt-2 text-sm" style="color:var(--muted);">${company.description.length() > 120 ? company.description.substring(0, 120).concat('...') : company.description}</p>
                            </c:if>
                            <p class="font-semibold mt-4 text-sm" style="color:var(--blue);">View company →</p>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <!-- FINAL CTA -->
    <section class="py-16 lg:py-20" style="background:var(--paper);">
        <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <div class="rounded-3xl p-10 lg:p-14 text-white" style="background:var(--navy);">
                <h2 class="font-display font-bold text-3xl lg:text-4xl">Ready to move your recruitment forward?</h2>
                <p class="mt-4 max-w-2xl mx-auto" style="color:#d3ddf7;">Search current jobs or create your account to manage applications, interviews, and notifications.</p>
                <div class="mt-8 flex flex-col sm:flex-row justify-center gap-3">
                    <a href="/lankajobshub/jobs" class="focus-ring rounded-full bg-white px-6 py-3 font-semibold hover:bg-slate-100 transition-colors" style="color:var(--navy);">Find jobs</a>
                    <a href="/lankajobshub/users/register" class="focus-ring rounded-full border border-white/25 px-6 py-3 font-semibold text-white hover:bg-white/10 transition-colors">Get started</a>
                </div>
            </div>
        </div>
    </section>
</main>

<footer id="contact" style="background:var(--navy-2);" class="text-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid sm:grid-cols-2 lg:grid-cols-5 gap-8">
            <div class="lg:col-span-2">
                <div class="flex items-center gap-3">
                    <img src="/lankajobshub/static/images/lankajobshub-logo.svg" alt="LankaJobsHub logo" class="h-11 w-11 rounded-2xl bg-white">
                    <span class="text-xl font-display font-bold">LankaJobsHub</span>
                </div>
                <p class="mt-4 max-w-md" style="color:#a8b6d9;">A professional recruitment platform connecting Sri Lankan talent with companies through jobs, applications, interviews, and communication tools.</p>
            </div>
            <div>
                <h3 class="font-semibold mb-4">Navigation</h3>
                <ul class="space-y-3" style="color:#a8b6d9;">
                    <li><a href="/lankajobshub/" class="hover:text-white transition-colors">Home</a></li>
                    <li><a href="/lankajobshub/jobs" class="hover:text-white transition-colors">Find jobs</a></li>
                    <li><a href="/lankajobshub/companies" class="hover:text-white transition-colors">Companies</a></li>
                </ul>
            </div>
            <div>
                <h3 class="font-semibold mb-4">Job seekers</h3>
                <ul class="space-y-3" style="color:#a8b6d9;">
                    <li><a href="/lankajobshub/users/register" class="hover:text-white transition-colors">Create profile</a></li>
                    <li><a href="/lankajobshub/jobs" class="hover:text-white transition-colors">Browse jobs</a></li>
                    <li><a href="/lankajobshub/users/login" class="hover:text-white transition-colors">Login</a></li>
                </ul>
            </div>
            <div>
                <h3 class="font-semibold mb-4">Employers</h3>
                <ul class="space-y-3" style="color:#a8b6d9;">
                    <li><a href="/lankajobshub/jobs/post" class="hover:text-white transition-colors">Post vacancy</a></li>
                    <li><a href="/lankajobshub/companies" class="hover:text-white transition-colors">Company profiles</a></li>
                    <li><a href="/lankajobshub/users/login" class="hover:text-white transition-colors">Account login</a></li>
                </ul>
            </div>
        </div>
        <div class="mt-10 pt-6 border-t flex flex-col md:flex-row justify-between gap-3 text-sm" style="border-color:rgba(255,255,255,0.1); color:#a8b6d9;">
            <p>&copy; 2026 LankaJobsHub. All rights reserved.</p>
            <p>Professional recruitment and job portal platform.</p>
        </div>
    </div>
</footer>
</body>
</html>
