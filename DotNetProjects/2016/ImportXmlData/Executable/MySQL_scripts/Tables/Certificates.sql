CREATE TABLE `certificates` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CertificateNumber` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `CertificateNumber_UNIQUE` (`CertificateNumber` ASC));