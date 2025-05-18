package ma.bankati.dao.creditDao;

import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;

import java.util.List;

/**
 * Data Access Object interface for Credit entity operations
 */
public interface ICreditDao {
    
    /**
     * Save a credit to the database
     * @param credit The credit to save
     * @return The saved credit with generated ID
     */
    Credit save(Credit credit);
    
    /**
     * Find a credit by its ID
     * @param id The credit ID
     * @return The credit if found, null otherwise
     */
    Credit findById(Long id);
    
    /**
     * Find all credits in the database
     * @return List of all credits
     */
    List<Credit> findAll();
    
    /**
     * Find credits by user ID
     * @param userId The user ID
     * @return List of credits for the specified user
     */
    List<Credit> findByUserId(Long userId);
    
    /**
     * Find credits by status
     * @param status The credit status
     * @return List of credits with the specified status
     */
    List<Credit> findByStatus(ECredit status);
    
    /**
     * Update an existing credit
     * @param credit The credit to update
     * @return The updated credit
     */
    Credit update(Credit credit);
    
    /**
     * Delete a credit by its ID
     * @param id The credit ID to delete
     * @return true if deleted successfully, false otherwise
     */
    boolean deleteById(Long id);
} 