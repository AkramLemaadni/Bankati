package ma.bankati.config;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class SessionFactory {

    private static SessionFactory instance = new SessionFactory();
    private String url;
    private String username;
    private String password;
    private String driverName;

    private SessionFactory(){
        try {
            // Load properties from beans.properties
            Properties properties = new Properties();
            InputStream configFile = Thread.currentThread().getContextClassLoader()
                .getResourceAsStream("configFiles/beans.properties");
            
            if (configFile == null) {
                throw new RuntimeException("Unable to find beans.properties");
            }
            
            properties.load(configFile);
            
            // Get database connection parameters from properties
            this.driverName = properties.getProperty("datasource.driver");
            this.url = properties.getProperty("datasource.url");
            this.username = properties.getProperty("datasource.username");
            this.password = properties.getProperty("datasource.password");
            
            // Load driver
            Class.forName(driverName);
            System.out.println("DB Driver successfully loaded");
            
            // Test connection
            try (Connection testConnection = DriverManager.getConnection(url, username, password)) {
                System.out.println("Database connection successfully established");
            }
        }
        catch (SQLException e) {
            System.err.println("Connection Failed: " + e.getMessage());
            throw new RuntimeException("Database connection failed", e);
        }
        catch (ClassNotFoundException e) {
            System.err.println("DB Driver could not be loaded: " + e.getMessage());
            throw new RuntimeException("Database driver not found", e);
        }
        catch (IOException e) {
            System.err.println("Properties file could not be loaded: " + e.getMessage());
            throw new RuntimeException("Failed to load properties file", e);
        }
    }

    public static SessionFactory getInstance(){
        return instance;
    }
    
    public Connection openSession() {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            System.err.println("Failed to open new connection: " + e.getMessage());
            throw new RuntimeException("Failed to open database connection", e);
        }
    }

    public static void main(String[] args) {
        SessionFactory.getInstance();
    }
}


