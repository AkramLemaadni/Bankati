USE akramBank;

-- Insert test users with plain text passwords for testing
INSERT INTO users (first_name, last_name, username, password, role, creation_date) 
VALUES 
('Test', 'Admin', 'testadmin', 'admin123', 'ADMIN', CURDATE()),
('Test', 'Client', 'testclient', 'client123', 'CLIENT', CURDATE()),
('Test', 'User', 'testuser', 'user123', 'USER', CURDATE());

-- Display all users
SELECT id, username, password, role FROM users; 