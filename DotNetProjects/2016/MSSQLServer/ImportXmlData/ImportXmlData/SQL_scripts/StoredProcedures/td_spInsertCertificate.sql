
CREATE PROCEDURE spInsertCertificate
	
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
    @nInspectionDate datetime,
	@nCertID INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON
    
    DECLARE @RetCertID INT;
    
    IF LEN(@nCertificateNumber) > 0 AND not Exists(SELECT 1 FROM td_certificate Where CertificateNumber = @nCertificateNumber) 
    BEGIN
		INSERT INTO TD_Certificate (CertificateNumber, SupersededCertificateNumber, PreviousCertificateNumber, InspectorName, ApplicantName, ApplicantContact, ApplicantAddress, ApplicantAddress2, ApplicantCity, ApplicantState, ApplicantZip, ApplicantPhone, ApplicantFax, ApplicantEmail, InspectionDate) VALUES (@nCertificateNumber, @nSupersededCertificateNumber, @nPreviousCertificateNumber, @nInspectorName, @nApplName, @nApplContact, @nApplAddress, @nApplAddress2, @nApplCity, @nApplState, @nApplZip, @nApplPhone, @nApplFax, @nApplEmail, @nInspectionDate)
        SET @RetCertID = @@IDENTITY
    END ELSE BEGIN
		SELECT @RetCertID = ID FROM td_certificate Where CertificateNumber = @nCertificateNumber
    END
        
    SET @nCertID = @RetCertID
    
    Return 1
    
END

