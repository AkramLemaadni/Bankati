package ma.bankati.dao.dataDao;

import ma.bankati.model.data.MoneyData;
import ma.bankati.model.data.Devise;

import java.util.List;

/**
 * Data Access Object interface for monetary data operations
 */
public interface IDao {
    
    /**
     * Save money data to the database
     * @param moneyData The money data to save
     * @return The saved money data with generated ID
     */
    MoneyData save(MoneyData moneyData);
    
    /**
     * Find money data by ID
     * @param id The money data ID
     * @return The money data if found, null otherwise
     */
    MoneyData findById(Long id);
    
    /**
     * Find all money data in the database
     * @return List of all money data
     */
    List<MoneyData> findAll();
    
    /**
     * Find money data by currency
     * @param devise The currency
     * @return List of money data with the specified currency
     */
    List<MoneyData> findByDevise(Devise devise);
    
    /**
     * Update existing money data
     * @param moneyData The money data to update
     * @return The updated money data
     */
    MoneyData update(MoneyData moneyData);
    
    /**
     * Delete money data by ID
     * @param id The money data ID to delete
     * @return true if deleted successfully, false otherwise
     */
    boolean deleteById(Long id);
    
    /**
     * Calculate exchange rate between currencies
     * @param fromDevise Source currency
     * @param toDevise Target currency
     * @return The exchange rate
     */
    Double getExchangeRate(Devise fromDevise, Devise toDevise);

    /**
     * Fetch the current monetary data value
     * @return The current monetary value
     */
    Double fetchData();
} 