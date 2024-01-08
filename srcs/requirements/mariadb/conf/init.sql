USE mysql;
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'wordpress';
