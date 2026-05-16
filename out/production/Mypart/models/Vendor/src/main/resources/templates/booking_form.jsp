<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Vendor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vendor - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Outfit', sans-serif; } </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-pink-50 via-white to-indigo-50 flex items-center justify-center py-10">
    <% Vendor vendor = (Vendor) request.getAttribute("vendor");
       if (vendor == null) { response.sendRedirect("vendor?action=list"); return; } %>

    <div class="w-full max-w-lg mx-4 bg-white/85 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10">
        <div class="text-center mb-8">
            <div class="inline-flex items-center gap-2 px-4 py-2 bg-pink-100 text-pink-700 rounded-full text-sm font-semibold mb-4">
                📅 New Booking
            </div>
            <h1 class="text-3xl font-extrabold text-gray-900">Book Your Vendor</h1>
            <p class="text-gray-500 mt-2">Complete your booking request below</p>
        </div>

        <!-- Vendor Info Card -->
        <div class="mb-6 p-5 bg-gradient-to-r from-indigo-600 to-purple-600 rounded-2xl text-white">
            <div class="flex justify-between items-start">
                <div>
                    <h3 class="text-xl font-bold"><%= vendor.getBusinessName() %></h3>
                    <p class="text-white/80 text-sm"><%= vendor.getCategory() %> · <%= vendor.getLocation() %></p>
                </div>
                <div class="text-right">
                    <div class="text-2xl font-black">LKR <%= String.format("%,.0f", vendor.getBasePrice()) %></div>
                    <div class="text-white/70 text-xs">Base Price</div>
                </div>
            </div>
            <div class="mt-3 p-3 bg-white/15 rounded-xl">
                <p class="text-white/90 text-sm italic"><%= vendor.displayPackageDetails() %></p>
            </div>
        </div>

        <form action="booking" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="vendorId" value="<%= vendor.getId() %>">
            <input type="hidden" name="amount" value="<%= vendor.getBasePrice() %>">

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Your Name</label>
                <input type="text" name="clientName" id="bk-clientname" required placeholder="Your full name"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-pink-400 outline-none transition-all">
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Event Date</label>
                <input type="date" name="eventDate" id="bk-eventdate" required
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-pink-400 outline-none transition-all">
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Special Notes / Requirements</label>
                <textarea name="notes" id="bk-notes" rows="3" placeholder="Any special requests or information..."
                          class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-pink-400 outline-none transition-all resize-none"></textarea>
            </div>

            <div class="bg-gray-50 rounded-xl p-4 border border-gray-100">
                <div class="flex justify-between text-sm text-gray-600 mb-1">
                    <span>Booking Amount</span>
                    <span class="font-semibold">LKR <%= String.format("%,.0f", vendor.getBasePrice()) %></span>
                </div>
                <div class="flex justify-between text-sm text-gray-500">
                    <span>Status after submission</span>
                    <span class="text-amber-600 font-semibold">Pending Confirmation</span>
                </div>
            </div>

            <div class="flex items-center justify-between pt-2">
                <a href="vendor?action=list" class="text-pink-600 hover:text-pink-800 font-medium transition-colors">← Back</a>
                <button type="submit" id="bk-submit-btn"
                        class="px-8 py-3 bg-gradient-to-r from-pink-600 to-rose-500 text-white font-bold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                    Send Booking Request 💌
                </button>
            </div>
        </form>
    </div>
</body>
</html>
