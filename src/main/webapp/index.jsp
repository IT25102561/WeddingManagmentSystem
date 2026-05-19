<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="WeddingBliss - Your complete wedding planning and vendor booking platform. Find photographers, venues, catering, and more.">
    <title>WeddingBliss - Plan Your Perfect Wedding</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        .gradient-text { background: linear-gradient(135deg, #6366f1, #a855f7, #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .hero-bg { background: linear-gradient(135deg, #0f0c29, #302b63, #24243e); }
        .glass { background: rgba(255,255,255,0.08); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.15); }
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-8px); box-shadow: 0 25px 50px rgba(0,0,0,0.15); }
        @keyframes float { 0%,100% { transform: translateY(0); } 50% { transform: translateY(-20px); } }
        @keyframes blob { 0%,100% { border-radius: 60% 40% 30% 70%/60% 30% 70% 40%; } 50% { border-radius: 30% 60% 70% 40%/50% 60% 30% 60%; } }
        .float { animation: float 6s ease-in-out infinite; }
        .blob { animation: blob 8s ease-in-out infinite; }
        .blob2 { animation: blob 10s ease-in-out infinite reverse; }
    </style>
</head>
<body class="bg-gray-50 overflow-x-hidden">

    <!-- Navigation -->
    <nav class="fixed top-0 w-full z-50 bg-white/90 backdrop-blur-xl border-b border-gray-100 shadow-sm">
        <div class="max-w-7xl mx-auto px-6 h-18 flex items-center justify-between py-4">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="text-2xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">WeddingBliss</span>
            </div>
            <div class="hidden md:flex items-center gap-6">
                <a href="vendor?action=list" class="text-gray-600 hover:text-indigo-600 font-medium transition-colors">Vendors</a>
                <a href="review?action=list" class="text-gray-600 hover:text-indigo-600 font-medium transition-colors">Reviews</a>
                <a href="client?action=login" class="text-gray-600 hover:text-indigo-600 font-medium transition-colors">Client Login</a>
                <a href="admin?action=login" class="text-gray-500 hover:text-indigo-600 text-sm font-medium transition-colors">Admin</a>
                <a href="client?action=register" class="px-5 py-2.5 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold rounded-full shadow-lg hover:shadow-indigo-200 hover:shadow-xl transition-all text-sm">Get Started</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-bg min-h-screen flex items-center relative overflow-hidden pt-20">
        <!-- Animated blobs -->
        <div class="absolute top-20 left-10 w-72 h-72 bg-indigo-500/30 blob"></div>
        <div class="absolute bottom-20 right-10 w-96 h-96 bg-purple-500/20 blob2"></div>
        <div class="absolute top-1/2 left-1/2 w-64 h-64 bg-pink-500/20 blob" style="animation-delay: 3s;"></div>

        <div class="max-w-7xl mx-auto px-6 relative z-10 py-20">
            <div class="grid lg:grid-cols-2 gap-16 items-center">
                <div>
                    <div class="inline-flex items-center gap-2 px-4 py-2 bg-white/10 rounded-full text-white/80 text-sm font-medium mb-8 border border-white/20">
                        <span class="w-2 h-2 bg-green-400 rounded-full animate-pulse"></span>
                        Sri Lanka's #1 Wedding Platform
                    </div>
                    <h1 class="text-6xl font-black text-white leading-tight mb-6">
                        Plan Your <br>
                        <span class="gradient-text">Dream Wedding</span><br>
                        With Ease
                    </h1>
                    <p class="text-white/70 text-xl mb-10 leading-relaxed">
                        Discover top photographers, stunning venues, expert caterers, and more. 
                        Book everything in one place and manage your budget effortlessly.
                    </p>
                    <div class="flex flex-wrap gap-4">
                        <a href="client?action=register" id="hero-register-btn" class="px-8 py-4 bg-gradient-to-r from-indigo-500 to-purple-600 text-white font-bold rounded-2xl shadow-2xl shadow-indigo-500/30 hover:shadow-indigo-500/50 hover:-translate-y-1 transition-all text-lg">
                            Start Planning Free →
                        </a>
                        <a href="vendor?action=list" id="hero-browse-btn" class="px-8 py-4 glass text-white font-bold rounded-2xl hover:-translate-y-1 transition-all text-lg">
                            Browse Vendors
                        </a>
                    </div>

                    <!-- Stats -->
                    <div class="grid grid-cols-3 gap-6 mt-12">
                        <div class="glass rounded-2xl p-4 text-center">
                            <div class="text-3xl font-black text-white">200+</div>
                            <div class="text-white/60 text-sm mt-1">Vendors</div>
                        </div>
                        <div class="glass rounded-2xl p-4 text-center">
                            <div class="text-3xl font-black text-white">1.2K</div>
                            <div class="text-white/60 text-sm mt-1">Weddings</div>
                        </div>
                        <div class="glass rounded-2xl p-4 text-center">
                            <div class="text-3xl font-black text-white">4.9★</div>
                            <div class="text-white/60 text-sm mt-1">Rating</div>
                        </div>
                    </div>
                </div>

                <!-- Hero Image Cards -->
                <div class="hidden lg:block relative float">
                    <div class="grid grid-cols-2 gap-4">
                        <div class="glass rounded-3xl overflow-hidden h-64">
                            <img src="https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=400&q=80" class="w-full h-full object-cover opacity-80">
                        </div>
                        <div class="glass rounded-3xl overflow-hidden h-64 mt-8">
                            <img src="https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=400&q=80" class="w-full h-full object-cover opacity-80">
                        </div>
                        <div class="glass rounded-3xl overflow-hidden h-48">
                            <img src="https://images.unsplash.com/photo-1555244162-803834f70033?auto=format&fit=crop&w=400&q=80" class="w-full h-full object-cover opacity-80">
                        </div>
                        <div class="glass rounded-3xl overflow-hidden h-48 mt-4">
                            <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?auto=format&fit=crop&w=400&q=80" class="w-full h-full object-cover opacity-80">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="py-24 bg-white">
        <div class="max-w-7xl mx-auto px-6">
            <div class="text-center mb-16">
                <h2 class="text-4xl font-black text-gray-900 mb-4">Everything You Need</h2>
                <p class="text-gray-500 text-lg max-w-2xl mx-auto">From photography to catering, find all your wedding vendors in one place.</p>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-6">
                <% String[][] cats = {
                    {"Photography", "📸", "from-indigo-500", "to-blue-600", "photographer"},
                    {"Venue", "🏛️", "from-purple-500", "to-indigo-600", "venue"},
                    {"Catering", "🍽️", "from-pink-500", "to-rose-600", "catering"},
                    {"Music", "🎵", "from-amber-500", "to-orange-600", "music"},
                    {"Decoration", "💐", "from-emerald-500", "to-teal-600", "decoration"}
                };
                for (String[] cat : cats) { %>
                <a href="vendor?action=list&category=<%= cat[0] %>" id="cat-<%= cat[4] %>" class="card-hover group bg-gray-50 rounded-3xl p-6 text-center border border-gray-100 hover:border-indigo-200">
                    <div class="w-16 h-16 bg-gradient-to-br from-<%= cat[2].replace("from-","") %> to-<%= cat[3].replace("to-","") %> rounded-2xl flex items-center justify-center mx-auto mb-4 text-3xl group-hover:scale-110 transition-transform shadow-lg">
                        <%= cat[1] %>
                    </div>
                    <div class="font-bold text-gray-800 group-hover:text-indigo-600 transition-colors"><%= cat[0] %></div>
                </a>
                <% } %>
            </div>
        </div>
    </section>

    <!-- How It Works -->
    <section class="py-24 bg-gradient-to-br from-indigo-50 to-purple-50">
        <div class="max-w-7xl mx-auto px-6">
            <div class="text-center mb-16">
                <h2 class="text-4xl font-black text-gray-900 mb-4">How It Works</h2>
                <p class="text-gray-500 text-lg">Three simple steps to your perfect wedding</p>
            </div>
            <div class="grid md:grid-cols-3 gap-10">
                <% String[][] steps = {
                    {"01", "Register & Set Budget", "Create your couple profile, set your wedding date and total budget to get started.", "🎯"},
                    {"02", "Browse & Book Vendors", "Explore verified vendors by category, read reviews, and book the ones you love.", "🔍"},
                    {"03", "Track & Manage", "Monitor your bookings, track payments, and plan everything from your dashboard.", "✅"}
                };
                for (String[] step : steps) { %>
                <div class="bg-white rounded-3xl p-8 shadow-sm border border-gray-100 card-hover">
                    <div class="text-5xl mb-4"><%= step[3] %></div>
                    <div class="text-7xl font-black text-indigo-100 mb-2"><%= step[0] %></div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3"><%= step[1] %></h3>
                    <p class="text-gray-500 leading-relaxed"><%= step[2] %></p>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-24 hero-bg relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-r from-indigo-600/50 to-purple-600/50"></div>
        <div class="max-w-4xl mx-auto px-6 text-center relative z-10">
            <h2 class="text-5xl font-black text-white mb-6">Ready to Start Planning?</h2>
            <p class="text-white/70 text-xl mb-10">Join thousands of couples who planned their perfect wedding with WeddingBliss.</p>
            <div class="flex flex-wrap gap-4 justify-center">
                <a href="client?action=register" class="px-10 py-4 bg-white text-indigo-600 font-bold rounded-2xl shadow-2xl hover:-translate-y-1 transition-all text-lg">Create Free Account</a>
                <a href="vendor?action=register" class="px-10 py-4 glass text-white font-bold rounded-2xl hover:-translate-y-1 transition-all text-lg border border-white/30">Join as Vendor</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white py-12">
        <div class="max-w-7xl mx-auto px-6">
            <div class="grid md:grid-cols-4 gap-8 mb-8">
                <div>
                    <div class="flex items-center gap-2 mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-lg flex items-center justify-center">
                            <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                        </div>
                        <span class="font-bold text-lg">WeddingBliss</span>
                    </div>
                    <p class="text-gray-400 text-sm">Sri Lanka's premier wedding planning platform.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-3">For Couples</h4>
                    <ul class="space-y-2 text-gray-400 text-sm">
                        <li><a href="client?action=register" class="hover:text-white transition-colors">Register</a></li>
                        <li><a href="vendor?action=list" class="hover:text-white transition-colors">Find Vendors</a></li>
                        <li><a href="booking?action=history" class="hover:text-white transition-colors">My Bookings</a></li>
                        <li><a href="payment?action=dashboard" class="hover:text-white transition-colors">Budget Tracker</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-3">For Vendors</h4>
                    <ul class="space-y-2 text-gray-400 text-sm">
                        <li><a href="vendor?action=register" class="hover:text-white transition-colors">List Your Business</a></li>
                        <li><a href="booking?action=manage" class="hover:text-white transition-colors">Manage Bookings</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-3">Admin</h4>
                    <ul class="space-y-2 text-gray-400 text-sm">
                        <li><a href="admin?action=login" class="hover:text-white transition-colors">Admin Login</a></li>
                        <li><a href="admin?action=dashboard" class="hover:text-white transition-colors">Dashboard</a></li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-gray-800 pt-8 text-center text-gray-500 text-sm">
                © 2025 WeddingBliss. Built for SE1020 OOP Project. All rights reserved.
            </div>
        </div>
    </footer>

</body>
</html>
