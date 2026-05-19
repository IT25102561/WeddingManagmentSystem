package models;

/**
 * Review model — base class for reviews.
 * OOP Concept: Encapsulation (private fields),
 *              Inheritance (VerifiedReview and GuestReview extend this).
 */
public abstract class Review {
    private String reviewId;
    private String clientId;
    private String clientName;
    private String vendorId;
    private String vendorName;
    private int rating;          // 1-5 stars
    private String comment;
    private String reviewDate;
    private String reviewType;   // "Verified" or "Guest"

    public Review(String reviewId, String clientId, String clientName,
                  String vendorId, String vendorName, int rating,
                  String comment, String reviewDate, String reviewType) {
        this.reviewId = reviewId;
        this.clientId = clientId;
        this.clientName = clientName;
        this.vendorId = vendorId;
        this.vendorName = vendorName;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.reviewType = reviewType;
    }

    public abstract String getBadgeLabel();

    public String toFileString() {
        return reviewId + "|" + clientId + "|" + clientName + "|" +
               vendorId + "|" + vendorName + "|" + rating + "|" +
               comment + "|" + reviewDate + "|" + reviewType;
    }

    // Getters and Setters - Encapsulation
    public String getReviewId() { return reviewId; }
    public void setReviewId(String reviewId) { this.reviewId = reviewId; }

    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }

    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }

    public String getVendorId() { return vendorId; }
    public void setVendorId(String vendorId) { this.vendorId = vendorId; }

    public String getVendorName() { return vendorName; }
    public void setVendorName(String vendorName) { this.vendorName = vendorName; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getReviewDate() { return reviewDate; }
    public void setReviewDate(String reviewDate) { this.reviewDate = reviewDate; }

    public String getReviewType() { return reviewType; }
    public void setReviewType(String reviewType) { this.reviewType = reviewType; }
}
