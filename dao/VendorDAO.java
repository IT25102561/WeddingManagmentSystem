package dao;

import models.*;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * VendorDAO - handles all file I/O for vendors.txt
 * Format: id|businessName|category|location|basePrice|extraData|status
 */
public class VendorDAO {
    private static final String FILE_PATH = System.getProperty("user.home") + "/weddingbliss_data/vendors.txt";

    public VendorDAO() {
        ensureFileExists(FILE_PATH);
        seedSampleData();
    }

    private void ensureFileExists(String path) {
        File file = new File(path);
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); } catch (IOException e) { e.printStackTrace(); }
        }
    }

    private void seedSampleData() {
        if (getAllVendors().isEmpty()) {
            addVendor(new PhotographyVendor(UUID.randomUUID().toString(), "Everlasting Clicks", "Colombo", 1200.00, "DSLR + Drone"));
            addVendor(new VenueVendor(UUID.randomUUID().toString(), "Grand Crystal Hall", "Kandy", 5000.00, 500));
            addVendor(new CateringVendor(UUID.randomUUID().toString(), "Royal Feasts", "Galle", 850.00, "Authentic Sri Lankan & Western"));
            addVendor(new MusicVendor(UUID.randomUUID().toString(), "Vibe Masters DJ", "Negombo", 400.00, "Full sound system + lighting"));
            addVendor(new DecorationVendor(UUID.randomUUID().toString(), "Floral Dreams", "Colombo", 750.00, "Pastel & White"));
            addVendor(new PhotographyVendor(UUID.randomUUID().toString(), "Lens & Love Studio", "Colombo", 1500.00, "Mirrorless + Drone"));
            addVendor(new VenueVendor(UUID.randomUUID().toString(), "Sapphire Garden Resort", "Gampaha", 7500.00, 800));
        }
    }

    public void addVendor(Vendor vendor) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(vendor.toFileString());
            bw.newLine();
        } catch (IOException e) { e.printStackTrace(); }
    }

    public List<Vendor> getAllVendors() {
        List<Vendor> vendors = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] d = line.split("\\|");
                if (d.length >= 7) {
                    String id = d[0], name = d[1], cat = d[2], loc = d[3];
                    double price = Double.parseDouble(d[4]);
                    String extra = d[5], status = d[6];
                    switch (cat) {
                        case "Photography": vendors.add(new PhotographyVendor(id, name, loc, price, extra, status)); break;
                        case "Venue": vendors.add(new VenueVendor(id, name, loc, price, Integer.parseInt(extra), status)); break;
                        case "Catering": vendors.add(new CateringVendor(id, name, loc, price, extra, status)); break;
                        case "Music": vendors.add(new MusicVendor(id, name, loc, price, extra, status)); break;
                        case "Decoration": vendors.add(new DecorationVendor(id, name, loc, price, extra, status)); break;
                    }
                }
            }
        } catch (IOException | NumberFormatException e) { e.printStackTrace(); }
        return vendors;
    }

    public List<Vendor> getVendorsByCategory(String category) {
        List<Vendor> result = new ArrayList<>();
        for (Vendor v : getAllVendors()) {
            if (v.getCategory().equalsIgnoreCase(category)) result.add(v);
        }
        return result;
    }

    public Vendor getVendorById(String id) {
        for (Vendor v : getAllVendors()) {
            if (v.getId().equals(id)) return v;
        }
        return null;
    }

    public void updateVendor(Vendor updated) {
        List<Vendor> vendors = getAllVendors();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Vendor v : vendors) {
                bw.write(v.getId().equals(updated.getId()) ? updated.toFileString() : v.toFileString());
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    public void deleteVendor(String id) {
        List<Vendor> vendors = getAllVendors();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Vendor v : vendors) {
                if (!v.getId().equals(id)) { bw.write(v.toFileString()); bw.newLine(); }
            }
        } catch (IOException e) { e.printStackTrace(); }
    }
}
