CREATE TABLE CertificateEntries (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  CertificateID INT NOT NULL CONSTRAINT FK_CertificateEntries_Certificate FOREIGN KEY REFERENCES Certificates(ID),
  SuperseededCertID INT,
  PreviousCertID INT,
  InspectorID INT NOT NULL CONSTRAINT FK_CertificateEntries_Inspector FOREIGN KEY REFERENCES CertificateInspector(ID),
  ApplicantID INT NOT NULL CONSTRAINT FK_CertificateEntries_Applicant FOREIGN KEY REFERENCES CertificateApplicant(ID),
  CustomerEntryNumber VARCHAR(45) NOT NULL,
  HTSCodeDescription VARCHAR(100) NOT NULL,
  TotalWeight INT NOT NULL,
  Results VARCHAR(5) NOT NULL,
  FDAStatus VARCHAR(5) NOT NULL,
  UnitOfMeasure VARCHAR(5) NOT NULL,
  InspectionLotIdNos VARCHAR(5) NOT NULL,
  CBPContainerLotID VARCHAR(5) NOT NULL,
  NumberOfPackages INT NOT NULL,
  InspectionDate DATETIME NOT NULL)
  