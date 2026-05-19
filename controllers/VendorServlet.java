package controllers;

import dao.VendorDAO;
import models.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * VendorServlet - handles all vendor-related HTTP requests.
 */
public class VendorServlet extends HttpServlet {
    private final VendorDAO vendorDAO = new VendorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                String category = req.getParameter("category");
                List<Vendor> vendors;
                if (category != null && !category.isEmpty() && !category.equals("All")) {
                    vendors = vendorDAO.getVendorsByCategory(category);
                } else {
                    vendors = vendorDAO.getAllVendors();
                }
                req.setAttribute("vendors", vendors);
                req.setAttribute("selectedCategory", category != null ? category : "All");
                req.getRequestDispatcher("/vendor_directory.jsp").forward(req, res);
                break;

            case "register":
                req.getRequestDispatcher("/vendor_register.jsp").forward(req, res);
                break;

            case "edit":
                String editId = req.getParameter("id");
                Vendor vendor = vendorDAO.getVendorById(editId);
                req.setAttribute("vendor", vendor);
                req.getRequestDispatcher("/vendor_edit.jsp").forward(req, res);
                break;

            case "delete":
                String delId = req.getParameter("id");
                vendorDAO.deleteVendor(delId);
                res.sendRedirect("vendor?action=list");
                break;

            default:
                res.sendRedirect("vendor?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "register":
                handleRegister(req, res);
                break;
            case "update":
                handleUpdate(req, res);
                break;
            default:
                res.sendRedirect("vendor?action=list");
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        String name = req.getParameter("businessName");
        String category = req.getParameter("category");
        String location = req.getParameter("location");
        double price = 0;
        try { price = Double.parseDouble(req.getParameter("basePrice")); } catch (NumberFormatException ignored) {}
        String extraData = req.getParameter("extraData");
        String id = UUID.randomUUID().toString();

        Vendor vendor = createVendor(id, name, category, location, price, extraData);
        if (vendor != null) vendorDAO.addVendor(vendor);

        res.sendRedirect("vendor?action=list");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("businessName");
        String category = req.getParameter("category");
        String location = req.getParameter("location");
        double price = 0;
        try { price = Double.parseDouble(req.getParameter("basePrice")); } catch (NumberFormatException ignored) {}
        String extraData = req.getParameter("extraData");

        Vendor vendor = createVendor(id, name, category, location, price, extraData);
        if (vendor != null) vendorDAO.updateVendor(vendor);

        res.sendRedirect("vendor?action=list");
    }

    private Vendor createVendor(String id, String name, String category,
                                 String location, double price, String extraData) {
        switch (category) {
            case "Photography": return new PhotographyVendor(id, name, location, price, extraData);
            case "Venue":
                int cap = 100;
                try { cap = Integer.parseInt(extraData); } catch (NumberFormatException ignored) {}
                return new VenueVendor(id, name, location, price, cap);
            case "Catering": return new CateringVendor(id, name, location, price, extraData);
            case "Music": return new MusicVendor(id, name, location, price, extraData);
            case "Decoration": return new DecorationVendor(id, name, location, price, extraData);
            default: return null;
        }
    }
}
