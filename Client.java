package models;

/**
 * Client (Couple) model — inherits from User.
 * OOP Concept: Encapsulation, Inheritance from User class.
 * Stores wedding-specific details.
 */
public class Client extends User {
    private String weddingDate;
    private double budget;
    private String weddingLocation;

    public Client(String id, String email, String password, String fullName,
                  String phone, String weddingDate, double budget, String weddingLocation) {
        super(id, email, password, fullName, phone);
        this.weddingDate = weddingDate;
        this.budget = budget;
        this.weddingLocation = weddingLocation;
    }

    @Override
    public String getRole() {
        return "Client";
    }

    @Override
    public String toFileString() {
        // Format: id|email|password|fullName|phone|weddingDate|budget|weddingLocation
        return getId() + "|" + getEmail() + "|" + getPassword() + "|" +
               getFullName() + "|" + getPhone() + "|" +
               weddingDate + "|" + budget + "|" + weddingLocation;
    }

    // Getters and Setters - Encapsulation
    public String getWeddingDate() { return weddingDate; }
    public void setWeddingDate(String weddingDate) { this.weddingDate = weddingDate; }

    public double getBudget() { return budget; }
    public void setBudget(double budget) { this.budget = budget; }

    public String getWeddingLocation() { return weddingLocation; }
    public void setWeddingLocation(String weddingLocation) { this.weddingLocation = weddingLocation; }
}
