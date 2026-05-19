package dao;

import models.*;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ReviewDAO - handles all file I/O for reviews.txt
 * Format: reviewId|clientId|clientName|vendorId|vendorName|rating|comment|reviewDate|reviewType
 */
public class ReviewDAO {
    private static final String FILE_PATH = System.getProperty("user.home") + "/weddingbliss_data/reviews.txt";

    public ReviewDAO() {
        ensureFileExists(FILE_PATH);
    }

    private void ensureFileExists(String path) {
        File file = new File(path);
        file.getParentFile().mkdirs();
        if (!file.exists()) {
            try { file.createNewFile(); } catch (IOException e) { e.printStackTrace(); }
        }
    }

    public void addReview(Review review) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(review.toFileString());
            bw.newLine();
        } catch (IOException e) { e.printStackTrace(); }
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] d = line.split("\\|");
                if (d.length >= 9) {
                    String type = d[8];
                    Review r;
                    if ("Verified".equals(type)) {
                        r = new VerifiedReview(d[0], d[1], d[2], d[3], d[4], Integer.parseInt(d[5]), d[6], d[7]);
                    } else {
                        r = new GuestReview(d[0], d[1], d[2], d[3], d[4], Integer.parseInt(d[5]), d[6], d[7]);
                    }
                    reviews.add(r);
                }
            }
        } catch (IOException | NumberFormatException e) { e.printStackTrace(); }
        return reviews;
    }

    public List<Review> getReviewsByVendor(String vendorId) {
        List<Review> result = new ArrayList<>();
        for (Review r : getAllReviews()) {
            if (r.getVendorId().equals(vendorId)) result.add(r);
        }
        return result;
    }

    public List<Review> getReviewsByClient(String clientId) {
        List<Review> result = new ArrayList<>();
        for (Review r : getAllReviews()) {
            if (r.getClientId().equals(clientId)) result.add(r);
        }
        return result;
    }

    public double getAverageRatingForVendor(String vendorId) {
        List<Review> reviews = getReviewsByVendor(vendorId);
        if (reviews.isEmpty()) return 0;
        return reviews.stream().mapToInt(Review::getRating).average().orElse(0);
    }

    public void deleteReview(String reviewId) {
        List<Review> reviews = getAllReviews();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review r : reviews) {
                if (!r.getReviewId().equals(reviewId)) { bw.write(r.toFileString()); bw.newLine(); }
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    public void updateReview(String reviewId, String newComment, int newRating) {
        List<Review> reviews = getAllReviews();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review r : reviews) {
                if (r.getReviewId().equals(reviewId)) {
                    r.setComment(newComment);
                    r.setRating(newRating);
                }
                bw.write(r.toFileString());
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }
}
