package controllers;

import dao.ClientDAO;
import models.Client;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

/**
 * ClientServlet - handles all client-related HTTP requests.
 * Routes via ?action= parameter.
 */
public class ClientServlet extends HttpServlet {
    private final ClientDAO clientDAO = new ClientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "login";

        switch (action) {
            case "register":
                req.getRequestDispatcher("/client_register.jsp").forward(req, res);
                break;
            case "login":
                req.getRequestDispatcher("/client_login.jsp").forward(req, res);
                break;
            case "dashboard":
                Client client = getLoggedInClient(req);
                if (client == null) { res.sendRedirect("client?action=login"); return; }
                req.setAttribute("client", client);
                req.getRequestDispatcher("/client_dashboard.jsp").forward(req, res);
                break;
            case "logout":
                req.getSession().invalidate();
                res.sendRedirect("index.jsp");
                break;
            default:
                res.sendRedirect("index.jsp");
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
            case "login":
                handleLogin(req, res);
                break;
            case "update":
                handleUpdate(req, res);
                break;
            case "delete":
                handleDelete(req, res);
                break;
            default:
                res.sendRedirect("index.jsp");
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String weddingDate = req.getParameter("weddingDate");
        String budgetStr = req.getParameter("budget");
        String weddingLocation = req.getParameter("weddingLocation");

        if (clientDAO.emailExists(email)) {
            req.setAttribute("error", "Email already registered. Please login.");
            req.getRequestDispatcher("/client_register.jsp").forward(req, res);
            return;
        }

        double budget = 0;
        try { budget = Double.parseDouble(budgetStr); } catch (NumberFormatException ignored) {}

        Client client = new Client(UUID.randomUUID().toString(), email, password, fullName,
                phone, weddingDate, budget, weddingLocation);
        clientDAO.addClient(client);

        req.getSession().setAttribute("loggedInClientId", client.getId());
        res.sendRedirect("client?action=dashboard");
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Client client = clientDAO.getClientByEmail(email);

        if (client != null && client.getPassword().equals(password)) {
            req.getSession().setAttribute("loggedInClientId", client.getId());
            res.sendRedirect("client?action=dashboard");
        } else {
            req.setAttribute("error", "Invalid email or password.");
            req.getRequestDispatcher("/client_login.jsp").forward(req, res);
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Client client = getLoggedInClient(req);
        if (client == null) { res.sendRedirect("client?action=login"); return; }

        client.setFullName(req.getParameter("fullName"));
        client.setPhone(req.getParameter("phone"));
        client.setWeddingDate(req.getParameter("weddingDate"));
        client.setWeddingLocation(req.getParameter("weddingLocation"));
        try { client.setBudget(Double.parseDouble(req.getParameter("budget"))); } catch (NumberFormatException ignored) {}

        clientDAO.updateClient(client);
        res.sendRedirect("client?action=dashboard");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        Client client = getLoggedInClient(req);
        if (client != null) {
            clientDAO.deleteClient(client.getId());
            req.getSession().invalidate();
        }
        res.sendRedirect("index.jsp");
    }

    private Client getLoggedInClient(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        String id = (String) session.getAttribute("loggedInClientId");
        if (id == null) return null;
        return clientDAO.getClientById(id);
    }
}
