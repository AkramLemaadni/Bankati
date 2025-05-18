package ma.bankati.util;

import ma.bankati.config.SessionFactory;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

public class DatabaseInitializer {

    public static void initializeDatabase() {
        try {
            // Load the SQL script
            InputStream inputStream = Thread.currentThread().getContextClassLoader()
                    .getResourceAsStream("db/schema.sql");
            
            if (inputStream == null) {
                System.err.println("Cannot find schema.sql file!");
                return;
            }
            
            String script = new BufferedReader(new InputStreamReader(inputStream))
                    .lines().collect(Collectors.joining("\n"));
            
            // Split script into individual statements
            String[] statements = script.split(";");
            
            // Execute each statement
            try (Connection connection = SessionFactory.getInstance().openSession();
                 Statement stmt = connection.createStatement()) {
                
                for (String statement : statements) {
                    String trimmedStatement = statement.trim();
                    if (!trimmedStatement.isEmpty()) {
                        try {
                            stmt.execute(trimmedStatement);
                        } catch (Exception e) {
                            System.err.println("Error executing statement: " + trimmedStatement);
                            System.err.println("Error message: " + e.getMessage());
                        }
                    }
                }
                
                System.out.println("Database schema initialized successfully");
            }
        } catch (Exception e) {
            System.err.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
} 