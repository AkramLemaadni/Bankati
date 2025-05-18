package ma.bankati.dao.userDao;

import ma.bankati.config.SessionFactory;
import ma.bankati.model.users.User;
import ma.bankati.model.users.ERole;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDaoImpl implements IUserDao {

    @Override
    public User save(User user) {
        String sql = "INSERT INTO users (first_name, last_name, username, password, role, creation_date) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole().name());
            ps.setDate(6, Date.valueOf(user.getCreationDate()));
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getLong(1));
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
            
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public User findById(Long id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public Optional<User> findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.ofNullable(mapRowToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return Optional.empty();
    }

    @Override
    public List<User> findAll() {
        String sql = "SELECT * FROM users";
        List<User> users = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                users.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return users;
    }

    @Override
    public List<User> findByRole(ERole role) {
        String sql = "SELECT * FROM users WHERE role = ?";
        List<User> users = new ArrayList<>();
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, role.name());
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapRowToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return users;
    }

    @Override
    public User update(User user) {
        String sql = "UPDATE users SET first_name = ?, last_name = ?, username = ?, password = ?, role = ? WHERE id = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole().name());
            ps.setLong(6, user.getId());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public boolean deleteById(Long id) {
        String sql = "DELETE FROM users WHERE id = ?";
        
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
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public Optional<User> findByLoginAndPassword(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (Connection connection = SessionFactory.getInstance().openSession();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.ofNullable(mapRowToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return Optional.empty();
    }
    
    private User mapRowToUser(ResultSet rs) throws SQLException {
        return User.builder()
                .id(rs.getLong("id"))
                .firstName(rs.getString("first_name"))
                .lastName(rs.getString("last_name"))
                .username(rs.getString("username"))
                .password(rs.getString("password"))
                .role(ERole.valueOf(rs.getString("role")))
                .creationDate(rs.getDate("creation_date").toLocalDate())
                .build();
    }
} 