DELIMITER $$

CREATE PROCEDURE `InsertRelational` 
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
	out nApplID INT
	)
BEGIN
    
    DECLARE RetApplID INT;
    
    IF LENGTH(nCertificateNumber) > 0 AND not Exists(SELECT 1 FROM certificates Where CertificateNumber = nCertificateNumber) THEN
		INSERT INTO certificates (CertificateNumber) VALUES (nCertificateNumber);
	END IF;
    
    IF LENGTH(nSupersededCertificateNumber) > 0 AND not Exists(SELECT 1 FROM certificates Where CertificateNumber = nSupersededCertificateNumber) THEN
		INSERT INTO certificates (CertificateNumber) VALUES (nSupersededCertificateNumber);
	END IF;
    
    IF LENGTH(nPreviousCertificateNumber) > 0 AND not Exists(SELECT 1 FROM certificates Where CertificateNumber = nPreviousCertificateNumber) THEN
		INSERT INTO certificates (CertificateNumber) VALUES (nPreviousCertificateNumber);
	END IF;
    
    IF LENGTH(nInspectorName) > 0 AND not exists(SELECT 1 FROM certificateinspector Where InspectorName = nInspectorName) THEN
		INSERT INTO certificateinspector (InspectorName) VALUES (nInspectorName);
	END IF;
    
    IF LENGTH(nApplEmail) > 0 AND not exists(SELECT 1 FROM certificateapplicant Where UPPER(ApplicantEmail) = UPPER(nApplEmail)) THEN
		INSERT INTO certificateapplicant (ApplicantName, ApplicantContact, ApplicantAddress, ApplicantAddress2, ApplicantCity, ApplicantState, ApplicantZip, ApplicantPhone, ApplicantFax, ApplicantEmail) VALUES (nApplName, nApplContact, nApplAddress, nApplAddress2, nApplCity, nApplState, nApplZip, nApplPhone, nApplFax, nApplEmail);
        SET RetApplID = @@IDENTITY;
    ELSE 
		SELECT ID INTO RetApplID FROM certificateapplicant Where UPPER(ApplicantEmail) = UPPER(nApplEmail);
    END IF;
        
    SET nApplID = RetApplID;
    
END$$

DELIMITER ;