package models;

/**
 * Base abstract class for all system users.
 * OOP Concept: Encapsulation (private fields with getters/setters),
 *              Inheritance (Client and Admin extend this class)
 */
public abstract class User {
    private String id;
    private String email;
    private String password;
    private String fullName;
    private String phone;

    public User(String id, String email, String password, String fullName, String phone) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.phone = phone;
    }

    // Abstract method for polymorphic role display
    public abstract String getRole();

    // Abstract method for file serialization
    public abstract String toFileString();

    // Getters and Setters - Encapsulation
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
