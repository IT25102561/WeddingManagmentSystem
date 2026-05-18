package controllers;

import dao.ReviewDAO;
import dao.VendorDAO;
import models.Review;
import models.Vendor;
import models.VerifiedReview;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * ReviewServlet - handles all review-related HTTP requests.
 */
public class ReviewServlet extends HttpServlet {
    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final VendorDAO vendorDAO = new VendorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                String vendorId = req.getParameter("vendorId");
                List<Review> reviews;
                Vendor vendor = null;
                if (vendorId != null && !vendorId.isEmpty()) {
                    reviews = reviewDAO.getReviewsByVendor(vendorId);
                    vendor = vendorDAO.getVendorById(vendorId);
                } else {
                    reviews = reviewDAO.getAllReviews();
                }
                req.setAttribute("reviews", reviews);
                req.setAttribute("vendor", vendor);
                req.getRequestDispatcher("/review_display.jsp").forward(req, res);
                break;

            case "form":
                String vid = req.getParameter("vendorId");
                Vendor v = vendorDAO.getVendorById(vid);
                req.setAttribute("vendor", v);
                req.getRequestDispatcher("/review_form.jsp").forward(req, res);
                break;

            case "delete":
                reviewDAO.deleteReview(req.getParameter("reviewId"));
                res.sendRedirect("review?action=list");
                break;

            default:
                res.sendRedirect("review?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        String action = req.getParameter("action");

        if ("submit".equals(action)) {
            String clientId = getLoggedInClientId(req);
            if (clientId == null) clientId = "guest";

            String clientName = req.getParameter("clientName");
            String vendorId = req.getParameter("vendorId");
            String comment = req.getParameter("comment");
            int rating = 5;
            try { rating = Integer.parseInt(req.getParameter("rating")); } catch (NumberFormatException ignored) {}

            Vendor vendor = vendorDAO.getVendorById(vendorId);
            String vendorName = vendor != null ? vendor.getBusinessName() : "Unknown";

            Review review = new VerifiedReview(UUID.randomUUID().toString(),
                    clientId, clientName, vendorId, vendorName,
                    rating, comment, LocalDate.now().toString());
            reviewDAO.addReview(review);
            res.sendRedirect("review?action=list&vendorId=" + vendorId);

        } else if ("edit".equals(action)) {
            String reviewId = req.getParameter("reviewId");
            String comment = req.getParameter("comment");
            int rating = 5;
            try { rating = Integer.parseInt(req.getParameter("rating")); } catch (NumberFormatException ignored) {}
            reviewDAO.updateReview(reviewId, comment, rating);
            res.sendRedirect("review?action=list");
        }
    }

    private String getLoggedInClientId(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        return (String) session.getAttribute("loggedInClientId");
    }
}
