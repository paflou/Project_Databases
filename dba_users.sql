

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

-- Grant SUPER privilege to users		# den eimai sigouros an xreiazetai auto. to ebala sthn prospateia mou na kanv ta triggers gia to 3.1.4.1. na doulepsoun
GRANT SUPER ON *.* TO 'mark_anderson'@'localhost';
GRANT SUPER ON *.* TO 'laura_white'@'localhost';
GRANT SUPER ON *.* TO 'kevin_martin'@'localhost';
GRANT SUPER ON *.* TO 'natalie_green'@'localhost';
GRANT SUPER ON *.* TO 'michael_turner'@'localhost';
GRANT SUPER ON *.* TO 'olivia_carter'@'localhost';


-- Flush privileges
FLUSH PRIVILEGES;
