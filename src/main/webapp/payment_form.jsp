<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.Vendor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Expense - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Outfit', sans-serif; } </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-emerald-50 via-white to-indigo-50 flex items-center justify-center py-10">
<div class="w-full max-w-lg mx-4 bg-white/85 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10">
    <div class="text-center mb-8">
        <h1 class="text-3xl font-extrabold text-gray-900">Add Expense 💰</h1>
        <p class="text-gray-500 mt-2">Track a new wedding payment or expense</p>
    </div>

    <form action="payment" method="POST" class="space-y-5">
        <input type="hidden" name="action" value="add">

        <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1.5">Vendor / Service</label>
            <select name="vendorId" id="pf-vendor"
                    class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-emerald-400 outline-none bg-white">
                <option value="general">General Expense (No specific vendor)</option>
                <% List<Vendor> vendors = (List<Vendor>) request.getAttribute("vendors");
                    if (vendors != null) {
                        for (Vendor v : vendors) { %>
                <option value="<%= v.getId() %>"><%= v.getBusinessName() %> (<%= v.getCategory() %>)</option>
                <% } } %>
            </select>
        </div>

        <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1.5">Description</label>
            <input type="text" name="description" id="pf-description" required placeholder="e.g. Photography deposit, Venue booking"
                   class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-emerald-400 outline-none transition-all">
        </div>

        <div class="grid grid-cols-2 gap-5">
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Amount (LKR)</label>
                <input type="number" name="amount" id="pf-amount" required placeholder="25000" min="0" step="100"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-emerald-400 outline-none transition-all">
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Payment Method</label>
                <select name="paymentType" id="pf-paytype"
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-emerald-400 outline-none bg-white">
                    <option>Cash</option>
                    <option>Bank Transfer</option>
                    <option>Credit Card</option>
                </select>
            </div>
        </div>

        <div class="flex items-center justify-between pt-2">
            <a href="payment?action=dashboard" class="text-emerald-600 hover:text-emerald-800 font-medium transition-colors">← Cancel</a>
            <button type="submit" id="pf-submit-btn"
                    class="px-8 py-3 bg-gradient-to-r from-emerald-500 to-teal-500 text-white font-bold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                Add to Budget
            </button>
        </div>
    </form>
</div>
</body>
</html>
