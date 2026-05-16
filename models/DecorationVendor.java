package models;

/**
 * DecorationVendor — extends Vendor.
 * OOP Concept: Inheritance, Polymorphism (overrides displayPackageDetails).
 */
public class DecorationVendor extends Vendor {
    private String themeColor; // e.g., "Pastel & White"

    public DecorationVendor(String id, String businessName, String location,
                            double basePrice, String themeColor) {
        super(id, businessName, "Decoration", location, basePrice, "Active");
        this.themeColor = themeColor;
    }

    public DecorationVendor(String id, String businessName, String location,
                            double basePrice, String themeColor, String status) {
        super(id, businessName, "Decoration", location, basePrice, status);
        this.themeColor = themeColor;
    }

    @Override
    public String displayPackageDetails() {
        return "Decoration Package: Hall decor and table centers. Theme Color: " + themeColor + ".";
    }

    @Override
    public String toFileString() {
        return getId() + "|" + getBusinessName() + "|" + getCategory() + "|" +
               getLocation() + "|" + getBasePrice() + "|" + themeColor + "|" + getStatus();
    }

    public String getThemeColor() { return themeColor; }
    public void setThemeColor(String themeColor) { this.themeColor = themeColor; }
}
