﻿CREATE TABLE Certificates (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  CertificateNumber VARCHAR(50) NOT NULL UNIQUE
  )