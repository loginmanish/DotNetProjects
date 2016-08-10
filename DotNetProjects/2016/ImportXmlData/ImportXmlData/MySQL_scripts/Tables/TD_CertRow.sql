CREATE TABLE `td_certrow` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CertificateID` INT NOT NULL,
  `CustomsEntryNumber` VARCHAR(45) NOT NULL,
  `HTSCodeDescription` VARCHAR(100) NOT NULL,
  `TotalWeight` INT NOT NULL,
  `Results` VARCHAR(5) NOT NULL,
  `FDAStatus` VARCHAR(5) NOT NULL,
  `UnitOfMeasure` VARCHAR(5) NOT NULL,
  `InspectionLotIdNos` VARCHAR(5) NOT NULL,
  `CBPContainerLotID` VARCHAR(5) NOT NULL,
  `NumberOfPackages` INT NOT NULL,
  PRIMARY KEY (`ID`));
  
  ALTER TABLE `td_certrow` 
	ADD CONSTRAINT `FK_td_certrow_certificate` 
		FOREIGN KEY (`CertificateID`)
			REFERENCES `td_certificate`(`ID`)
				ON DELETE CASCADE;