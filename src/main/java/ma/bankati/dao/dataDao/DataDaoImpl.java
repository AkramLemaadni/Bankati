package ma.bankati.dao.dataDao;

import ma.bankati.config.SessionFactory;
import ma.bankati.model.data.MoneyData;
import ma.bankati.model.data.Devise;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataDaoImpl implements IDao {
    
    // Exchange rates map (could be stored in database in a real application)
    private static final Map<String, Double> exchangeRates = new HashMap<>();
    
    static {
        // Base currency is MAD (Moroccan Dirham)
        exchangeRates.put("MAD_USD", 0.098); // 1 MAD = 0.098 USD
        exchangeRates.put("MAD_EUR", 0.091); // 1 MAD = 0.091 EUR
        exchangeRates.put("USD_MAD", 10.2);  // 1 USD = 10.2 MAD
        exchangeRates.put("USD_EUR", 0.93);  // 1 USD = 0.93 EUR
        exchangeRates.put("EUR_MAD", 11.0);  // 1 EUR = 11.0 MAD
        exchangeRates.put("EUR_USD", 1.08);  // 1 EUR = 1.08 USD
    }

    @Override
    public MoneyData save(MoneyData moneyData) {
        String sql = "INSERT INTO money_data (value, devise, creation_date) VALUES (?, ?, ?)";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setDouble(1, moneyData.getValue());
            ps.setString(2, moneyData.getDevise().name());
            ps.setDate(3, Date.valueOf(moneyData.getCreationDate()));
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating money data failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    moneyData.setId(generatedKeys.getLong(1));
                } else {
                    throw new SQLException("Creating money data failed, no ID obtained.");
                }
            }
            
            return moneyData;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public MoneyData findById(Long id) {
        String sql = "SELECT * FROM money_data WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToMoneyData(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<MoneyData> findAll() {
        String sql = "SELECT * FROM money_data";
        List<MoneyData> moneyDataList = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                moneyDataList.add(mapRowToMoneyData(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return moneyDataList;
    }

    @Override
    public List<MoneyData> findByDevise(Devise devise) {
        String sql = "SELECT * FROM money_data WHERE devise = ?";
        List<MoneyData> moneyDataList = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, devise.name());
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    moneyDataList.add(mapRowToMoneyData(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return moneyDataList;
    }

    @Override
    public MoneyData update(MoneyData moneyData) {
        String sql = "UPDATE money_data SET value = ?, devise = ? WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setDouble(1, moneyData.getValue());
            ps.setString(2, moneyData.getDevise().name());
            ps.setLong(3, moneyData.getId());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                return moneyData;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public boolean deleteById(Long id) {
        String sql = "DELETE FROM money_data WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            int affectedRows = ps.executeUpdate();
            
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Double getExchangeRate(Devise fromDevise, Devise toDevise) {
        if (fromDevise == toDevise) {
            return 1.0; // Same currency
        }
        
        String key = fromDevise.name() + "_" + toDevise.name();
        return exchangeRates.getOrDefault(key, 0.0);
    }

    @Override
    public Double fetchData() {
        String sql = "SELECT value FROM money_data WHERE devise = 'Dh' ORDER BY creation_date DESC LIMIT 1";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getDouble("value");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0; // Return default value if no data found
    }
    
    private MoneyData mapRowToMoneyData(ResultSet rs) throws SQLException {
        return MoneyData.builder()
                .id(rs.getLong("id"))
                .value(rs.getDouble("value"))
                .devise(Devise.valueOf(rs.getString("devise")))
                .creationDate(rs.getDate("creation_date").toLocalDate())
                .build();
    }
} 