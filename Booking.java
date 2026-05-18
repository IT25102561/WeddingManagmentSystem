package models;

/**
 * Booking model.
 * OOP Concept: Encapsulation (all fields private with getters/setters).
 * Manages booking transactions between clients and vendors.
 */
public class Booking {
    private String bookingId;
    private String clientId;
    private String vendorId;
    private String vendorName;
    private String vendorCategory;
    private String eventDate;
    private String bookingDate;
    private String status;  // "Pending", "Confirmed", "Cancelled"
    private double amount;
    private String notes;

    public Booking(String bookingId, String clientId, String vendorId, String vendorName,
                   String vendorCategory, String eventDate, String bookingDate,
                   String status, double amount, String notes) {
        this.bookingId = bookingId;
        this.clientId = clientId;
        this.vendorId = vendorId;
        this.vendorName = vendorName;
        this.vendorCategory = vendorCategory;
        this.eventDate = eventDate;
        this.bookingDate = bookingDate;
        this.status = status;
        this.amount = amount;
        this.notes = notes;
    }

    public String toFileString() {
        return bookingId + "|" + clientId + "|" + vendorId + "|" + vendorName + "|" +
               vendorCategory + "|" + eventDate + "|" + bookingDate + "|" +
               status + "|" + amount + "|" + notes;
    }

    // Getters and Setters - Encapsulation
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }

    public String getVendorId() { return vendorId; }
    public void setVendorId(String vendorId) { this.vendorId = vendorId; }

    public String getVendorName() { return vendorName; }
    public void setVendorName(String vendorName) { this.vendorName = vendorName; }

    public String getVendorCategory() { return vendorCategory; }
    public void setVendorCategory(String vendorCategory) { this.vendorCategory = vendorCategory; }

    public String getEventDate() { return eventDate; }
    public void setEventDate(String eventDate) { this.eventDate = eventDate; }

    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}
