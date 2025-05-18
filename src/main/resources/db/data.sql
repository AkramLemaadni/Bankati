USE akramBank;

-- Insert initial users (password: password123)
INSERT INTO users (first_name, last_name, username, password, role, creation_date) 
VALUES 
('Admin', 'User', 'admin', '$2a$10$vY3OSIbFT9.5XyTEPWiE5eu6r6N2D9P8CZYzHsByQWvMo3MbwwVjS', 'ADMIN', CURDATE()),
('Client', 'User', 'client', '$2a$10$vY3OSIbFT9.5XyTEPWiE5eu6r6N2D9P8CZYzHsByQWvMo3MbwwVjS', 'CLIENT', CURDATE());

-- Insert sample credits
INSERT INTO credits (montant, duree_mois, status, date_demande, user_id)
VALUES 
(10000.0, 12, 'EN_ATTENTE', CURDATE(), 2),
(5000.0, 6, 'APPROUVE', DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 2),
(20000.0, 24, 'REFUSE', DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 2);

-- Insert money data
INSERT INTO money_data (amount, devise)
VALUES 
(1000.0, 'MAD'),
(100.0, 'USD'),
(90.0, 'EUR'); 