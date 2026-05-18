<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Vendor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write a Review - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        .star { cursor: pointer; font-size: 2rem; color: #e2e8f0; transition: color 0.15s; }
        .star.active, .star:hover, .star:hover ~ .star + .star { color: #f59e0b; }
        .stars:hover .star { color: #f59e0b; }
        .stars .star:hover ~ .star { color: #e2e8f0; }
    </style>
    <script>
        function setRating(n) {
            document.getElementById('rf-rating').value = n;
            const stars = document.querySelectorAll('.star');
            stars.forEach((s, i) => { s.classList.toggle('active', i < n); });
        }
    </script>
</head>
<body class="min-h-screen bg-gradient-to-br from-yellow-50 via-white to-indigo-50 flex items-center justify-center py-10">
    <% Vendor vendor = (Vendor) request.getAttribute("vendor"); %>

    <div class="w-full max-w-lg mx-4 bg-white/85 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10">
        <div class="text-center mb-8">
            <div class="inline-flex items-center gap-2 px-4 py-2 bg-yellow-100 text-yellow-700 rounded-full text-sm font-semibold mb-4">
                ⭐ Write a Review
            </div>
            <h1 class="text-3xl font-extrabold text-gray-900">Share Your Experience</h1>
            <% if (vendor != null) { %>
            <p class="text-gray-500 mt-2">Reviewing: <span class="font-semibold text-indigo-600"><%= vendor.getBusinessName() %></span></p>
            <% } %>
        </div>

        <form action="review" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="submit">
            <input type="hidden" name="vendorId" value="<%= vendor != null ? vendor.getId() : "" %>">
            <input type="hidden" name="rating" id="rf-rating" value="5">

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Your Name</label>
                <input type="text" name="clientName" id="rf-name" required placeholder="Your full name"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-yellow-400 outline-none transition-all">
            </div>

            <!-- Star Rating -->
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Rating</label>
                <div class="stars flex gap-2">
                    <span class="star active" onclick="setRating(1)">★</span>
                    <span class="star active" onclick="setRating(2)">★</span>
                    <span class="star active" onclick="setRating(3)">★</span>
                    <span class="star active" onclick="setRating(4)">★</span>
                    <span class="star active" onclick="setRating(5)">★</span>
                </div>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1.5">Your Review</label>
                <textarea name="comment" id="rf-comment" rows="4" required
                          placeholder="Share your experience with this vendor..."
                          class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-yellow-400 outline-none transition-all resize-none"></textarea>
            </div>

            <div class="flex items-center justify-between pt-2">
                <% if (vendor != null) { %>
                <a href="review?action=list&vendorId=<%= vendor.getId() %>" class="text-yellow-600 hover:text-yellow-800 font-medium transition-colors">← Back</a>
                <% } else { %>
                <a href="review?action=list" class="text-yellow-600 hover:text-yellow-800 font-medium transition-colors">← Back</a>
                <% } %>
                <button type="submit" id="rf-submit-btn"
                        class="px-8 py-3 bg-gradient-to-r from-yellow-500 to-orange-500 text-white font-bold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                    Submit Review ⭐
                </button>
            </div>
        </form>
    </div>
</body>
</html>
