DELIMITER $$

CREATE PROCEDURE `InsertCertificateEntries` 
	(
	in nCertNumber VarChar(50),
	in nSCertNumber VarChar(50),
	in nPCertNumber VarChar(50),
	in nInspectorName VarChar(45),
	in nApplID INT,
	in nCustomsEntryNumber VarChar(45),
	in nHTSCodeDescription VarChar(100),
    in nTotalWeight INT,
    in nResults VarChar(5),
    in nFDAStatus VarChar(5),
    in nUnitOfMeasure VarChar(5),
    in nInspectionLotIdNos VarChar(5),
    in nCBPContainerLotID VarChar(5),
    in nNumberOfPackages INT,
	in nInspectionDate DATETIME
	)
BEGIN

	DECLARE CertID, SCertID, PCertID, InspID INT;
	
	SELECT ID INTO CertID FROM certificates Where CertificateNumber = nCertNumber;
	    
	IF LENGTH(nCertNumber) > 0 AND ISNULL(CertID) = 1 THEN
		INSERT INTO certificates (CertificateNumber) VALUES (nCertNumber);
		SET CertID = @@IDENTITY;
	END IF;
    
    SELECT ID INTO SCertID FROM certificates Where CertificateNumber = nSCertNumber;
    
    IF LENGTH(nSCertNumber) > 0 AND ISNULL(SCertID) = 1 THEN
		INSERT INTO certificates (CertificateNumber) VALUES (nSCertNumber);
		SET SCertID = @@IDENTITY;
	END IF;
    
    SELECT ID INTO PCertID FROM certificates Where CertificateNumber = nPCertNumber;
    
    IF LENGTH(nPCertNumber) > 0 AND ISNULL(PCertID) = 1 THEN
		INSERT INTO certificates (CertificateNumber) VALUES (nPCertNumber);
		SET PCertID = @@IDENTITY;
	END IF;
    
    SELECT ID INTO InspID FROM certificateinspector Where InspectorName = nInspectorName;
    
    IF LENGTH(nInspectorName) > 0 AND ISNULL(InspID) = 1 THEN
		INSERT INTO certificateinspector (InspectorName) VALUES (nInspectorName);
		SET InspID = @@IDENTITY;
	END IF;
	
	INSERT INTO certificateentries (CertificateID, SuperseededCertID, PreviousCertID, InspectorID, ApplicantID, CustomerEntryNumber, HTSCodeDescription, TotalWeight, Results, FDAStatus, UnitOfMeasure, InspectionLotIdNos, CBPContainerLotID, NumberOfPackages, InspectionDate) VALUES (
		CertID, SCertID, PCertID, InspID, nApplID,
		nCustomsEntryNumber, nHTSCodeDescription, nTotalWeight, nResults,
		nFDAStatus, nUnitOfMeasure, nInspectionLotIdNos, nCBPContainerLotID,
		nNumberOfPackages, nInspectionDate
	);


END$$

DELIMITER ;