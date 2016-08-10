DELIMITER $$

CREATE PROCEDURE `spInsertCertRows` 
	(
	in nCertID INT,
	in nCustomsEntryNumber VarChar(45),
	in nHTSCodeDescription VarChar(100),
    in nTotalWeight INT,
    in nResults VarChar(5),
    in nFDAStatus VarChar(5),
    in nUnitOfMeasure VarChar(5),
    in nInspectionLotIdNos VarChar(5),
    in nCBPContainerLotID VarChar(5),
    in nNumberOfPackages INT
	)
BEGIN

	
	INSERT INTO td_certrow (CertificateID, CustomsEntryNumber, HTSCodeDescription, TotalWeight, Results, FDAStatus, UnitOfMeasure, InspectionLotIdNos, CBPContainerLotID, NumberOfPackages) VALUES (
		nCertID, nCustomsEntryNumber, nHTSCodeDescription, nTotalWeight, nResults,
		nFDAStatus, nUnitOfMeasure, nInspectionLotIdNos, nCBPContainerLotID,
		nNumberOfPackages
	);


END$$

DELIMITER ;