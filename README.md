# Bankati Web Application

A Jakarta EE (JEE) native banking application with credit management features.

## Database Setup

1. Make sure MySQL is installed and running
2. The database connection is configured in `src/main/resources/configFiles/beans.properties`
3. Run the SQL scripts in the following order:
   - `src/main/resources/db/schema.sql` (creates tables)
   - `src/main/resources/db/data.sql` (inserts sample data)

## Project Structure

### Models
- `User`: Represents system users with different roles (Admin, Client)
- `Credit`: Represents credit applications with various statuses
- `MoneyData`: Represents monetary data with different currencies

### DAO Layer
The application uses a DAO pattern for database access with JEE native JDBC:

#### User DAO
- `IUserDao`: Interface defining user operations
- `UserDaoImpl`: Implementation using JDBC

#### Credit DAO
- `ICreditDao`: Interface defining credit operations
- `CreditDaoImpl`: Implementation using JDBC

#### Money Data DAO
- `IDao`: Interface defining money operations
- `DataDaoImpl`: Implementation using JDBC

### Utilities
- `SessionFactory`: Singleton managing database connections

### Context
- `WebContext`: Jakarta EE context listener for dependency injection

## Architecture

This application follows a layered architecture:
- Data Access Objects (DAOs) handle database operations
- Services provide business logic using DAOs
- Controllers handle HTTP requests
- JSP views render the UI

The application uses a dependency injection approach through the WebContext servlet listener, which reads configuration from beans.properties.

## DAO Usage Examples

### User DAO
```java
// Get the DAO from the context
IUserDao userDao = (IUserDao) application.getAttribute("userDao");

// Create a new user
User newUser = User.builder()
    .firstName("John")
    .lastName("Doe")
    .username("johndoe")
    .password("password")
    .role(ERole.CLIENT)
    .build();
userDao.save(newUser);

// Find user by ID
User user = userDao.findById(1L);

// Find all users
List<User> allUsers = userDao.findAll();
```

### Credit DAO
```java
// Get the DAO from the context
ICreditDao creditDao = (ICreditDao) application.getAttribute("creditDao");

// Create a new credit application
Credit newCredit = Credit.builder()
    .montant(15000.0)
    .dureeMois(24)
    .status(ECredit.EN_ATTENTE)
    .dateDemande(LocalDate.now())
    .userId(2L)
    .build();
creditDao.save(newCredit);

// Find credits by status
List<Credit> pendingCredits = creditDao.findByStatus(ECredit.EN_ATTENTE);
```

### Money Data DAO
```java
// Get the DAO from the context
IDao moneyDataDao = (IDao) application.getAttribute("dataDao");

// Get exchange rate
Double rate = moneyDataDao.getExchangeRate(Devise.MAD, Devise.USD);

// Save new money data
MoneyData data = new MoneyData();
data.setAmount(500.0);
data.setDevise(Devise.EUR);
moneyDataDao.save(data);
``` 