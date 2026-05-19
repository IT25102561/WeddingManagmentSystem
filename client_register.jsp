<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        @keyframes blob { 0%,100%{border-radius:60% 40% 30% 70%/60% 30% 70% 40%;}50%{border-radius:30% 60% 70% 40%/50% 60% 30% 60%;} }
        .blob { animation: blob 8s ease-in-out infinite; }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-indigo-50 via-white to-purple-50 flex items-center justify-center relative overflow-hidden py-10">
    <div class="absolute top-[-5%] left-[-5%] w-80 h-80 bg-indigo-300/30 blob"></div>
    <div class="absolute bottom-[-5%] right-[-5%] w-96 h-96 bg-purple-300/30 blob" style="animation-delay:3s;"></div>

    <div class="w-full max-w-2xl mx-4 bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10 relative z-10">
        <!-- Logo -->
        <div class="text-center mb-8">
            <a href="index.jsp" class="inline-flex items-center gap-2 mb-4">
                <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-xl flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="text-xl font-bold text-gray-800">WeddingBliss</span>
            </a>
            <h1 class="text-3xl font-extrabold text-gray-900">Create Your Account</h1>
            <p class="text-gray-500 mt-2">Start planning your perfect wedding today</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-2xl text-red-700 text-sm flex items-center gap-2">
            <svg class="w-5 h-5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>
            <%= error %>
        </div>
        <% } %>

        <form action="client" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="register">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Full Name</label>
                    <input type="text" name="fullName" id="reg-fullname" required placeholder="e.g. Nimal & Kamala"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Phone Number</label>
                    <input type="tel" name="phone" id="reg-phone" required placeholder="077 123 4567"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
                </div>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Email Address</label>
                <input type="email" name="email" id="reg-email" required placeholder="your@email.com"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Password</label>
                <input type="password" name="password" id="reg-password" required placeholder="Create a strong password"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Wedding Date</label>
                    <input type="date" name="weddingDate" id="reg-weddingdate" required
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Total Budget (LKR)</label>
                    <input type="number" name="budget" id="reg-budget" required placeholder="500000" min="0" step="1000"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
                </div>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Wedding Location</label>
                <input type="text" name="weddingLocation" id="reg-location" required placeholder="e.g. Colombo, Kandy"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition-all bg-white/70">
            </div>

            <button type="submit" id="reg-submit-btn"
                    class="w-full py-4 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-bold rounded-xl shadow-lg hover:shadow-indigo-200 hover:shadow-xl hover:-translate-y-0.5 transition-all text-lg">
                Create My Account 🎉
            </button>
        </form>

        <p class="text-center text-gray-500 text-sm mt-6">
            Already have an account?
            <a href="client?action=login" id="goto-login" class="text-indigo-600 font-semibold hover:text-indigo-800 transition-colors">Sign In</a>
        </p>
    </div>
</body>
</html>
