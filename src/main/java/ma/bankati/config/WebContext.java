package ma.bankati.config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.Enumeration;
import java.util.Properties;
import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.service.authentification.IAuthentificationService;
import ma.bankati.service.creditService.ICreditService;
import ma.bankati.service.moneyServices.IMoneyService;
import ma.bankati.util.DatabaseInitializer;

@WebListener
public class WebContext implements ServletContextListener {

    static void loadApplicationContext(ServletContext application) {
        var configFile = Thread.currentThread().getContextClassLoader().getResourceAsStream("configFiles/beans.properties");

        if (configFile != null) {
            Properties properties = new Properties();
            try {
                properties.load(configFile);
                
                // Print database connection information (for debug)
                System.out.println("Database URL: " + properties.getProperty("datasource.url"));
                System.out.println("Database Driver: " + properties.getProperty("datasource.driver"));

                // Charger les dependances
                String dataDaoClassName = properties.getProperty("dataDao");
                String userDaoClassName = properties.getProperty("userDao");
                String creditDaoClassName = properties.getProperty("creditDao");

                // Charger les services
                String moneyServClassName = properties.getProperty("moneyService");
                String authServClassName = properties.getProperty("authService");
                String creditServiceClassName = properties.getProperty("creditService");

                // Instantiation des dependances
                Class<?> cDataDao = Class.forName(dataDaoClassName);
                IDao dataDao = (IDao) cDataDao.getDeclaredConstructor().newInstance();

                Class<?> cUserDao = Class.forName(userDaoClassName);
                IUserDao userDao = (IUserDao) cUserDao.getDeclaredConstructor().newInstance();

                Class<?> cCreditDao = Class.forName(creditDaoClassName);
                ICreditDao creditDao = (ICreditDao) cCreditDao.getDeclaredConstructor().newInstance();

                // Instantiation des services avec ses dependances
                Class<?> cMoneyService = Class.forName(moneyServClassName);
                IMoneyService moneyService = (IMoneyService) cMoneyService.getDeclaredConstructor(IDao.class).newInstance(dataDao);

                Class<?> cAuthService = Class.forName(authServClassName);
                IAuthentificationService authService = (IAuthentificationService) cAuthService.getDeclaredConstructor(IUserDao.class).newInstance(userDao);

                Class<?> cCreditService = Class.forName(creditServiceClassName);
                ICreditService creditService = (ICreditService) cCreditService.getDeclaredConstructor(ICreditDao.class).newInstance(creditDao);

                application.setAttribute("dataDao", dataDao);
                application.setAttribute("moneyService", moneyService);
                application.setAttribute("userDao", userDao);
                application.setAttribute("authService", authService);
                application.setAttribute("creditDao", creditDao);
                application.setAttribute("creditService", creditService);

            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("Failed to initialize application context", e);
            }
        } else {
            System.err.println("Erreur : Le fichier beans.properties est introuvable !");
            throw new RuntimeException("Configuration file beans.properties not found");
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent ev) {
        var application = ev.getServletContext();
        application.setAttribute("AppName", "Akram's Bank");
        
        // Make sure database connection is established before loading application context
        try {
            // This will initialize the singleton
            SessionFactory.getInstance();
            System.out.println("Database connection established for the application");
            
            // Initialize database schema
            DatabaseInitializer.initializeDatabase();
        } catch (Exception e) {
            System.err.println("Failed to initialize database connection: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database initialization failed", e);
        }
        
        loadApplicationContext(application);
        System.out.println("Application Started and context initialized");
    }

    @Override
    public void contextDestroyed(ServletContextEvent ev) {
        var application = ev.getServletContext();
        Enumeration<String> attributeNames = application.getAttributeNames();

        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            application.removeAttribute(name);
        }

        System.out.println("Application Stopped");
    }
}