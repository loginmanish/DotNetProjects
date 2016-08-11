CREATE TABLE CertificateApplicant (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  ApplicantName VARCHAR(45) NOT NULL,
  ApplicantContact VARCHAR(100) NOT NULL,
  ApplicantAddress VARCHAR(100) NOT NULL,
  ApplicantAddress2 VARCHAR(100) NULL,
  ApplicantCity VARCHAR(45) NOT NULL,
  ApplicantState VARCHAR(2) NOT NULL,
  ApplicantZip VARCHAR(12) NOT NULL,
  ApplicantPhone VARCHAR(45) NOT NULL,
  ApplicantFax VARCHAR(45) NULL,
  ApplicantEmail VARCHAR(100) NOT NULL)
