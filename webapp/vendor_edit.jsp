<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Vendor, models.PhotographyVendor, models.VenueVendor, models.CateringVendor, models.MusicVendor, models.DecorationVendor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vendor - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Outfit', sans-serif; } </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-teal-50 via-white to-indigo-50 flex items-center justify-center py-10">
    <%
        Vendor vendor = (Vendor) request.getAttribute("vendor");
        if (vendor == null) { response.sendRedirect("vendor?action=list"); return; }

        String extraData = "", extraLabel = "Extra Info", extraType = "text";
        if (vendor instanceof PhotographyVendor) {
            extraData = ((PhotographyVendor) vendor).getEquipmentStyle();
            extraLabel = "Equipment Style (e.g., DSLR, Drone)";
        } else if (vendor instanceof VenueVendor) {
            extraData = String.valueOf(((VenueVendor) vendor).getMaxCapacity());
            extraLabel = "Maximum Capacity (Guests)";
            extraType = "number";
        } else if (vendor instanceof CateringVendor) {
            extraData = ((CateringVendor) vendor).getCuisineType();
            extraLabel = "Cuisine Type";
        } else if (vendor instanceof MusicVendor) {
            extraData = ((MusicVendor) vendor).getEquipment();
            extraLabel = "Equipment Details";
        } else if (vendor instanceof DecorationVendor) {
            extraData = ((DecorationVendor) vendor).getThemeColor();
            extraLabel = "Theme Color";
        }
    %>

    <div class="w-full max-w-2xl mx-4 bg-white/85 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10">
        <div class="text-center mb-8">
            <div class="inline-flex items-center gap-2 px-4 py-2 bg-teal-100 text-teal-700 rounded-full text-sm font-semibold mb-4">
                ✏️ Edit Profile
            </div>
            <h1 class="text-3xl font-extrabold text-gray-900">Update Business Details</h1>
            <p class="text-gray-500 mt-2">Edit your vendor profile information below</p>
        </div>

        <!-- Category Badge -->
        <div class="mb-6 p-4 bg-gradient-to-r from-indigo-50 to-purple-50 rounded-2xl border border-indigo-100 flex items-center justify-between">
            <span class="font-semibold text-indigo-700">Category: <%= vendor.getCategory() %></span>
            <span class="text-sm text-gray-500">ID: <%= vendor.getId().substring(0,8) %>...</span>
        </div>

        <form action="vendor" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= vendor.getId() %>">
            <input type="hidden" name="category" value="<%= vendor.getCategory() %>">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Business Name</label>
                    <input type="text" name="businessName" id="ve-businessname" value="<%= vendor.getBusinessName() %>" required
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-teal-400 outline-none transition-all">
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Location</label>
                    <input type="text" name="location" id="ve-location" value="<%= vendor.getLocation() %>" required
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-teal-400 outline-none transition-all">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Base Price (LKR)</label>
                    <input type="number" name="basePrice" id="ve-price" value="<%= vendor.getBasePrice() %>" required step="100" min="0"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-teal-400 outline-none transition-all">
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5"><%= extraLabel %></label>
                    <input type="<%= extraType %>" name="extraData" id="ve-extra" value="<%= extraData %>" required
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-teal-400 outline-none transition-all">
                </div>
            </div>

            <div class="flex items-center justify-between pt-2">
                <a href="vendor?action=list" class="text-teal-600 hover:text-teal-800 font-medium transition-colors">← Cancel</a>
                <button type="submit" id="ve-save-btn"
                        class="px-8 py-3 bg-gradient-to-r from-teal-500 to-emerald-500 text-white font-bold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                    Save Changes ✓
                </button>
            </div>
        </form>
    </div>
</body>
</html>
