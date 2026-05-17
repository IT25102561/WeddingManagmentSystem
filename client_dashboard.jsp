<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Client" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        .nav-link { @apply text-gray-600 hover:text-indigo-600 font-medium transition-colors; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <% Client client = (Client) request.getAttribute("client");
       if (client == null) { response.sendRedirect("client?action=login"); return; } %>

    <!-- Navbar -->
    <nav class="bg-white border-b border-gray-100 sticky top-0 z-40 shadow-sm">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="index.jsp" class="flex items-center gap-2">
                <div class="w-8 h-8 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="font-bold text-gray-800">WeddingBliss</span>
            </a>
            <div class="flex items-center gap-6">
                <a href="vendor?action=list" class="text-gray-600 hover:text-indigo-600 font-medium text-sm transition-colors">Browse Vendors</a>
                <a href="booking?action=history" class="text-gray-600 hover:text-indigo-600 font-medium text-sm transition-colors">My Bookings</a>
                <a href="payment?action=dashboard" class="text-gray-600 hover:text-indigo-600 font-medium text-sm transition-colors">Budget</a>
                <a href="client?action=logout" class="px-4 py-2 text-red-500 border border-red-200 hover:bg-red-50 font-medium text-sm rounded-lg transition-colors">Logout</a>
            </div>
        </div>
    </nav>

    <div class="max-w-5xl mx-auto px-6 py-10">
        <!-- Welcome Header -->
        <div class="bg-gradient-to-r from-indigo-600 to-purple-600 rounded-3xl p-8 mb-8 text-white shadow-xl">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-white/70 text-sm mb-1">Welcome back 💍</p>
                    <h1 class="text-3xl font-extrabold mb-1"><%= client.getFullName() %></h1>
                    <p class="text-white/70"><%= client.getEmail() %></p>
                </div>
                <div class="hidden md:grid grid-cols-2 gap-4">
                    <div class="bg-white/15 rounded-2xl p-4 text-center">
                        <div class="text-2xl font-black">LKR <%= String.format("%,.0f", client.getBudget()) %></div>
                        <div class="text-white/70 text-xs mt-1">Total Budget</div>
                    </div>
                    <div class="bg-white/15 rounded-2xl p-4 text-center">
                        <div class="text-2xl font-black"><%= client.getWeddingDate() %></div>
                        <div class="text-white/70 text-xs mt-1">Wedding Date</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
            <a href="vendor?action=list" id="dash-browse-vendors" class="bg-white rounded-2xl p-5 border border-gray-100 hover:border-indigo-300 hover:shadow-lg transition-all text-center group">
                <div class="text-3xl mb-2">🔍</div>
                <div class="font-semibold text-gray-700 group-hover:text-indigo-600 text-sm">Browse Vendors</div>
            </a>
            <a href="booking?action=history" id="dash-my-bookings" class="bg-white rounded-2xl p-5 border border-gray-100 hover:border-indigo-300 hover:shadow-lg transition-all text-center group">
                <div class="text-3xl mb-2">📋</div>
                <div class="font-semibold text-gray-700 group-hover:text-indigo-600 text-sm">My Bookings</div>
            </a>
            <a href="payment?action=dashboard" id="dash-budget" class="bg-white rounded-2xl p-5 border border-gray-100 hover:border-indigo-300 hover:shadow-lg transition-all text-center group">
                <div class="text-3xl mb-2">💰</div>
                <div class="font-semibold text-gray-700 group-hover:text-indigo-600 text-sm">Budget Tracker</div>
            </a>
            <a href="review?action=list" id="dash-reviews" class="bg-white rounded-2xl p-5 border border-gray-100 hover:border-indigo-300 hover:shadow-lg transition-all text-center group">
                <div class="text-3xl mb-2">⭐</div>
                <div class="font-semibold text-gray-700 group-hover:text-indigo-600 text-sm">Reviews</div>
            </a>
        </div>

        <!-- Edit Profile Form -->
        <div class="bg-white rounded-3xl border border-gray-100 shadow-sm p-8">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-bold text-gray-900">Edit Profile</h2>
                <div class="w-10 h-10 bg-indigo-100 text-indigo-600 rounded-xl flex items-center justify-center">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                </div>
            </div>

            <form action="client" method="POST" class="space-y-5">
                <input type="hidden" name="action" value="update">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div>
                        <label class="block text-sm font-semibold text-gray-600 mb-1.5">Full Name</label>
                        <input type="text" name="fullName" id="edit-fullname" value="<%= client.getFullName() %>" required
                               class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-semibold text-gray-600 mb-1.5">Phone</label>
                        <input type="tel" name="phone" id="edit-phone" value="<%= client.getPhone() %>" required
                               class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div>
                        <label class="block text-sm font-semibold text-gray-600 mb-1.5">Wedding Date</label>
                        <input type="date" name="weddingDate" id="edit-weddingdate" value="<%= client.getWeddingDate() %>" required
                               class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-semibold text-gray-600 mb-1.5">Total Budget (LKR)</label>
                        <input type="number" name="budget" id="edit-budget" value="<%= client.getBudget() %>" required min="0" step="1000"
                               class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-semibold text-gray-600 mb-1.5">Wedding Location</label>
                    <input type="text" name="weddingLocation" id="edit-location" value="<%= client.getWeddingLocation() %>" required
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all">
                </div>

                <div class="flex items-center justify-between pt-2">
                    <a href="client?action=delete"
                       onclick="return confirm('Are you sure you want to delete your account? This cannot be undone.')"
                       id="delete-account-btn"
                       class="text-red-500 hover:text-red-700 font-medium text-sm transition-colors">
                        Delete Account
                    </a>
                    <button type="submit" id="save-profile-btn"
                            class="px-8 py-3 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-bold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
