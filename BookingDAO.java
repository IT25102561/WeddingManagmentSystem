package dao;

import models.Booking;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * BookingDAO - handles all file I/O for bookings.txt
 * Format: bookingId|clientId|vendorId|vendorName|vendorCategory|eventDate|bookingDate|status|amount|notes
 */
public class BookingDAO {
    private static final String FILE_PATH = System.getProperty("user.home") + "/weddingbliss_data/bookings.txt";

    public BookingDAO() {
        ensureFileExists(FILE_PATH);
    }

    private void ensureFileExists(String path) {
        File file = new File(path);
        file.getParentFile().mkdirs()
        if (!file.exists()) {
            try { file.createNewFile(); } catch (IOException e) { e.printStackTrace(); }
        }
    }

    public void addBooking(Booking booking) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(booking.toFileString());
            bw.newLine();
        } catch (IOException e) { e.printStackTrace(); }
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] d = line.split("\\|");
                if (d.length >= 10) {
                    bookings.add(new Booking(d[0], d[1], d[2], d[3], d[4], d[5],
                            d[6], d[7], Double.parseDouble(d[8]), d[9]));
                }
            }
        } catch (IOException | NumberFormatException e) { e.printStackTrace(); }
        return bookings;
    }

    public List<Booking> getBookingsByClient(String clientId) {
        List<Booking> result = new ArrayList<>();
        for (Booking b : getAllBookings()) {
            if (b.getClientId().equals(clientId)) result.add(b);
        }
        return result;
    }

    public List<Booking> getBookingsByVendor(String vendorId) {
        List<Booking> result = new ArrayList<>();
        for (Booking b : getAllBookings()) {
            if (b.getVendorId().equals(vendorId)) result.add(b);
        }
        return result;
    }

    public Booking getBookingById(String bookingId) {
        for (Booking b : getAllBookings()) {
            if (b.getBookingId().equals(bookingId)) return b;
        }
        return null;
    }

    public void updateBookingStatus(String bookingId, String newStatus) {
        List<Booking> bookings = getAllBookings();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Booking b : bookings) {
                if (b.getBookingId().equals(bookingId)) b.setStatus(newStatus);
                bw.write(b.toFileString());
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    public void deleteBooking(String bookingId) {
        List<Booking> bookings = getAllBookings();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Booking b : bookings) {
                if (!b.getBookingId().equals(bookingId)) { bw.write(b.toFileString()); bw.newLine(); }
            }
        } catch (IOException e) { e.printStackTrace(); }
    }
}
