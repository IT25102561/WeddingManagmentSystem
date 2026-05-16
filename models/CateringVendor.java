package models;

/**
 * CateringVendor — extends Vendor.
 * OOP Concept: Inheritance, Polymorphism (overrides displayPackageDetails).
 */
public class CateringVendor extends Vendor {
    private String cuisineType; // e.g., "Authentic Sri Lankan & Western"

    public CateringVendor(String id, String businessName, String location,
                          double basePrice, String cuisineType) {
        super(id, businessName, "Catering", location, basePrice, "Active");
        this.cuisineType = cuisineType;
    }

    public CateringVendor(String id, String businessName, String location,
                          double basePrice, String cuisineType, String status) {
        super(id, businessName, "Catering", location, basePrice, status);
        this.cuisineType = cuisineType;
    }

    @Override
    public String displayPackageDetails() {
        return "Catering Package: Includes 3-course meal. Cuisine Type: " + cuisineType + ".";
    }

    @Override
    public String toFileString() {
        return getId() + "|" + getBusinessName() + "|" + getCategory() + "|" +
               getLocation() + "|" + getBasePrice() + "|" + cuisineType + "|" + getStatus();
    }

    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
}
