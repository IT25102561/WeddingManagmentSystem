<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.Payment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget Dashboard - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Outfit', sans-serif; } </style>
</head>
<body class="bg-gray-50 min-h-screen">
<nav class="bg-white border-b border-gray-100 sticky top-0 z-40 shadow-sm">
    <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
        <a href="index.jsp" class="flex items-center gap-2">
            <div class="w-8 h-8 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
            </div>
            <span class="font-bold text-gray-800">WeddingBliss</span>
        </a>
        <div class="flex items-center gap-4">
            <a href="client?action=dashboard" class="text-gray-600 hover:text-indigo-600 text-sm font-medium">Dashboard</a>
            <a href="booking?action=history" class="text-gray-600 hover:text-indigo-600 text-sm font-medium">Bookings</a>
            <a href="payment?action=add" id="add-expense-btn" class="px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white text-sm font-semibold rounded-lg hover:shadow-lg transition-all">
                + Add Expense
            </a>
        </div>
    </div>
</nav>

<div class="max-w-6xl mx-auto px-6 py-10">
    <%
        List<Payment> payments = (List<Payment>) request.getAttribute("payments");
        double totalPaid = (Double) request.getAttribute("totalPaid");
        double totalUnpaid = (Double) request.getAttribute("totalUnpaid");
    %>

    <div class="mb-8">
        <h1 class="text-3xl font-extrabold text-gray-900">Budget Dashboard 💰</h1>
        <p class="text-gray-500 mt-1">Track your wedding expenses and payment statuses</p>
    </div>

    <!-- Budget Summary Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-gradient-to-br from-green-500 to-emerald-600 rounded-3xl p-6 text-white shadow-xl">
            <div class="text-sm text-green-100 mb-1">Total Paid</div>
            <div class="text-4xl font-black">LKR <%= String.format("%,.0f", totalPaid) %></div>
        </div>
        <div class="bg-gradient-to-br from-amber-500 to-orange-500 rounded-3xl p-6 text-white shadow-xl">
            <div class="text-sm text-amber-100 mb-1">Pending / Unpaid</div>
            <div class="text-4xl font-black">LKR <%= String.format("%,.0f", totalUnpaid) %></div>
        </div>
        <div class="bg-gradient-to-br from-indigo-600 to-purple-600 rounded-3xl p-6 text-white shadow-xl">
            <div class="text-sm text-indigo-100 mb-1">Total Transactions</div>
            <div class="text-4xl font-black"><%= payments != null ? payments.size() : 0 %></div>
        </div>
    </div>

    <!-- Budget Progress Bar -->
    <% double total = totalPaid + totalUnpaid;
        double paidPct = total > 0 ? (totalPaid / total * 100) : 0; %>
    <div class="bg-white rounded-3xl border border-gray-100 shadow-sm p-6 mb-6">
        <div class="flex justify-between items-center mb-3">
            <h3 class="font-bold text-gray-800">Budget Utilization</h3>
            <span class="text-sm text-gray-500"><%= String.format("%.1f", paidPct) %>% Paid</span>
        </div>
        <div class="w-full bg-gray-100 rounded-full h-4 overflow-hidden">
            <div class="h-4 bg-gradient-to-r from-indigo-600 to-emerald-500 rounded-full transition-all"
                 style="width: <%= paidPct %>%"></div>
        </div>
        <div class="flex justify-between text-xs text-gray-400 mt-2">
            <span>LKR 0</span>
            <span>LKR <%= String.format("%,.0f", total) %> (total budget allocated)</span>
        </div>
    </div>

    <!-- Payments Table -->
    <% if (payments != null && !payments.isEmpty()) { %>
    <div class="bg-white rounded-3xl border border-gray-100 shadow-sm overflow-hidden">
        <div class="p-6 border-b border-gray-100">
            <h2 class="font-bold text-gray-900">Payment History</h2>
        </div>
        <table class="w-full">
            <thead>
            <tr class="bg-gray-50">
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Description</th>
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Vendor</th>
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Amount</th>
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Type</th>
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Status</th>
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Date</th>
                <th class="text-left px-6 py-3 text-xs font-semibold text-gray-500">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Payment p : payments) {
                String sc = "Paid".equals(p.getStatus()) ? "bg-green-100 text-green-700" : "bg-amber-100 text-amber-700";
            %>
            <tr class="border-t border-gray-50 hover:bg-gray-50 transition-colors" id="payment-row-<%= p.getPaymentId() %>">
                <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= p.getDescription() %></td>
                <td class="px-6 py-4 text-sm text-gray-500"><%= p.getVendorName() %></td>
                <td class="px-6 py-4 font-bold text-indigo-600">LKR <%= String.format("%,.0f", p.getAmount()) %></td>
                <td class="px-6 py-4 text-sm text-gray-500"><%= p.getPaymentType() %></td>
                <td class="px-6 py-4">
                    <span class="px-3 py-1 rounded-full text-xs font-bold <%= sc %>"><%= p.getStatus() %></span>
                </td>
                <td class="px-6 py-4 text-sm text-gray-400"><%= p.getPaymentDate() %></td>
                <td class="px-6 py-4">
                    <div class="flex gap-2">
                        <% if (!"Paid".equals(p.getStatus())) { %>
                        <a href="payment?action=markPaid&paymentId=<%= p.getPaymentId() %>"
                           id="markpaid-<%= p.getPaymentId() %>"
                           class="text-xs px-3 py-1.5 bg-green-100 text-green-700 font-semibold rounded-lg hover:bg-green-200 transition-colors">
                            Mark Paid
                        </a>
                        <% } %>
                        <a href="payment?action=delete&paymentId=<%= p.getPaymentId() %>"
                           onclick="return confirm('Delete this payment record?');"
                           id="del-payment-<%= p.getPaymentId() %>"
                           class="text-xs px-3 py-1.5 bg-red-100 text-red-600 font-semibold rounded-lg hover:bg-red-200 transition-colors">
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
    <div class="text-center py-24 bg-white rounded-3xl border border-gray-100 shadow-sm">
        <div class="text-8xl mb-4">💸</div>
        <h3 class="text-2xl font-bold text-gray-800 mb-2">No Expenses Yet</h3>
        <p class="text-gray-500 mb-8">Start tracking your wedding budget!</p>
        <a href="payment?action=add" class="inline-block px-8 py-3 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">Add First Expense</a>
    </div>
    <% } %>
</div>
</body>
</html>
