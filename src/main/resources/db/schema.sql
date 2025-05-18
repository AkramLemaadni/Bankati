-- Create database if doesn't exist
CREATE DATABASE IF NOT EXISTS akramBank;

USE akramBank;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    creation_date DATE NOT NULL
);

-- Credits table
CREATE TABLE IF NOT EXISTS credits (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    montant DOUBLE NOT NULL,
    duree_mois INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    date_demande DATE NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Money data table
CREATE TABLE IF NOT EXISTS money_data (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    value DOUBLE NOT NULL,
    devise VARCHAR(20) NOT NULL,
    creation_date DATE NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
