<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.Booking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Outfit', sans-serif; } </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Navbar -->
    <nav class="bg-white border-b border-gray-100 sticky top-0 z-40 shadow-sm">
        <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="index.jsp" class="flex items-center gap-2">
                <div class="w-8 h-8 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="font-bold text-gray-800">WeddingBliss</span>
            </a>
            <div class="flex items-center gap-4">
                <a href="vendor?action=list" class="text-gray-600 hover:text-indigo-600 text-sm font-medium">Browse Vendors</a>
                <a href="client?action=dashboard" class="text-gray-600 hover:text-indigo-600 text-sm font-medium">Dashboard</a>
                <a href="payment?action=dashboard" class="text-gray-600 hover:text-indigo-600 text-sm font-medium">Budget</a>
            </div>
        </div>
    </nav>

    <div class="max-w-6xl mx-auto px-6 py-10">
        <div class="flex items-center justify-between mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-gray-900">My Bookings 📋</h1>
                <p class="text-gray-500 mt-1">Track all your vendor booking requests</p>
            </div>
            <a href="vendor?action=list" id="bh-browse-btn" class="px-5 py-2.5 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all text-sm">
                + Book New Vendor
            </a>
        </div>

        <% List<Booking> bookings = (List<Booking>) request.getAttribute("bookings"); %>
        <% if (bookings != null && !bookings.isEmpty()) { %>

        <!-- Summary Cards -->
        <div class="grid grid-cols-3 gap-4 mb-8">
            <div class="bg-white rounded-2xl p-5 border border-gray-100 shadow-sm text-center">
                <div class="text-3xl font-black text-gray-900"><%= bookings.size() %></div>
                <div class="text-gray-500 text-sm mt-1">Total Bookings</div>
            </div>
            <div class="bg-amber-50 rounded-2xl p-5 border border-amber-100 shadow-sm text-center">
                <div class="text-3xl font-black text-amber-600">
                    <%= bookings.stream().filter(b -> "Pending".equals(b.getStatus())).count() %>
                </div>
                <div class="text-amber-600 text-sm mt-1">Pending</div>
            </div>
            <div class="bg-green-50 rounded-2xl p-5 border border-green-100 shadow-sm text-center">
                <div class="text-3xl font-black text-green-600">
                    <%= bookings.stream().filter(b -> "Confirmed".equals(b.getStatus())).count() %>
                </div>
                <div class="text-green-600 text-sm mt-1">Confirmed</div>
            </div>
        </div>

        <!-- Bookings Table -->
        <div class="bg-white rounded-3xl border border-gray-100 shadow-sm overflow-hidden">
            <table class="w-full">
                <thead>
                    <tr class="bg-gray-50 border-b border-gray-100">
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Vendor</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Category</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Event Date</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Amount</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Status</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking b : bookings) {
                        String statusClass = "Confirmed".equals(b.getStatus()) ? "bg-green-100 text-green-700"
                                          : "Cancelled".equals(b.getStatus()) ? "bg-red-100 text-red-700"
                                          : "bg-amber-100 text-amber-700";
                    %>
                    <tr class="border-b border-gray-50 hover:bg-gray-50 transition-colors" id="booking-row-<%= b.getBookingId() %>">
                        <td class="px-6 py-4">
                            <div class="font-semibold text-gray-900"><%= b.getVendorName() %></div>
                            <div class="text-xs text-gray-400">Booked: <%= b.getBookingDate() %></div>
                        </td>
                        <td class="px-6 py-4 text-gray-600 text-sm"><%= b.getVendorCategory() %></td>
                        <td class="px-6 py-4 text-gray-600 text-sm"><%= b.getEventDate() %></td>
                        <td class="px-6 py-4 font-semibold text-indigo-600">LKR <%= String.format("%,.0f", b.getAmount()) %></td>
                        <td class="px-6 py-4">
                            <span class="px-3 py-1 rounded-full text-xs font-bold <%= statusClass %>"><%= b.getStatus() %></span>
                        </td>
                        <td class="px-6 py-4">
                            <% if (!"Cancelled".equals(b.getStatus())) { %>
                            <a href="booking?action=cancel&bookingId=<%= b.getBookingId() %>"
                               onclick="return confirm('Cancel this booking?');"
                               id="cancel-booking-<%= b.getBookingId() %>"
                               class="text-red-500 hover:text-red-700 text-sm font-medium transition-colors">
                                Cancel
                            </a>
                            <% } else { %>
                            <span class="text-gray-400 text-sm">Cancelled</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <% } else { %>
        <div class="text-center py-24 bg-white rounded-3xl border border-gray-100 shadow-sm">
            <div class="text-8xl mb-4">📅</div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">No Bookings Yet</h3>
            <p class="text-gray-500 mb-8">Start exploring vendors and make your first booking!</p>
            <a href="vendor?action=list" class="inline-block px-8 py-3 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">Browse Vendors</a>
        </div>
        <% } %>
    </div>
</body>
</html>
