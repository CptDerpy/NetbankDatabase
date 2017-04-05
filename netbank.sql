DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS belongs_to;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS currency_transferrate;
DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS recurring_transaction;
DROP TABLE IF EXISTS rent;
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS User;

DROP SCHEMA IF EXISTS `netbank`;

-- -----------------------------------------------------
-- Schema netbank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `netbank` DEFAULT CHARACTER SET utf8 ;
USE `netbank` ;

-- -----------------------------------------------------
-- Table `netbank`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`User` (
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
  `amount` DECIMAL(10) NOT NULL,
  `currency_tag` VARCHAR(3) NOT NULL,
  `accountType` VARCHAR(45) NULL,
  PRIMARY KEY (`account_id`)
  );


-- -----------------------------------------------------
-- Table `netbank`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`transaction` (
  `trans_id` INT NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NULL,
  `from_account` INT NOT NULL,
  `to_account` INT NOT NULL,
  `amount` DECIMAL(10) NULL,
  `from_currency` VARCHAR(3) NOT NULL,
  `to_currency` VARCHAR(3) NOT NULL,
  `transferrate` DECIMAL(10) NULL,
  PRIMARY KEY (`trans_id`));


-- -----------------------------------------------------
-- Table `netbank`.`currency_transferrate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`currency_transferrate` (
  `rate_id` INT NOT NULL AUTO_INCREMENT,
  `rate` DECIMAL(9,8) NOT NULL,
  `from_currency` VARCHAR(3) NOT NULL,
  `to_currency` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`rate_id`));


-- -----------------------------------------------------
-- Table `netbank`.`recurring_transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`recurring_transaction` (
  `recurr_id` INT NOT NULL AUTO_INCREMENT,
  `from_account` INT NOT NULL,
  `to_account` INT NOT NULL,
  `amount` DECIMAL(10) NULL,
  `from_currency` VARCHAR(3) NOT NULL,
  `to_currency` VARCHAR(3) NOT NULL,
  `occurencyRate` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`recurr_id`));


-- -----------------------------------------------------
-- Table `netbank`.`loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`loan` (
  `loan_id` INT NOT NULL AUTO_INCREMENT,
  `loan_started` DATETIME NULL,
  `loan_expiration` DATETIME NULL,
  `from_account` INT NOT NULL,
  `to_account` INT NOT NULL,
  `amount` DECIMAL(10) NULL,
  `currency` VARCHAR(3) NOT NULL,
  `rate` VARCHAR(45) NULL,
  PRIMARY KEY (`loan_id`));


-- -----------------------------------------------------
-- Table `netbank`.`belongs_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netbank`.`belongs_to` (
  `belongs_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`belongs_id`));


DELETE FROM account;
DELETE FROM belongs_to;
DELETE FROM currency;
DELETE FROM currency_transferrate;
DELETE FROM loan;
DELETE FROM recurring_transaction;
DELETE FROM rent;
DELETE FROM	transaction;
DELETE FROM User;

INSERT User VALUES
(1,'HansAndersen','987654321'),
(2,'JohnDoe','qwerty'),
(3,'TaylorGang','123456'),
(4,'Painter','password');

INSERT account VALUES
(1001,539.55,'dkk','Opsparing'),
(1002,0.00,'dkk','Grundkonto'),
(1003,943847.5,'dkk','Opsparing'),
(1004,2233.0,'eur','Valutakonto'),
(1005,1233.0,'usd','Valutakonto');

INSERT belongs_to VALUES
(1,1001,1),
(2,1002,2),
(3,1003,3),
(4,1004,4);

INSERT currency_transferrate VALUES
(1,'7.43755801','eur','dkk'),
(2,'0.13445273','dkk','eur'),
(3,'1.06575000','eur','usd'),
(4,'0.93830635','usd','eur'),
(5,'0.14329300','dkk','usd'),
(6,'6.97870796','usd','dkk');

INSERT currency VALUES
('dkk'),
('eur'),
('usd');

INSERT rent VALUES
('Realkreditlån',1.5),
('QuickLån',13.5);

INSERT transaction VALUES
(1,'2017-02-14 18:32:44',1001,1002,199.95,'dkk','dkk',1),
(2,'2017-01-02 14:54:23',1003,1004,5000.00,'dkk','eur',0.134452733),
(3,'2017-03-24 16:12:31',1002,1001,8000.00,'dkk','dkk',1),
(4,'2016-08-05 08:35:18',1004,1005,250.00,'eur','usd',1.06575);

INSERT loan VALUES
(1,'2015-04-15 13:32:42','2025-04-15 13:32:42',1003,1003,25000,'dkk','Realkreditlån'),
(2,'2012-02-19 13:32:42','2022-02-19 13:32:42',1003,1003,8000,'dkk','QuickLån');

INSERT recurring_transaction VALUES
(1,1001,1002,199.95,'dkk','dkk','m'),
(2,1002,1001,8000.00,'dkk','dkk','y');

INSERT user VALUES
(5, 'JensJensen', 'jens0123');

INSERT account VALUES
(1006, 1500, 'eur', 'Grundkonto');

INSERT belongs_to VALUES
(5, 1006, 5);

SELECT * FROM currency_transferrate;