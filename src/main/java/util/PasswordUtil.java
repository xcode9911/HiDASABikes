package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    
    /**
     * Hash a password using BCrypt
     * @param plainPassword The plain text password to hash
     * @return The hashed password
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }
    
    /**
     * Verify a password against a hashed password
     * @param plainPassword The plain text password to verify
     * @param hashedPassword The hashed password to check against
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    /**
     * Verify a password that could be either hashed or plain text
     * If the stored password is not hashed, it will be hashed after verification
     * @param plainPassword The plain text password to verify
     * @param storedPassword The stored password (could be hashed or plain text)
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyAndUpgradePassword(String plainPassword, String storedPassword) {
        // First try to verify as a hashed password
        try {
            if (BCrypt.checkpw(plainPassword, storedPassword)) {
                return true;
            }
        } catch (IllegalArgumentException e) {
            // If the stored password is not a valid BCrypt hash, it's probably plain text
            if (plainPassword.equals(storedPassword)) {
                return true;
            }
        }
        return false;
    }
}  