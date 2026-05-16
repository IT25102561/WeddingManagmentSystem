package models;

/**
 * VenueVendor — extends Vendor.
 * OOP Concept: Inheritance, Polymorphism (overrides displayPackageDetails).
 */
public class VenueVendor extends Vendor {
    private int maxCapacity;

    public VenueVendor(String id, String businessName, String location,
                       double basePrice, int maxCapacity) {
        super(id, businessName, "Venue", location, basePrice, "Active");
        this.maxCapacity = maxCapacity;
    }

    public VenueVendor(String id, String businessName, String location,
                       double basePrice, int maxCapacity, String status) {
        super(id, businessName, "Venue", location, basePrice, status);
        this.maxCapacity = maxCapacity;
    }

    @Override
    public String displayPackageDetails() {
        return "Venue Package: Includes hall rental and basic seating. Maximum Capacity: " + maxCapacity + " guests.";
    }

    @Override
    public String toFileString() {
        return getId() + "|" + getBusinessName() + "|" + getCategory() + "|" +
               getLocation() + "|" + getBasePrice() + "|" + maxCapacity + "|" + getStatus();
    }

    public int getMaxCapacity() { return maxCapacity; }
    public void setMaxCapacity(int maxCapacity) { this.maxCapacity = maxCapacity; }
}
