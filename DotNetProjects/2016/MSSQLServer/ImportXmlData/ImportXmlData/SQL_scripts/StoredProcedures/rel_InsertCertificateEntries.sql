

CREATE PROCEDURE InsertCertificateEntries
	
	@nCertNumber VarChar(50),
	@nSCertNumber VarChar(50),
	@nPCertNumber VarChar(50),
	@nInspectorName VarChar(45),
	@nApplID INT,
	@nCustomsEntryNumber VarChar(45),
	@nHTSCodeDescription VarChar(100),
    @nTotalWeight INT,
    @nResults VarChar(5),
    @nFDAStatus VarChar(5),
    @nUnitOfMeasure VarChar(5),
    @nInspectionLotIdNos VarChar(5),
    @nCBPContainerLotID VarChar(5),
    @nNumberOfPackages INT,
	@nInspectionDate DATETIME
	
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @CertID AS INT, @SCertID AS INT, @PCertID AS INT, @InspID INT
	
	SELECT @CertID = ID FROM Certificates Where CertificateNumber = @nCertNumber
	    
	IF LEN(@nCertNumber) > 0 AND ISNULL(@CertID, 0) = 0
	BEGIN
		INSERT INTO Certificates (CertificateNumber) VALUES (@nCertNumber)
		SET @CertID = @@IDENTITY
	END
    
    SELECT @SCertID = ID FROM Certificates Where CertificateNumber = @nSCertNumber
    
    IF LEN(@nSCertNumber) > 0 AND ISNULL(@SCertID, 0) = 0
    BEGIN
		INSERT INTO Certificates (CertificateNumber) VALUES (@nSCertNumber)
		SET @SCertID = @@IDENTITY
	END
    
    SELECT @PCertID = ID FROM certificates Where CertificateNumber = @nPCertNumber
    
    IF LEN(@nPCertNumber) > 0 AND ISNULL(@PCertID, 0) = 0
    BEGIN
		INSERT INTO Certificates (CertificateNumber) VALUES (@nPCertNumber)
		SET @PCertID = @@IDENTITY
	END 
    
    SELECT @InspID = ID FROM CertificateInspector Where InspectorName = @nInspectorName
    
    IF LEN(@nInspectorName) > 0 AND ISNULL(@InspID, 0) = 0
    BEGIN
		INSERT INTO CertificateInspector (InspectorName) VALUES (@nInspectorName)
		SET @InspID = @@IDENTITY
	END 
	
	INSERT INTO CertificateEntries (CertificateID, SuperseededCertID, PreviousCertID, InspectorID, ApplicantID, CustomerEntryNumber, HTSCodeDescription, TotalWeight, Results, FDAStatus, UnitOfMeasure, InspectionLotIdNos, CBPContainerLotID, NumberOfPackages, InspectionDate) VALUES (
		@CertID, @SCertID, @PCertID, @InspID, @nApplID,
		@nCustomsEntryNumber, @nHTSCodeDescription, @nTotalWeight, @nResults,
		@nFDAStatus, @nUnitOfMeasure, @nInspectionLotIdNos, @nCBPContainerLotID,
		@nNumberOfPackages, @nInspectionDate
	)

	Return 1

END


