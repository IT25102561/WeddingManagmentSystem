<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.Booking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - WeddingBliss Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Outfit', sans-serif; } </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <nav class="bg-white border-b border-gray-100 sticky top-0 z-40 shadow-sm">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="admin?action=dashboard" class="flex items-center gap-2">
                <div class="w-8 h-8 bg-gradient-to-br from-red-500 to-orange-500 rounded-lg flex items-center justify-center text-white text-xs font-bold">A</div>
                <span class="font-bold text-gray-800">Admin Panel</span>
            </a>
            <a href="admin?action=dashboard" class="text-indigo-600 hover:text-indigo-800 text-sm font-medium">← Dashboard</a>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-6 py-10">
        <div class="flex items-center justify-between mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-gray-900">Booking Management</h1>
                <p class="text-gray-500 mt-1">View and manage all booking requests</p>
            </div>
        </div>

        <% List<Booking> bookings = (List<Booking>) request.getAttribute("bookings"); %>
        <% if (bookings != null && !bookings.isEmpty()) { %>

        <div class="bg-white rounded-3xl border border-gray-100 shadow-sm overflow-hidden">
            <table class="w-full">
                <thead>
                    <tr class="bg-gray-50 border-b border-gray-100">
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Client</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Vendor</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Event Date</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Amount</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Status</th>
                        <th class="text-left px-6 py-4 text-sm font-semibold text-gray-600">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking b : bookings) {
                        String sc = "Confirmed".equals(b.getStatus()) ? "bg-green-100 text-green-700"
                                  : "Cancelled".equals(b.getStatus()) ? "bg-red-100 text-red-700"
                                  : "bg-amber-100 text-amber-700";
                    %>
                    <tr class="border-b border-gray-50 hover:bg-gray-50 transition-colors">
                        <td class="px-6 py-4">
                            <div class="text-sm font-semibold text-gray-800"><%= b.getClientId().substring(0,8) %>...</div>
                            <div class="text-xs text-gray-400"><%= b.getBookingDate() %></div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="font-semibold text-gray-900 text-sm"><%= b.getVendorName() %></div>
                            <div class="text-xs text-gray-400"><%= b.getVendorCategory() %></div>
                        </td>
                        <td class="px-6 py-4 text-gray-600 text-sm"><%= b.getEventDate() %></td>
                        <td class="px-6 py-4 font-semibold text-indigo-600 text-sm">LKR <%= String.format("%,.0f", b.getAmount()) %></td>
                        <td class="px-6 py-4">
                            <span class="px-3 py-1 rounded-full text-xs font-bold <%= sc %>"><%= b.getStatus() %></span>
                        </td>
                        <td class="px-6 py-4">
                            <div class="flex gap-2">
                                <% if ("Pending".equals(b.getStatus())) { %>
                                <a href="booking?action=confirm&bookingId=<%= b.getBookingId() %>"
                                   id="confirm-booking-<%= b.getBookingId() %>"
                                   class="text-xs px-3 py-1.5 bg-green-100 text-green-700 font-semibold rounded-lg hover:bg-green-200 transition-colors">
                                    Confirm
                                </a>
                                <% } %>
                                <a href="booking?action=cancel&bookingId=<%= b.getBookingId() %>"
                                   onclick="return confirm('Delete this booking?');"
                                   id="del-booking-<%= b.getBookingId() %>"
                                   class="text-xs px-3 py-1.5 bg-red-100 text-red-700 font-semibold rounded-lg hover:bg-red-200 transition-colors">
                                    Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <% } else { %>
        <div class="text-center py-24 bg-white rounded-3xl border border-gray-100">
            <div class="text-6xl mb-4">📭</div>
            <h3 class="text-xl font-bold text-gray-700">No Bookings Yet</h3>
        </div>
        <% } %>
    </div>
</body>
</html>
