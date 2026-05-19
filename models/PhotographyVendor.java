package models;

/**
 * PhotographyVendor — extends Vendor.
 * OOP Concept: Inheritance, Polymorphism (overrides displayPackageDetails).
 */
public class PhotographyVendor extends Vendor {
    private String equipmentStyle; // e.g., "DSLR + Drone"

    public PhotographyVendor(String id, String businessName, String location,
                              double basePrice, String equipmentStyle) {
        super(id, businessName, "Photography", location, basePrice, "Active");
        this.equipmentStyle = equipmentStyle;
    }

    public PhotographyVendor(String id, String businessName, String location,
                              double basePrice, String equipmentStyle, String status) {
        super(id, businessName, "Photography", location, basePrice, status);
        this.equipmentStyle = equipmentStyle;
    }

    @Override
    public String displayPackageDetails() {
        return "Photography Package: Includes full day coverage. Style/Equipment: " + equipmentStyle + ".";
    }

    @Override
    public String toFileString() {
        return getId() + "|" + getBusinessName() + "|" + getCategory() + "|" +
               getLocation() + "|" + getBasePrice() + "|" + equipmentStyle + "|" + getStatus();
    }

    public String getEquipmentStyle() { return equipmentStyle; }
    public void setEquipmentStyle(String equipmentStyle) { this.equipmentStyle = equipmentStyle; }
}
