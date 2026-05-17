<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register as Vendor - WeddingBliss</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        @keyframes blob { 0%,100%{border-radius:60% 40% 30% 70%/60% 30% 70% 40%;}50%{border-radius:30% 60% 70% 40%/50% 60% 30% 60%;} }
        .blob { animation: blob 8s ease-in-out infinite; }
    </style>
    <script>
        function toggleExtraField() {
            const cat = document.getElementById('vr-category').value;
            const label = document.getElementById('extra-label');
            const input = document.getElementById('extra-data');
            const hints = {
                'Photography': ['Equipment Style (e.g., DSLR, Drone)', 'text', 'Enter photography equipment'],
                'Venue': ['Maximum Capacity (Guests)', 'number', 'Enter max guests'],
                'Catering': ['Cuisine Type (e.g., Sri Lankan & Western)', 'text', 'Enter cuisine type'],
                'Music': ['Equipment (e.g., Full sound system + lighting)', 'text', 'Enter equipment details'],
                'Decoration': ['Theme Color (e.g., Pastel & White)', 'text', 'Enter theme color']
            };
            if (hints[cat]) {
                label.innerText = hints[cat][0];
                input.type = hints[cat][1];
                input.placeholder = hints[cat][2];
            }
        }
    </script>
</head>
<body class="min-h-screen bg-gradient-to-br from-emerald-50 via-white to-indigo-50 flex items-center justify-center relative overflow-hidden py-10">
    <div class="absolute top-0 right-0 w-96 h-96 bg-indigo-200/30 blob"></div>
    <div class="absolute bottom-0 left-0 w-80 h-80 bg-emerald-200/30 blob" style="animation-delay:4s;"></div>

    <div class="w-full max-w-2xl mx-4 bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/50 p-10 relative z-10">
        <div class="text-center mb-8">
            <a href="index.jsp" class="inline-flex items-center gap-2 mb-4">
                <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-xl flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
                </div>
                <span class="text-xl font-bold text-gray-800">WeddingBliss</span>
            </a>
            <h1 class="text-3xl font-extrabold text-gray-900">Join as a Vendor 🏪</h1>
            <p class="text-gray-500 mt-2">Register your wedding business and connect with couples.</p>
        </div>

        <form action="vendor" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="register">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Business Name</label>
                    <input type="text" name="businessName" id="vr-businessname" required placeholder="e.g. Dream Captures Studio"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all bg-white/70">
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Location</label>
                    <input type="text" name="location" id="vr-location" required placeholder="e.g. Colombo, Sri Lanka"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all bg-white/70">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Vendor Category</label>
                    <select id="vr-category" name="category" onchange="toggleExtraField()"
                            class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all bg-white">
                        <option value="Photography">📸 Photography</option>
                        <option value="Venue">🏛️ Venue</option>
                        <option value="Catering">🍽️ Catering</option>
                        <option value="Music">🎵 Music & DJ</option>
                        <option value="Decoration">💐 Decoration</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1.5">Base Price (LKR)</label>
                    <input type="number" name="basePrice" id="vr-price" required placeholder="50000" min="0" step="100"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all bg-white/70">
                </div>
            </div>

            <div>
                <label id="extra-label" class="block text-sm font-semibold text-gray-700 mb-1.5">Equipment Style (e.g., DSLR, Drone)</label>
                <input type="text" id="extra-data" name="extraData" required placeholder="Enter photography equipment"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-400 outline-none transition-all bg-white/70">
            </div>

            <div class="flex items-center justify-between pt-2">
                <a href="vendor?action=list" class="text-indigo-600 hover:text-indigo-800 font-medium transition-colors">← Back to Directory</a>
                <button type="submit" id="vr-submit-btn"
                        class="px-8 py-3 bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-bold rounded-xl shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all">
                    Register Business
                </button>
            </div>
        </form>
    </div>
</body>
</html>
