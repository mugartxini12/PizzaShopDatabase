-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SmithPizza
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SmithPizza` ;

-- -----------------------------------------------------
-- Schema SmithPizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SmithPizza` DEFAULT CHARACTER SET utf8 ;
USE `SmithPizza` ;

-- -----------------------------------------------------
-- Table `SmithPizza`.`Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Pizza` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Pizza` (
  `idPizza` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `vegetarian` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`Ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Ingredient` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Ingredient` (
  `idIngredient` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIngredient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`Drink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Drink` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Drink` (
  `idDrink` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idDrink`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Customer` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Customer` (
  `idCustomer` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Order` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Order` (
  `idOrder` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `Customer_idCustomer` INT NOT NULL,
  PRIMARY KEY (`idOrder`, `Customer_idCustomer`),
  INDEX `fk_Order_Customer1_idx` (`Customer_idCustomer` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`Customer_idCustomer`)
    REFERENCES `SmithPizza`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`DiscountCode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`DiscountCode` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`DiscountCode` (
  `idDiscountCode` INT NOT NULL,
  `used` TINYINT NOT NULL,
  `Customer_idCustomer` INT NOT NULL,
  PRIMARY KEY (`idDiscountCode`, `Customer_idCustomer`),
  INDEX `fk_DiscountCode_Customer1_idx` (`Customer_idCustomer` ASC) VISIBLE,
  CONSTRAINT `fk_DiscountCode_Customer1`
    FOREIGN KEY (`Customer_idCustomer`)
    REFERENCES `SmithPizza`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`Restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Restaurant` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Restaurant` (
  `idRestaurant` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `areaCode` INT NOT NULL,
  PRIMARY KEY (`idRestaurant`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`PizzaOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`PizzaOrder` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`PizzaOrder` (
  `idPizzaOrder` INT NOT NULL,
  `Order_idOrder` INT NOT NULL,
  `Pizza_idPizza` INT NOT NULL,
  PRIMARY KEY (`idPizzaOrder`, `Order_idOrder`, `Pizza_idPizza`),
  INDEX `fk_PizzaOrder_Order1_idx` (`Order_idOrder` ASC) VISIBLE,
  INDEX `fk_PizzaOrder_Pizza1_idx` (`Pizza_idPizza` ASC) VISIBLE,
  CONSTRAINT `fk_PizzaOrder_Order1`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `SmithPizza`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PizzaOrder_Pizza1`
    FOREIGN KEY (`Pizza_idPizza`)
    REFERENCES `SmithPizza`.`Pizza` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`DrinkOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`DrinkOrder` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`DrinkOrder` (
  `idDrinkOrder` INT NOT NULL,
  `Order_idOrder` INT NOT NULL,
  `Order_Customer_idCustomer` INT NOT NULL,
  `Drink_idDrink` INT NOT NULL,
  PRIMARY KEY (`idDrinkOrder`, `Order_idOrder`, `Order_Customer_idCustomer`, `Drink_idDrink`),
  INDEX `fk_DrinkOrder_Order1_idx` (`Order_idOrder` ASC, `Order_Customer_idCustomer` ASC) VISIBLE,
  INDEX `fk_DrinkOrder_Drink1_idx` (`Drink_idDrink` ASC) VISIBLE,
  CONSTRAINT `fk_DrinkOrder_Order1`
    FOREIGN KEY (`Order_idOrder` , `Order_Customer_idCustomer`)
    REFERENCES `SmithPizza`.`Order` (`idOrder` , `Customer_idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DrinkOrder_Drink1`
    FOREIGN KEY (`Drink_idDrink`)
    REFERENCES `SmithPizza`.`Drink` (`idDrink`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`DeliveyRider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`DeliveyRider` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`DeliveyRider` (
  `idDeliveyRider` INT NOT NULL,
  `Restaurant_idRestaurant` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDeliveyRider`, `Restaurant_idRestaurant`),
  INDEX `fk_DeliveyRider_Restaurant1_idx` (`Restaurant_idRestaurant` ASC) VISIBLE,
  CONSTRAINT `fk_DeliveyRider_Restaurant1`
    FOREIGN KEY (`Restaurant_idRestaurant`)
    REFERENCES `SmithPizza`.`Restaurant` (`idRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`RestaurantOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`RestaurantOrder` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`RestaurantOrder` (
  `idRestaurantOrder` INT NOT NULL,
  `Order_idOrder` INT NOT NULL,
  `Order_Customer_idCustomer` INT NOT NULL,
  `Restaurant_idRestaurant` INT NOT NULL,
  PRIMARY KEY (`idRestaurantOrder`, `Order_idOrder`, `Order_Customer_idCustomer`, `Restaurant_idRestaurant`),
  INDEX `fk_RestaurantOrder_Order1_idx` (`Order_idOrder` ASC, `Order_Customer_idCustomer` ASC) VISIBLE,
  INDEX `fk_RestaurantOrder_Restaurant1_idx` (`Restaurant_idRestaurant` ASC) VISIBLE,
  CONSTRAINT `fk_RestaurantOrder_Order1`
    FOREIGN KEY (`Order_idOrder` , `Order_Customer_idCustomer`)
    REFERENCES `SmithPizza`.`Order` (`idOrder` , `Customer_idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RestaurantOrder_Restaurant1`
    FOREIGN KEY (`Restaurant_idRestaurant`)
    REFERENCES `SmithPizza`.`Restaurant` (`idRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`Desert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`Desert` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`Desert` (
  `idDesert` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idDesert`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`DesertOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`DesertOrder` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`DesertOrder` (
  `idDesertOrder` INT NOT NULL,
  `Order_idOrder` INT NOT NULL,
  `Order_Customer_idCustomer` INT NOT NULL,
  `Desert_idDesert` INT NOT NULL,
  PRIMARY KEY (`idDesertOrder`, `Order_idOrder`, `Order_Customer_idCustomer`, `Desert_idDesert`),
  INDEX `fk_DesertOrder_Order1_idx` (`Order_idOrder` ASC, `Order_Customer_idCustomer` ASC) VISIBLE,
  INDEX `fk_DesertOrder_Desert1_idx` (`Desert_idDesert` ASC) VISIBLE,
  CONSTRAINT `fk_DesertOrder_Order1`
    FOREIGN KEY (`Order_idOrder` , `Order_Customer_idCustomer`)
    REFERENCES `SmithPizza`.`Order` (`idOrder` , `Customer_idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DesertOrder_Desert1`
    FOREIGN KEY (`Desert_idDesert`)
    REFERENCES `SmithPizza`.`Desert` (`idDesert`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SmithPizza`.`PizzaIngredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SmithPizza`.`PizzaIngredient` ;

CREATE TABLE IF NOT EXISTS `SmithPizza`.`PizzaIngredient` (
  `idPizzaIngredient` INT NOT NULL,
  `Pizza_idPizza` INT NOT NULL,
  `Ingredient_idIngredient` INT NOT NULL,
  PRIMARY KEY (`idPizzaIngredient`, `Pizza_idPizza`, `Ingredient_idIngredient`),
  INDEX `fk_PizzaIngredient_Pizza1_idx` (`Pizza_idPizza` ASC) VISIBLE,
  INDEX `fk_PizzaIngredient_Ingredient1_idx` (`Ingredient_idIngredient` ASC) VISIBLE,
  CONSTRAINT `fk_PizzaIngredient_Pizza1`
    FOREIGN KEY (`Pizza_idPizza`)
    REFERENCES `SmithPizza`.`Pizza` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PizzaIngredient_Ingredient1`
    FOREIGN KEY (`Ingredient_idIngredient`)
    REFERENCES `SmithPizza`.`Ingredient` (`idIngredient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
