DROP TABLE IF EXISTS belongs_to;
DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS recurring_transaction;
DROP TABLE IF EXISTS currency_transferrate;
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS rent;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS user;

DROP SCHEMA IF EXISTS `netbank`;

-- -----------------------------------------------------
-- Schema netbank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `netbank` DEFAULT CHARACTER SET utf8 ;
USE `netbank` ;

-- -----------------------------------------------------
-- Table `netbank`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`));



-- -----------------------------------------------------
-- Table `netbank`.`currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`currency` (
  `tag` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`tag`));



-- -----------------------------------------------------
-- Table `netbank`.`rent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`rent` (
  `name` VARCHAR(45) NOT NULL,
  `rate` DECIMAL(3,1) NOT NULL,
  PRIMARY KEY (`name`));


-- -----------------------------------------------------
-- Table `netbank`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `currency_tag` VARCHAR(3) NOT NULL,
  `accountType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`account_id`),
  FOREIGN KEY(`currency_tag`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`accountType`) REFERENCES `netbank`.`rent`(`name`));


-- -----------------------------------------------------
-- Table `netbank`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`transaction` (
  `trans_id` INT NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NULL,
  `from_account` INT NOT NULL,
  `to_account` INT NOT NULL,
  `amount` DECIMAL(10,2) NULL,
  `from_currency` VARCHAR(3) NOT NULL,
  `to_currency` VARCHAR(3) NOT NULL,
  `transferrate` DECIMAL(10,9) NULL,
  PRIMARY KEY (`trans_id`),
  FOREIGN KEY(`from_currency`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`to_currency`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`from_account`) REFERENCES `netbank`.`account`(`account_id`),
  FOREIGN KEY(`to_account`) REFERENCES `netbank`.`account`(`account_id`)
  );


-- -----------------------------------------------------
-- Table `netbank`.`currency_transferrate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`currency_transferrate` (
  `rate_id` INT NOT NULL AUTO_INCREMENT,
  `rate` DECIMAL(9,8) NOT NULL,
  `from_currency` VARCHAR(3) NOT NULL,
  `to_currency` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`rate_id`),
  FOREIGN KEY(`from_currency`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`to_currency`) REFERENCES `netbank`.`currency`(`tag`));
CREATE UNIQUE INDEX unique_rate ON `netbank`.`currency_transferrate` (`from_currency`, `to_currency`);

-- -----------------------------------------------------
-- Table `netbank`.`recurring_transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`recurring_transaction` (
  `recurr_id` INT NOT NULL AUTO_INCREMENT,
  `from_account` INT NOT NULL,
  `to_account` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `from_currency` VARCHAR(3) NOT NULL,
  `to_currency` VARCHAR(3) NOT NULL,
  `occurencyRate` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`recurr_id`),
  FOREIGN KEY(`from_currency`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`to_currency`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`from_account`) REFERENCES `netbank`.`account`(`account_id`),
  FOREIGN KEY(`to_account`) REFERENCES `netbank`.`account`(`account_id`));


-- -----------------------------------------------------
-- Table `netbank`.`loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`loan` (
  `loan_id` INT NOT NULL AUTO_INCREMENT,
  `loan_started` DATETIME NOT NULL,
  `loan_expiration` DATETIME NOT NULL,
  `from_account` INT NOT NULL,
  `to_account` INT NOT NULL,
  `amount` DECIMAL(10) NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  `rate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`loan_id`),
  FOREIGN KEY(`currency`) REFERENCES `netbank`.`currency`(`tag`),
  FOREIGN KEY(`from_account`) REFERENCES `netbank`.`account`(`account_id`),
  FOREIGN KEY(`to_account`) REFERENCES `netbank`.`account`(`account_id`),
  FOREIGN KEY(`rate`) REFERENCES `netbank`.`rent`(`name`));


-- -----------------------------------------------------
-- Table `netbank`.`belongs_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`belongs_to` (
  `belongs_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`belongs_id`),
  FOREIGN KEY(`account_id`) REFERENCES `netbank`.`account`(`account_id`),
  FOREIGN KEY(`user_id`) REFERENCES `netbank`.`user`(`user_id`));

INSERT user VALUES
(1,'HansAndersen','987654321'),
(2,'JohnDoe','qwerty'),
(3,'TaylorGang','123456'),
(4,'Painter','password');

INSERT currency VALUES
('dkk'),
('eur'),
('usd');

INSERT rent VALUES
('Realkreditlån',1.5),
('QuickLån',13.5),
('Opsparing', 0.5),
('Grundkonto', 0.5),
('Valutakonto', 0.7);

INSERT account VALUES
(1001,539.55,'dkk','Opsparing'),
(1002,0.00,'dkk','Grundkonto'),
(1003,943847.50,'dkk','Opsparing'),
(1004,2233.00,'eur','Valutakonto'),
(1005,1233.00,'usd','Valutakonto');

INSERT transaction VALUES
(1,'2017-02-14 18:32:44',1001,1002,199.95,'dkk','dkk',1.000000000),
(2,'2017-01-02 14:54:23',1003,1004,5000.00,'dkk','eur',0.134452733),
(3,'2017-03-24 16:12:31',1002,1001,8000.00,'dkk','dkk',1.000000000),
(4,'2016-08-05 08:35:18',1004,1005,250.00,'eur','usd',1.065750000);

INSERT currency_transferrate VALUES
(1,'7.43755801','eur','dkk'),
(2,'0.13445273','dkk','eur'),
(3,'1.06575000','eur','usd'),
(4,'0.93830635','usd','eur'),
(5,'0.14329300','dkk','usd'),
(6,'6.97870796','usd','dkk');

INSERT recurring_transaction VALUES
(1,1001,1002,199.95,'dkk','dkk','m'),
(2,1002,1001,8000.00,'dkk','dkk','y');

INSERT loan VALUES
(1,'2015-04-15 13:32:42','2025-04-15 13:32:42',1003,1003,25000,'dkk','Realkreditlån'),
(2,'2012-02-19 13:32:42','2022-02-19 13:32:42',1003,1003,8000,'dkk','QuickLån');

INSERT belongs_to VALUES
(1,1001,1),
(2,1002,2),
(3,1003,3),
(4,1004,4);

INSERT user VALUES
(5, 'JensJensen', 'jens0123');

INSERT account VALUES
(1006, 0.00, 'dkk', 'Grundkonto');

INSERT belongs_to VALUES
(5, 1006, 5);

SELECT user_id, username, password, account_id, amount, currency_tag, accountType FROM user NATURAL JOIN belongs_to NATURAL JOIN account;