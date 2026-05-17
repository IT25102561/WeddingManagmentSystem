<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.Vendor, models.PhotographyVendor, models.VenueVendor, models.CateringVendor, models.MusicVendor, models.DecorationVendor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Browse our curated list of top wedding vendors - photographers, venues, catering and more.">
    <title>Vendor Directory - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; background: #f8fafc; }
        .glass-card { background: rgba(255,255,255,0.85); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.6); }
        .vendor-card { transition: all 0.3s cubic-bezier(0.4,0,0.2,1); }
        .vendor-card:hover { transform: translateY(-8px); box-shadow: 0 30px 60px rgba(0,0,0,0.12); }
        .filter-btn.active { background: linear-gradient(135deg, #6366f1, #a855f7); color: white; }
    </style>
</head>
<body class="min-h-screen">

    <!-- Navigation -->
    <nav class="bg-white/90 backdrop-blur-xl sticky top-0 z-50 border-b border-gray-100 shadow-sm">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="index.jsp" class="flex items-center gap-2">
                <div class="w-8 h-8 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="font-bold text-gray-800">WeddingBliss</span>
            </a>
            <div class="flex items-center gap-4">
                <a href="client?action=dashboard" class="text-gray-600 hover:text-indigo-600 text-sm font-medium transition-colors">My Dashboard</a>
                <a href="vendor?action=register" id="nav-add-vendor" class="px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white text-sm font-semibold rounded-lg hover:shadow-lg hover:-translate-y-0.5 transition-all">
                    + Add Vendor
                </a>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <div class="bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-500 py-16">
        <div class="max-w-7xl mx-auto px-6 text-center">
            <h1 class="text-5xl font-extrabold text-white mb-4">Find Your Perfect <br><span class="text-yellow-300">Wedding Vendors</span></h1>
            <p class="text-white/80 text-lg max-w-2xl mx-auto">Browse our curated selection of verified photographers, venues, caterers, and more.</p>
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-6 py-10">
        <!-- Category Filters -->
        <div class="flex flex-wrap gap-3 mb-10 justify-center" id="category-filters">
            <% String selected = (String) request.getAttribute("selectedCategory");
               if (selected == null) selected = "All";
               String[] categories = {"All", "Photography", "Venue", "Catering", "Music", "Decoration"};
               String[] catIcons = {"🌟", "📸", "🏛️", "🍽️", "🎵", "💐"};
               for (int i = 0; i < categories.length; i++) {
                   String isActive = categories[i].equals(selected) ? " active" : "";
            %>
            <a href="vendor?action=list&category=<%= categories[i] %>"
               id="filter-<%= categories[i].toLowerCase() %>"
               class="filter-btn<%= isActive %> px-5 py-2.5 rounded-full font-semibold text-sm border border-gray-200 bg-white text-gray-700 hover:border-indigo-300 transition-all shadow-sm">
               <%= catIcons[i] %> <%= categories[i] %>
            </a>
            <% } %>
        </div>

        <!-- Vendor Grid -->
        <% List<Vendor> vendors = (List<Vendor>) request.getAttribute("vendors"); %>
        <% if (vendors != null && !vendors.isEmpty()) { %>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <% for (Vendor vendor : vendors) {
                String imageUrl;
                switch(vendor.getCategory()) {
                    case "Photography": imageUrl = "https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=800&q=80"; break;
                    case "Venue": imageUrl = "https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=800&q=80"; break;
                    case "Catering": imageUrl = "https://images.unsplash.com/photo-1555244162-803834f70033?auto=format&fit=crop&w=800&q=80"; break;
                    case "Music": imageUrl = "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?auto=format&fit=crop&w=800&q=80"; break;
                    case "Decoration": imageUrl = "https://images.unsplash.com/photo-1469334031218-e382a71b716b?auto=format&fit=crop&w=800&q=80"; break;
                    default: imageUrl = "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80";
                }
                String statusColor = "Active".equals(vendor.getStatus()) ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700";
            %>
            <div class="glass-card vendor-card rounded-3xl overflow-hidden shadow-sm" id="vendor-card-<%= vendor.getId() %>">
                <div class="relative h-52 overflow-hidden">
                    <img src="<%= imageUrl %>" alt="<%= vendor.getCategory() %> - <%= vendor.getBusinessName() %>" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
                    <div class="absolute top-4 right-4 flex gap-2">
                        <span class="px-3 py-1 bg-white/90 backdrop-blur text-xs font-bold text-gray-800 rounded-full shadow-sm">
                            <%= vendor.getCategory() %>
                        </span>
                        <span class="px-3 py-1 <%= statusColor %> backdrop-blur text-xs font-bold rounded-full shadow-sm">
                            <%= vendor.getStatus() %>
                        </span>
                    </div>
                    <div class="absolute bottom-4 left-4">
                        <span class="text-2xl font-black text-white">LKR <%= String.format("%,.0f", vendor.getBasePrice()) %></span>
                    </div>
                </div>

                <div class="p-6">
                    <h3 class="text-xl font-bold text-gray-900 mb-1 truncate"><%= vendor.getBusinessName() %></h3>
                    <div class="flex items-center text-gray-500 text-sm mb-3">
                        <svg class="w-4 h-4 mr-1 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path></svg>
                        <%= vendor.getLocation() %>
                    </div>
                    <div class="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-xl p-3 mb-5 border border-indigo-100">
                        <p class="text-sm text-gray-600 italic">"<%= vendor.displayPackageDetails() %>"</p>
                    </div>

                    <div class="flex gap-2">
                        <a href="booking?action=form&vendorId=<%= vendor.getId() %>" id="book-btn-<%= vendor.getId() %>"
                           class="flex-1 text-center py-2.5 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold rounded-xl hover:shadow-lg transition-all text-sm">
                           Book Now
                        </a>
                        <a href="review?action=list&vendorId=<%= vendor.getId() %>" id="reviews-btn-<%= vendor.getId() %>"
                           class="flex-1 text-center py-2.5 bg-gray-100 text-gray-700 font-semibold rounded-xl hover:bg-gray-200 transition-colors text-sm">
                           Reviews
                        </a>
                        <a href="vendor?action=edit&id=<%= vendor.getId() %>" id="edit-btn-<%= vendor.getId() %>"
                           class="py-2.5 px-3 bg-amber-50 text-amber-700 font-semibold rounded-xl hover:bg-amber-100 transition-colors text-sm">
                           ✏️
                        </a>
                        <a href="vendor?action=delete&id=<%= vendor.getId() %>"
                           onclick="return confirm('Delete <%= vendor.getBusinessName() %>?');"
                           id="delete-btn-<%= vendor.getId() %>"
                           class="py-2.5 px-3 bg-red-50 text-red-600 font-semibold rounded-xl hover:bg-red-100 transition-colors text-sm">
                           🗑️
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="text-center py-24">
            <div class="text-8xl mb-4">🔍</div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">No Vendors Found</h3>
            <p class="text-gray-500 mb-8">Be the first to join the WeddingBliss platform!</p>
            <a href="vendor?action=register" class="inline-block px-8 py-3 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">Add First Vendor</a>
        </div>
        <% } %>
    </div>
</body>
</html>
