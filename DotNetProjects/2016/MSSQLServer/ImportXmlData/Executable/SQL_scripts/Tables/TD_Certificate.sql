CREATE TABLE TD_Certificate (
  ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  CertificateNumber varchar(45) NOT NULL UNIQUE,
  SupersededCertificateNumber varchar(45) DEFAULT NULL,
  PreviousCertificateNumber varchar(45) DEFAULT NULL,
  InspectorName varchar(45) NOT NULL,
  ApplicantName varchar(45) NOT NULL,
  ApplicantContact varchar(100) NOT NULL,
  ApplicantAddress varchar(100) NOT NULL,
  ApplicantAddress2 varchar(100) DEFAULT NULL,
  ApplicantCity varchar(45) NOT NULL,
  ApplicantState varchar(2) NOT NULL,
  ApplicantZip varchar(12) NOT NULL,
  ApplicantPhone varchar(45) NOT NULL,
  ApplicantFax varchar(45) DEFAULT NULL,
  ApplicantEmail varchar(100) NOT NULL,
  InspectionDate datetime NOT NULL
)