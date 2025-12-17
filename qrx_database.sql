CREATE DATABASE qrx_db;

USE qrx_db;

CREATE TABLE medicines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    batch VARCHAR(255) NOT NULL,
    status ENUM('Safe', 'Counterfeit', 'Expired', 'Not Found') NOT NULL
);
INSERT INTO medicines (name, manufacturer, batch, status) VALUES
('Paracetamol', 'PharmaOne', 'L2025B', 'Safe'),
('Amoxicillin', 'HealthCorp', 'AMX-101', 'Safe'),
('FakeCure', 'Unknown', 'FK-999', 'Counterfeit'),
('Neozep', 'Unilab', 'NZP-2023', 'Safe'),
('Ritemed', 'Ritemed Inc.', 'RTM-109', 'Safe'),
('Mefenamic Acid', 'Generic Pharma', 'MA-203', 'Expired'),
('Tuseran', 'Generic Pharma', 'TU-005', 'Counterfeit'),
('Ascof Lagundi', 'PharmaHealth', 'AL-412', 'Safe'),
('Hydroxychloroquine', 'Bristol-Myers Squibb', 'HCQ-405', 'Not FDA Approved'),
('Bactrim', 'Sanofi', 'STB-333', 'Safe'),
('Advil', 'Pfizer', 'AD-200', 'Safe'),
('Amoxicillin', 'HealthCorp', 'AMX-102', 'Counterfeit'),
('Lipitor', 'Pfizer', 'LP-543', 'Safe'),
('Roxithromycin', 'Roxithro, Inc.', 'RXM-001', 'Not FDA Approved'),
('Cefalexin', 'Generic Pharma', 'CFX-205', 'Expired');

select * from medicines;

INSERT INTO medicines (name, manufacturer, batch, status) VALUES
('Paracetamol', 'PharmaOne', 'L2025B', 'Safe');