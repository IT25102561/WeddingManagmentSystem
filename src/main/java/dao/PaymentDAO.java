package dao;

import models.Payment;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * PaymentDAO - handles all file I/O for payments.txt
 * Format: paymentId|clientId|vendorId|vendorName|description|amount|paymentType|status|paymentDate
 */
public class PaymentDAO {
    private static final String FILE_PATH = System.getProperty("user.home") + "/weddingbliss_data/payments.txt";

    public PaymentDAO() {
        ensureFileExists(FILE_PATH);
    }

    private void ensureFileExists(String path) {
        File file = new File(path);
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); } catch (IOException e) { e.printStackTrace(); }
        }
    }

    public void addPayment(Payment payment) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(payment.toFileString());
            bw.newLine();
        } catch (IOException e) { e.printStackTrace(); }
    }

    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] d = line.split("\\|");
                if (d.length >= 9) {
                    payments.add(new Payment(d[0], d[1], d[2], d[3], d[4],
                            Double.parseDouble(d[5]), d[6], d[7], d[8]));
                }
            }
        } catch (IOException | NumberFormatException e) { e.printStackTrace(); }
        return payments;
    }

    public List<Payment> getPaymentsByClient(String clientId) {
        List<Payment> result = new ArrayList<>();
        for (Payment p : getAllPayments()) {
            if (p.getClientId().equals(clientId)) result.add(p);
        }
        return result;
    }

    public Payment getPaymentById(String paymentId) {
        for (Payment p : getAllPayments()) {
            if (p.getPaymentId().equals(paymentId)) return p;
        }
        return null;
    }

    public void updatePaymentStatus(String paymentId, String newStatus) {
        List<Payment> payments = getAllPayments();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Payment p : payments) {
                if (p.getPaymentId().equals(paymentId)) p.setStatus(newStatus);
                bw.write(p.toFileString());
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    public void deletePayment(String paymentId) {
        List<Payment> payments = getAllPayments();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Payment p : payments) {
                if (!p.getPaymentId().equals(paymentId)) { bw.write(p.toFileString()); bw.newLine(); }
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    public double getTotalPaidByClient(String clientId) {
        return getPaymentsByClient(clientId).stream()
                .filter(p -> p.getStatus().equals("Paid"))
                .mapToDouble(Payment::getAmount)
                .sum();
    }
}
