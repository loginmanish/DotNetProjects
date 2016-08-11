
CREATE PROCEDURE InsertRelational
	
	@nCertificateNumber VarChar(50),
	@nSupersededCertificateNumber VarChar(50),
	@nPreviousCertificateNumber VarChar(50),
	@nInspectorName VarChar(45),
	@nApplName Varchar(45),
	@nApplContact VarChar(100),
	@nApplAddress VarChar(100),
	@nApplAddress2 VarChar(100),
	@nApplCity VarChar(45),
	@nApplState VarChar(2),
	@nApplZip VarChar(12),
	@nApplPhone VarChar(45),
	@nApplFax VarChar(45),
	@nApplEmail VarChar(100),
	@nApplID INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON
    
    DECLARE @RetApplID INT
    
    IF LEN(@nCertificateNumber) > 0 AND not Exists(SELECT 1 FROM Certificates Where CertificateNumber = @nCertificateNumber) 
		INSERT INTO Certificates (CertificateNumber) VALUES (@nCertificateNumber)
    
    IF LEN(@nSupersededCertificateNumber) > 0 AND not Exists(SELECT 1 FROM Certificates Where CertificateNumber = @nSupersededCertificateNumber) 
		INSERT INTO Certificates (CertificateNumber) VALUES (@nSupersededCertificateNumber)
    
    IF LEN(@nPreviousCertificateNumber) > 0 AND not Exists(SELECT 1 FROM Certificates Where CertificateNumber = @nPreviousCertificateNumber) 
		INSERT INTO Certificates (CertificateNumber) VALUES (@nPreviousCertificateNumber)
    
    IF LEN(@nInspectorName) > 0 AND not exists(SELECT 1 FROM CertificateInspector Where InspectorName = @nInspectorName) 
		INSERT INTO CertificateInspector (InspectorName) VALUES (@nInspectorName)
    
    IF LEN(@nApplEmail) > 0 AND not exists(SELECT 1 FROM certificateapplicant Where UPPER(ApplicantEmail) = UPPER(@nApplEmail)) 
    BEGIN
		INSERT INTO CertificateApplicant (ApplicantName, ApplicantContact, ApplicantAddress, ApplicantAddress2, ApplicantCity, ApplicantState, ApplicantZip, ApplicantPhone, ApplicantFax, ApplicantEmail) VALUES (@nApplName, @nApplContact, @nApplAddress, @nApplAddress2, @nApplCity, @nApplState, @nApplZip, @nApplPhone, @nApplFax, @nApplEmail)
        SET @RetApplID = @@IDENTITY
    END ELSE BEGIN
		SELECT @RetApplID = ID FROM CertificateApplicant Where UPPER(ApplicantEmail) = UPPER(@nApplEmail)
    END
        
    SET @nApplID = @RetApplID
    
    Return 1
    
END

