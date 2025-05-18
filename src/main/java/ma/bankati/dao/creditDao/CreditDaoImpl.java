package ma.bankati.dao.creditDao;

import ma.bankati.config.SessionFactory;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CreditDaoImpl implements ICreditDao {

    @Override
    public Credit save(Credit credit) {
        String sql = "INSERT INTO credits (montant, duree_mois, status, date_demande, user_id) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setDouble(1, credit.getMontant());
            ps.setInt(2, credit.getDureeMois());
            ps.setString(3, credit.getStatus().name());
            ps.setDate(4, Date.valueOf(credit.getDateDemande()));
            ps.setLong(5, credit.getUserId());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating credit failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    credit.setId(generatedKeys.getLong(1));
                } else {
                    throw new SQLException("Creating credit failed, no ID obtained.");
                }
            }
            
            return credit;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Credit findById(Long id) {
        String sql = "SELECT * FROM credits WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToCredit(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<Credit> findAll() {
        String sql = "SELECT * FROM credits";
        List<Credit> credits = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                credits.add(mapRowToCredit(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return credits;
    }

    @Override
    public List<Credit> findByUserId(Long userId) {
        String sql = "SELECT * FROM credits WHERE user_id = ?";
        List<Credit> credits = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    credits.add(mapRowToCredit(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return credits;
    }

    @Override
    public List<Credit> findByStatus(ECredit status) {
        String sql = "SELECT * FROM credits WHERE status = ?";
        List<Credit> credits = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, status.name());
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    credits.add(mapRowToCredit(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return credits;
    }

    @Override
    public Credit update(Credit credit) {
        String sql = "UPDATE credits SET montant = ?, duree_mois = ?, status = ?, date_demande = ?, user_id = ? WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setDouble(1, credit.getMontant());
            ps.setInt(2, credit.getDureeMois());
            ps.setString(3, credit.getStatus().name());
            ps.setDate(4, Date.valueOf(credit.getDateDemande()));
            ps.setLong(5, credit.getUserId());
            ps.setLong(6, credit.getId());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                return credit;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public boolean deleteById(Long id) {
        String sql = "DELETE FROM credits WHERE id = ?";
        
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
    
    private Credit mapRowToCredit(ResultSet rs) throws SQLException {
        return Credit.builder()
                .id(rs.getLong("id"))
                .montant(rs.getDouble("montant"))
                .dureeMois(rs.getInt("duree_mois"))
                .status(ECredit.valueOf(rs.getString("status")))
                .dateDemande(rs.getDate("date_demande").toLocalDate())
                .userId(rs.getLong("user_id"))
                .build();
    }
} 