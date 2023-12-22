-- Set minimum password length to 4 characters
SET GLOBAL validate_password.length = 4;
SET GLOBAL validate_password.mixed_case_count = 0;

-- Set password policy to require at least 1 uppercase letter
SET GLOBAL validate_password.policy = 'LOW';
SHOW VARIABLES LIKE 'validate_password%';

-- Disable special character requirements
SET GLOBAL validate_password.special_char_count = 0;

-- Drop users if they exist
DROP USER IF EXISTS 'mark_anderson'@'localhost';
DROP USER IF EXISTS 'laura_white'@'localhost';
DROP USER IF EXISTS 'kevin_martin'@'localhost';
DROP USER IF EXISTS 'natalie_green'@'localhost';
DROP USER IF EXISTS 'michael_turner'@'localhost';
DROP USER IF EXISTS 'olivia_carter'@'localhost';

-- Create users
CREATE USER 'mark_anderson'@'localhost' IDENTIFIED BY 'markpass123';
CREATE USER 'laura_white'@'localhost' IDENTIFIED BY 'laura789';
CREATE USER 'kevin_martin'@'localhost' IDENTIFIED BY 'kevinpass';
CREATE USER 'natalie_green'@'localhost' IDENTIFIED BY 'natalie123';
CREATE USER 'michael_turner'@'localhost' IDENTIFIED BY 'mike456';
CREATE USER 'olivia_carter'@'localhost' IDENTIFIED BY 'olivia123';

-- Grant administrative privileges for the 'proparaskeuastiko' database
GRANT ALL PRIVILEGES ON proparaskeuastiko.* TO 'mark_anderson'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON proparaskeuastiko.* TO 'laura_white'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON proparaskeuastiko.* TO 'kevin_martin'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON proparaskeuastiko.* TO 'natalie_green'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON proparaskeuastiko.* TO 'michael_turner'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON proparaskeuastiko.* TO 'olivia_carter'@'localhost' WITH GRANT OPTION;

-- Flush privileges
FLUSH PRIVILEGES;
