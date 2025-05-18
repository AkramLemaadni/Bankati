package ma.jstl.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Singleton
public class SessionFactory {

    private static SessionFactory instance = new SessionFactory();
    private Connection session;

    private SessionFactory(){

        try {
            var driverName = "com.mysql.cj.jdbc.Driver";
            Class.forName(driverName);
            System.out.println("DB Driver successfully loaded");
            var url         = "jdbc:mysql://localhost:3306/myBankatiDB";
            var username    = "root";
            var password    = "rootroot";
            session = DriverManager.getConnection(url, username, password);
            System.out.println("Database connection successfully established");

        }
        catch (SQLException e) {
            System.err.println("Connection Failed");
        }
        catch (ClassNotFoundException e) {
            System.err.println("DB Driver could not be loaded");
        }
    }

    public static SessionFactory getInstance(){
        return instance;
    }
    public Connection openSession() {
        return session;
    }

    public static void main(String[] args) {
        SessionFactory.getInstance();
    }
}


