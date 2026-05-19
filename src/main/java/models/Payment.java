package models;

/**
 * Payment model.
 * OOP Concept: Encapsulation (private fields with getters/setters),
 *              Polymorphism (fee calculation varies by payment type).
 */
public class Payment {
    private String paymentId;
    private String clientId;
    private String vendorId;
    private String vendorName;
    private String description;
    private double amount;
    private String paymentType;  // "Credit Card", "Bank Transfer", "Cash"
    private String status;       // "Paid", "Unpaid", "Pending"
    private String paymentDate;

    public Payment(String paymentId, String clientId, String vendorId, String vendorName,
                   String description, double amount, String paymentType,
                   String status, String paymentDate) {
        this.paymentId = paymentId;
        this.clientId = clientId;
        this.vendorId = vendorId;
        this.vendorName = vendorName;
        this.description = description;
        this.amount = amount;
        this.paymentType = paymentType;
        this.status = status;
        this.paymentDate = paymentDate;
    }

    /**
     * Polymorphic fee calculation based on payment type.
     */
    public double calculateFee() {
        switch (paymentType) {
            case "Credit Card": return amount * 0.025; // 2.5% fee
            case "Bank Transfer": return amount * 0.01; // 1% fee
            default: return 0.0; // Cash - no fee
        }
    }

    public double getTotalWithFee() {
        return amount + calculateFee();
    }

    public String toFileString() {
        return paymentId + "|" + clientId + "|" + vendorId + "|" + vendorName + "|" +
                description + "|" + amount + "|" + paymentType + "|" + status + "|" + paymentDate;
    }

    // Getters and Setters - Encapsulation
    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }

    public String getVendorId() { return vendorId; }
    public void setVendorId(String vendorId) { this.vendorId = vendorId; }

    public String getVendorName() { return vendorName; }
    public void setVendorName(String vendorName) { this.vendorName = vendorName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentType() { return paymentType; }
    public void setPaymentType(String paymentType) { this.paymentType = paymentType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }
}
