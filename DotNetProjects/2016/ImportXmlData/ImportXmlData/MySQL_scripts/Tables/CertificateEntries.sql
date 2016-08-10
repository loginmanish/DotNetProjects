CREATE TABLE `certificateentries` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CertificateID` INT NOT NULL,
  `SuperseededCertID` INT,
  `PreviousCertID` INT,
  `InspectorID` INT NOT NULL,
  `ApplicantID` INT NOT NULL,
  `CustomerEntryNumber` VARCHAR(45) NOT NULL,
  `HTSCodeDescription` VARCHAR(100) NOT NULL,
  `TotalWeight` INT NOT NULL,
  `Results` VARCHAR(5) NOT NULL,
  `FDAStatus` VARCHAR(5) NOT NULL,
  `UnitOfMeasure` VARCHAR(5) NOT NULL,
  `InspectionLotIdNos` VARCHAR(5) NOT NULL,
  `CBPContainerLotID` VARCHAR(5) NOT NULL,
  `NumberOfPackages` INT NOT NULL,
  `InspectionDate` DATETIME NOT NULL,
  PRIMARY KEY (`ID`));
  
  
ALTER TABLE certificateentries
	ADD CONSTRAINT FK_CertificateEntries_Certificate
		FOREIGN KEY (CertificateID) 
			REFERENCES certificates(ID)
				ON DELETE CASCADE;


ALTER TABLE certificateentries
	ADD CONSTRAINT FK_CertificateEntries_Inspector
		FOREIGN KEY (InspectorID) 
			REFERENCES certificateinspector(ID) 
				ON DELETE CASCADE;
				
ALTER TABLE certificateentries
	ADD CONSTRAINT FK_CertificateEntries_Applicant 
		FOREIGN KEY (ApplicantID)
			REFERENCES certificateapplicant(ID) 
				ON DELETE CASCADE;