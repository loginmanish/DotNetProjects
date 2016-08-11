
CREATE PROCEDURE spInsertCertRows
	
	@nCertID INT,
	@nCustomsEntryNumber VarChar(45),
	@nHTSCodeDescription VarChar(100),
    @nTotalWeight INT,
    @nResults VarChar(5),
    @nFDAStatus VarChar(5),
    @nUnitOfMeasure VarChar(5),
    @nInspectionLotIdNos VarChar(5),
    @nCBPContainerLotID VarChar(5),
    @nNumberOfPackages INT
AS
BEGIN

	SET NOCOUNT ON
	
	INSERT INTO TD_CertRow (CertificateID, CustomsEntryNumber, HTSCodeDescription, TotalWeight, Results, FDAStatus, UnitOfMeasure, InspectionLotIdNos, CBPContainerLotID, NumberOfPackages) VALUES (
		@nCertID, @nCustomsEntryNumber, @nHTSCodeDescription, @nTotalWeight, @nResults,
		@nFDAStatus, @nUnitOfMeasure, @nInspectionLotIdNos, @nCBPContainerLotID,
		@nNumberOfPackages
	)

	Return 1

END