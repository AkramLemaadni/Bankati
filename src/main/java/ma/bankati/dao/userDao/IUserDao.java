package ma.bankati.dao.userDao;

import ma.bankati.model.users.User;
import ma.bankati.model.users.ERole;

import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for User entity operations
 */
public interface IUserDao {
    
    /**
     * Save a user to the database
     * @param user The user to save
     * @return The saved user with generated ID
     */
    User save(User user);
    
    /**
     * Find a user by their ID
     * @param id The user ID
     * @return The user if found, null otherwise
     */
    User findById(Long id);
    
    /**
     * Find a user by their username
     * @param username The username
     * @return Optional containing the user if found
     */
    Optional<User> findByUsername(String username);
    
    /**
     * Find all users in the database
     * @return List of all users
     */
    List<User> findAll();
    
    /**
     * Find users by role
     * @param role The user role
     * @return List of users with the specified role
     */
    List<User> findByRole(ERole role);
    
    /**
     * Update an existing user
     * @param user The user to update
     * @return The updated user
     */
    User update(User user);
    
    /**
     * Delete a user by their ID
     * @param id The user ID to delete
     * @return true if deleted successfully, false otherwise
     */
    boolean deleteById(Long id);
    
    /**
     * Check if a username already exists
     * @param username The username to check
     * @return true if the username exists, false otherwise
     */
    boolean existsByUsername(String username);
    
    /**
     * Find a user by username and password for authentication
     * @param username The username
     * @param password The password
     * @return Optional containing the user if found with matching credentials
     */
    Optional<User> findByLoginAndPassword(String username, String password);
} 