package modal;

/**
 * Represents a feedback entry in the system
 */
public class Feedback {
    private int feedbackId;
    private String subject;
    private String message;
    
    // Default constructor
    public Feedback() {}
    
    // Constructor with subject and message
    public Feedback(String subject, String message) {
        this.subject = subject;
        this.message = message;
    }
    
    // Constructor with all fields
    public Feedback(int feedbackId, String subject, String message) {
        this.feedbackId = feedbackId;
        this.subject = subject;
        this.message = message;
    }
    
    // Getters and Setters
    public int getFeedbackId() {
        return feedbackId;
    }
    
    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }
    
    public String getSubject() {
        return subject;
    }
    
    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    @Override
    public String toString() {
        return "Feedback [feedbackId=" + feedbackId + ", subject=" + subject + ", message=" + message + "]";
    }
} 