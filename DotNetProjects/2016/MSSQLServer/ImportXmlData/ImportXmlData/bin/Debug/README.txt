Please Create a database on MySQL database server

Execute SQL Files from MySQL_Scripts folder. First All tables followed by all Stored Procedures

Then update the MySQL ConnectionString in ImportXmlData.exe.config file and Xml File path for the provided xml file including the xml file name.

Finally Execute the Executable with commands direct or relational

<strong>NOTE:<Note>
There are two ways of import provided here.
1. Simple which is executed through 'Direct' command and
2. Complex which is executed through 'Relational' command

On Direct the data is broken and imported in two tables only

On Relational it is broken further into 4 tables with options of adding further data in certain tables.

For Direct method the data are imported in tables td_certificates and td_certrow using stored procedures spInsertCertificate and spInsertCertRows given in files td_spInsertCertificate and td_spInsertCertRows respectively.

For Relational method the data is imported in tables Certificates, CertificateInspector, CertificateApplicant and CertificateEntries using stored procedures InsertCertificateEntries and InsertRelational given in files rel_InsertCertificateEntries and rel_InsertRelational respectively.