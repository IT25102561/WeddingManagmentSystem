package models;

/**
 * Abstract base class for all Vendors.
 * OOP Concept: Encapsulation (private fields), Inheritance (subclasses),
 *              Polymorphism (displayPackageDetails() overridden in each subclass)
 */
public abstract class Vendor {
    private String id;
    private String businessName;
    private String category;
    private String location;
    private double basePrice;
    private String status; // "Active", "Suspended"

    public Vendor(String id, String businessName, String category,
                  String location, double basePrice, String status) {
        this.id = id;
        this.businessName = businessName;
        this.category = category;
        this.location = location;
        this.basePrice = basePrice;
        this.status = status;
    }

    /**
     * Polymorphic method — each vendor subclass returns its own package description.
     */
    public abstract String displayPackageDetails();

    /**
     * Serialize vendor to file string.
     */
    public abstract String toFileString();

    // Getters and Setters - Encapsulation
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getBasePrice() { return basePrice; }
    public void setBasePrice(double basePrice) { this.basePrice = basePrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
