<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.Review, models.Vendor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - WeddingBliss</title>
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
            <a href="vendor?action=list" class="text-gray-600 hover:text-indigo-600 text-sm font-medium">← Vendor Directory</a>
        </div>
    </nav>

    <div class="max-w-6xl mx-auto px-6 py-10">
        <% Vendor vendor = (Vendor) request.getAttribute("vendor");
           List<Review> reviews = (List<Review>) request.getAttribute("reviews");
        %>

        <div class="flex items-center justify-between mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-gray-900">
                    <%= vendor != null ? vendor.getBusinessName() + " — Reviews" : "All Reviews" %> ⭐
                </h1>
                <p class="text-gray-500 mt-1">
                    <%= reviews != null ? reviews.size() : 0 %> review(s)
                </p>
            </div>
            <% if (vendor != null) { %>
            <a href="review?action=form&vendorId=<%= vendor.getId() %>" id="write-review-btn"
               class="px-5 py-2.5 bg-gradient-to-r from-yellow-500 to-orange-500 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all text-sm">
                ✏️ Write a Review
            </a>
            <% } %>
        </div>

        <% if (reviews != null && !reviews.isEmpty()) { %>
        <div class="grid gap-4">
            <% for (Review r : reviews) { %>
            <div class="bg-white rounded-2xl border border-gray-100 shadow-sm p-6" id="review-card-<%= r.getReviewId() %>">
                <div class="flex items-start justify-between mb-3">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-full flex items-center justify-center text-white font-bold text-sm">
                            <%= r.getClientName().substring(0, 1).toUpperCase() %>
                        </div>
                        <div>
                            <div class="font-semibold text-gray-900"><%= r.getClientName() %></div>
                            <div class="text-xs text-gray-400"><%= r.getReviewDate() %></div>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="px-2 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">
                            <%= r.getBadgeLabel() %>
                        </span>
                        <!-- Stars -->
                        <div class="flex gap-0.5">
                            <% for (int i = 1; i <= 5; i++) { %>
                            <span class="text-<%= i <= r.getRating() ? "yellow-400" : "gray-200" %> text-lg">★</span>
                            <% } %>
                        </div>
                        <!-- Admin delete -->
                        <a href="review?action=delete&reviewId=<%= r.getReviewId() %>"
                           onclick="return confirm('Delete this review?');"
                           id="del-review-<%= r.getReviewId() %>"
                           class="text-red-400 hover:text-red-600 text-sm transition-colors">✕</a>
                    </div>
                </div>
                <p class="text-gray-600 leading-relaxed"><%= r.getComment() %></p>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="text-center py-24 bg-white rounded-3xl border border-gray-100 shadow-sm">
            <div class="text-8xl mb-4">⭐</div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">No Reviews Yet</h3>
            <p class="text-gray-500 mb-8">Be the first to share your experience!</p>
            <% if (vendor != null) { %>
            <a href="review?action=form&vendorId=<%= vendor.getId() %>"
               class="inline-block px-8 py-3 bg-gradient-to-r from-yellow-500 to-orange-500 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">
                Write First Review
            </a>
            <% } %>
        </div>
        <% } %>
    </div>
</body>
</html>
