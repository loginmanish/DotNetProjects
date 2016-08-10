DELIMITER $$

CREATE PROCEDURE `spInsertCertificate` 
	(
	in nCertificateNumber VarChar(50),
	in nSupersededCertificateNumber VarChar(50),
	in nPreviousCertificateNumber VarChar(50),
	in nInspectorName VarChar(45),
	in nApplName Varchar(45),
	in nApplContact VarChar(100),
	in nApplAddress VarChar(100),
	in nApplAddress2 VarChar(100),
	in nApplCity VarChar(45),
	in nApplState VarChar(2),
	in nApplZip VarChar(12),
	in nApplPhone VarChar(45),
	in nApplFax VarChar(45),
	in nApplEmail VarChar(100),
    in nInspectionDate datetime,
	out nCertID INT
	)
BEGIN
    
    DECLARE RetCertID INT;
    
    IF LENGTH(nCertificateNumber) > 0 AND not Exists(SELECT 1 FROM td_certificate Where CertificateNumber = nCertificateNumber) THEN
		INSERT INTO td_certificate (CertificateNumber, SupersededCertificateNumber, PreviousCertificateNumber, InspectorName, ApplicantName, ApplicantContact, ApplicantAddress, ApplicantAddress2, ApplicantCity, ApplicantState, ApplicantZip, ApplicantPhone, ApplicantFax, ApplicantEmail, InspectionDate) VALUES (nCertificateNumber, nSupersededCertificateNumber, nPreviousCertificateNumber, nInspectorName,nApplName, nApplContact, nApplAddress, nApplAddress2, nApplCity, nApplState, nApplZip, nApplPhone, nApplFax, nApplEmail, nInspectionDate);
        SET RetCertID = @@IDENTITY;
    ELSE 
		SELECT ID INTO RetCertID FROM td_certificate Where CertificateNumber = nCertificateNumber;
    END IF;
        
    SET nCertID = RetCertID;
    
END$$

DELIMITER ;