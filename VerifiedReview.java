package models;

/**
 * VerifiedReview — extends Review.
 * OOP Concept: Inheritance from Review base class.
 */
public class VerifiedReview extends Review {
    public VerifiedReview(String reviewId, String clientId, String clientName,
                          String vendorId, String vendorName, int rating,
                          String comment, String reviewDate) {
        super(reviewId, clientId, clientName, vendorId, vendorName,
              rating, comment, reviewDate, "Verified");
    }

    @Override
    public String getBadgeLabel() {
        return "✓ Verified Client";
    }
}
