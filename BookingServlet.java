package controllers;

import dao.BookingDAO;
import dao.VendorDAO;
import models.Booking;
import models.Vendor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * BookingServlet - handles all booking-related HTTP requests.
 */
public class BookingServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final VendorDAO vendorDAO = new VendorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "history";

        String clientId = getLoggedInClientId(req);

        switch (action) {
            case "form":
                String vendorId = req.getParameter("vendorId");
                Vendor vendor = vendorDAO.getVendorById(vendorId);
                req.setAttribute("vendor", vendor);
                req.getRequestDispatcher("/booking_form.jsp").forward(req, res);
                break;

            case "history":
                if (clientId == null) { res.sendRedirect("client?action=login"); return; }
                List<Booking> myBookings = bookingDAO.getBookingsByClient(clientId);
                req.setAttribute("bookings", myBookings);
                req.getRequestDispatcher("/booking_history.jsp").forward(req, res);
                break;

            case "manage":
                // Admin view - all bookings
                List<Booking> allBookings = bookingDAO.getAllBookings();
                req.setAttribute("bookings", allBookings);
                req.getRequestDispatcher("/booking_manage.jsp").forward(req, res);
                break;

            case "cancel":
                bookingDAO.deleteBooking(req.getParameter("bookingId"));
                res.sendRedirect("booking?action=history");
                break;

            case "confirm":
                bookingDAO.updateBookingStatus(req.getParameter("bookingId"), "Confirmed");
                res.sendRedirect("booking?action=manage");
                break;

            default:
                res.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        String action = req.getParameter("action");
        if ("create".equals(action)) {
            String clientId = getLoggedInClientId(req);
            if (clientId == null) { res.sendRedirect("client?action=login"); return; }

            String vendorId = req.getParameter("vendorId");
            String eventDate = req.getParameter("eventDate");
            String notes = req.getParameter("notes");
            double amount = 0;
            try { amount = Double.parseDouble(req.getParameter("amount")); } catch (NumberFormatException ignored) {}

            Vendor vendor = vendorDAO.getVendorById(vendorId);
            String vendorName = vendor != null ? vendor.getBusinessName() : "Unknown";
            String vendorCategory = vendor != null ? vendor.getCategory() : "Unknown";

            Booking booking = new Booking(
                    UUID.randomUUID().toString(), clientId, vendorId,
                    vendorName, vendorCategory, eventDate,
                    LocalDate.now().toString(), "Pending", amount, notes
            );
            bookingDAO.addBooking(booking);
            res.sendRedirect("booking?action=history");
        } else {
            res.sendRedirect("booking?action=history");
        }
    }

    private String getLoggedInClientId(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        return (String) session.getAttribute("loggedInClientId");
    }
}
