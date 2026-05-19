<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Login - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        @keyframes blob { 0%,100%{border-radius:60% 40% 30% 70%/60% 30% 70% 40%;}50%{border-radius:30% 60% 70% 40%/50% 60% 30% 60%;} }
        .blob { animation: blob 8s ease-in-out infinite; }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-purple-50 via-white to-indigo-50 flex items-center justify-center relative overflow-hidden">
    <div class="absolute top-0 right-0 w-96 h-96 bg-purple-200/40 blob"></div>
    <div class="absolute bottom-0 left-0 w-80 h-80 bg-indigo-200/40 blob" style="animation-delay:4s;"></div>

    <div class="w-full max-w-md mx-4 bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10 relative z-10">
        <div class="text-center mb-8">
            <a href="index.jsp" class="inline-flex items-center gap-2 mb-4">
                <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-xl flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="text-xl font-bold text-gray-800">WeddingBliss</span>
            </a>
            <h1 class="text-3xl font-extrabold text-gray-900">Welcome Back 👋</h1>
            <p class="text-gray-500 mt-2">Sign in to continue planning your wedding</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-2xl text-red-700 text-sm">
            <%= error %>
        </div>
        <% } %>

        <form action="client" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="login">

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Email Address</label>
                <input type="email" name="email" id="login-email" required placeholder="your@email.com"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Password</label>
                <input type="password" name="password" id="login-password" required placeholder="Your password"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
            </div>

            <button type="submit" id="login-btn"
                    class="w-full py-4 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-bold rounded-xl shadow-lg hover:shadow-indigo-200 hover:shadow-xl hover:-translate-y-0.5 transition-all text-lg">
                Sign In →
            </button>
        </form>

        <p class="text-center text-gray-500 text-sm mt-6">
            Don't have an account?
            <a href="client?action=register" id="goto-register" class="text-indigo-600 font-semibold hover:text-indigo-800 transition-colors">Register Now</a>
        </p>

        <div class="mt-4 p-3 bg-indigo-50 rounded-xl text-xs text-indigo-700 text-center">
            Demo: Use any email you registered with
        </div>
    </div>
</body>
</html>
