package models;

/**
 * MusicVendor — extends Vendor.
 * OOP Concept: Inheritance, Polymorphism (overrides displayPackageDetails).
 */
public class MusicVendor extends Vendor {
    private String equipment; // e.g., "Full sound system + lighting"

    public MusicVendor(String id, String businessName, String location,
                       double basePrice, String equipment) {
        super(id, businessName, "Music", location, basePrice, "Active");
        this.equipment = equipment;
    }

    public MusicVendor(String id, String businessName, String location,
                       double basePrice, String equipment, String status) {
        super(id, businessName, "Music", location, basePrice, status);
        this.equipment = equipment;
    }

    @Override
    public String displayPackageDetails() {
        return "Music Package: 5 hours non-stop mix. Equipment: " + equipment + ".";
    }

    @Override
    public String toFileString() {
        return getId() + "|" + getBusinessName() + "|" + getCategory() + "|" +
               getLocation() + "|" + getBasePrice() + "|" + equipment + "|" + getStatus();
    }

    public String getEquipment() { return equipment; }
    public void setEquipment(String equipment) { this.equipment = equipment; }
}
