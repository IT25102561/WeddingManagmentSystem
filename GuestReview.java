package models;

/**
 * GuestReview — extends Review.
 * OOP Concept: Inheritance from Review base class.
 */
public class GuestReview extends Review {
    public GuestReview(String reviewId, String clientId, String clientName,
                       String vendorId, String vendorName, int rating,
                       String comment, String reviewDate) {
        super(reviewId, clientId, clientName, vendorId, vendorName,
              rating, comment, reviewDate, "Guest");
    }

    @Override
    public String getBadgeLabel() {
        return "Guest Review";
    }
}
