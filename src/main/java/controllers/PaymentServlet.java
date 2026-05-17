package controllers;

import dao.PaymentDAO;
import dao.VendorDAO;
import models.Payment;
import models.Vendor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * PaymentServlet - handles all payment/budget-related HTTP requests.
 */
public class PaymentServlet extends HttpServlet {
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final VendorDAO vendorDAO = new VendorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "dashboard";

        String clientId = getLoggedInClientId(req);
        if (clientId == null) { res.sendRedirect("client?action=login"); return; }

        switch (action) {
            case "dashboard":
                List<Payment> payments = paymentDAO.getPaymentsByClient(clientId);
                double totalPaid = paymentDAO.getTotalPaidByClient(clientId);
                double totalUnpaid = payments.stream()
                        .filter(p -> !p.getStatus().equals("Paid"))
                        .mapToDouble(Payment::getAmount).sum();
                req.setAttribute("payments", payments);
                req.setAttribute("totalPaid", totalPaid);
                req.setAttribute("totalUnpaid", totalUnpaid);
                req.getRequestDispatcher("/budget_dashboard.jsp").forward(req, res);
                break;

            case "add":
                List<Vendor> vendors = vendorDAO.getAllVendors();
                req.setAttribute("vendors", vendors);
                req.getRequestDispatcher("/payment_form.jsp").forward(req, res);
                break;

            case "markPaid":
                paymentDAO.updatePaymentStatus(req.getParameter("paymentId"), "Paid");
                res.sendRedirect("payment?action=dashboard");
                break;

            case "delete":
                paymentDAO.deletePayment(req.getParameter("paymentId"));
                res.sendRedirect("payment?action=dashboard");
                break;

            default:
                res.sendRedirect("payment?action=dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        String action = req.getParameter("action");
        String clientId = getLoggedInClientId(req);
        if (clientId == null) { res.sendRedirect("client?action=login"); return; }

        if ("add".equals(action)) {
            String vendorId = req.getParameter("vendorId");
            String description = req.getParameter("description");
            double amount = 0;
            try { amount = Double.parseDouble(req.getParameter("amount")); } catch (NumberFormatException ignored) {}
            String paymentType = req.getParameter("paymentType");

            Vendor vendor = vendorDAO.getVendorById(vendorId);
            String vendorName = vendor != null ? vendor.getBusinessName() : "General Expense";

            Payment payment = new Payment(UUID.randomUUID().toString(), clientId, vendorId,
                    vendorName, description, amount, paymentType, "Unpaid",
                    LocalDate.now().toString());
            paymentDAO.addPayment(payment);
        }
        res.sendRedirect("payment?action=dashboard");
    }

    private String getLoggedInClientId(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        return (String) session.getAttribute("loggedInClientId");
    }
}
