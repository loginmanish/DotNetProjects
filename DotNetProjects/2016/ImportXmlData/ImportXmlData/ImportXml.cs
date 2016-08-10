using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Xml;

namespace ImportXmlData
{
    enum InsertType
    {
        InsertDirect,
        InsertRelationalData
    }

    class ImportXml
    {
        private string pstrConnectionString = "";

        private string pstrXmlFile = "";

        public ImportXml()
        {
            pstrConnectionString = ConfigurationManager.AppSettings["ConnectionString"];
            pstrXmlFile = ConfigurationManager.AppSettings["XmlFilePath"];
        }

        public void saveXmlToData(InsertType insertType)
        {
            if (pstrXmlFile.Trim().Length == 0)
                throw new InvalidXmlFilePathException("Xml File path is not set");

            if (pstrConnectionString.Trim().Length == 0)
                throw new InvalidConnectionStringException("Connection string not provided");

            MySqlConnection conn = new MySqlConnection(pstrConnectionString);
            conn.Open();

            MySqlCommand command = conn.CreateCommand();

            XmlDocument xDoc = new XmlDocument();
            xDoc.Load(pstrXmlFile);
            XmlNode mainElement = xDoc.DocumentElement;

            if (insertType == InsertType.InsertDirect)
                insertDataDirect(command, mainElement);
            else if (insertType == InsertType.InsertRelationalData)
                insertDataRelational(command, mainElement);

            command.Dispose();
            conn.Close();
            conn = null;
            xDoc = null;
        }

        private void insertDataRelational(MySqlCommand command, XmlNode mainElement)
        {
            //Insert into tables certificates, certificateapplicants, certificateinspector, certificateentries

            XmlNodeList nodes = mainElement.ChildNodes;
            
            foreach (XmlNode node in nodes)
            {
                command.Parameters.Clear();
                command.CommandText = "InsertRelational";
                command.CommandType = System.Data.CommandType.StoredProcedure;
                XmlNodeList innerElements = node.ChildNodes;
                List<XmlNode> certRows = new List<XmlNode>();
                foreach (XmlNode innerNode in innerElements)
                {
                    if (innerNode.ChildNodes.Count <= 1 && innerNode.Name != "InspectionDate")
                    {
                        command.Parameters.Add(getParameter(System.Data.DbType.String, System.Data.ParameterDirection.Input, innerNode.Name.Replace("Applicant", "Appl"), innerNode.InnerText));
                    }
                    
                    if (innerNode.Name == "CertRow")
                    {
                        certRows.Add(innerNode);
                    }
                }
                command.Parameters.Add(getParameter(System.Data.DbType.Int32, System.Data.ParameterDirection.Output, "ApplID", null));
                int ret = command.ExecuteNonQuery();
                int intApplID = (int)command.Parameters["nApplID"].Value;
                if (ret == 1)
                {
                    //XmlNodeList certRows = node.SelectNodes("//CertRow");
                    
                    command.CommandText = "InsertCertificateEntries";
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    command.Parameters.Clear();
                    command.Parameters.Add(
                        getParameter(System.Data.DbType.String, System.Data.ParameterDirection.Input
                        , "CertNumber", node.ChildNodes[0].InnerText));
                    
                    command.Parameters.Add(
                        getParameter(System.Data.DbType.String, System.Data.ParameterDirection.Input
                        , "SCertNumber", node.ChildNodes[1].InnerText));
                    command.Parameters.Add(
                        getParameter(System.Data.DbType.String, System.Data.ParameterDirection.Input
                        , "PCertNumber", node.ChildNodes[2].InnerText));
                    command.Parameters.Add(
                        getParameter(System.Data.DbType.String, System.Data.ParameterDirection.Input
                        , "InspectorName", node.ChildNodes[3].InnerText));
                    command.Parameters.Add(
                        getParameter(System.Data.DbType.DateTime, System.Data.ParameterDirection.Input
                        , "InspectionDate", DateTime.Parse(node.ChildNodes[node.ChildNodes.Count - (certRows.Count + 1)].InnerText)));
                    
                    command.Parameters.Add(
                        getParameter(System.Data.DbType.Int32, System.Data.ParameterDirection.Input
                        , "ApplID", intApplID));
                    foreach (XmlNode certRowNode in certRows)
                    {
                        XmlNodeList certDatas = certRowNode.ChildNodes;
                        foreach (XmlNode certData in certDatas)
                        {
                            command.Parameters.Add(
                                getParameter(System.Data.DbType.String, System.Data.ParameterDirection.Input
                                , certData.Name, certData.InnerText));

                        }
                        ret = command.ExecuteNonQuery();
                        foreach (XmlNode certData in certDatas)
                        {
                            command.Parameters.RemoveAt("n" + certData.Name);
                        }
                    }

                }
            }
        }

        private MySqlParameter getParameter(System.Data.DbType pType, System.Data.ParameterDirection direction, string pName, object value)
        {
            MySqlParameter param = new MySqlParameter();
            param.DbType = pType;
            param.Direction = direction;
            param.ParameterName = "n" + pName;
            param.Value = value;
            return param;
        }

        private void insertDataDirect(MySqlCommand command, XmlNode mainElement)
        {
            //Insert into tables td_certificate, td_certrow
            XmlNodeList nodes = mainElement.ChildNodes;

            foreach (XmlNode node in nodes)
            {
                XmlNode tNode = node.FirstChild;

                command.Parameters.Clear();
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandText = "spInsertCertificate";

                while (tNode != null && tNode.Name != "CertRow")
                {
                    if (tNode.Name.ToLower().Contains("date"))
                    {
                        command.Parameters.Add(getParameter
                            (System.Data.DbType.DateTime, System.Data.ParameterDirection.Input, tNode.Name.Replace("Applicant", "Appl"), tNode.InnerText));
                    }
                    else
                    {
                        command.Parameters.Add(getParameter
                            (System.Data.DbType.String, System.Data.ParameterDirection.Input, tNode.Name.Replace("Applicant", "Appl"), tNode.InnerText));
                    }
                    tNode = tNode.NextSibling;
                }

                command.Parameters.Add(getParameter(System.Data.DbType.Int32, System.Data.ParameterDirection.Output, "CertID", null));
                int ret = command.ExecuteNonQuery();

                string intCertId = command.Parameters["nCertID"].Value.ToString();

                command.Parameters.Clear();
                command.CommandText = "spInsertCertRows";

                command.Parameters.Add(getParameter(System.Data.DbType.Int32, System.Data.ParameterDirection.Input, "CertID", intCertId));

                while (tNode != null && tNode.Name == "CertRow")
                {
                    XmlNodeList tChildren = tNode.ChildNodes;
                    foreach (XmlNode child in tChildren)
                    {
                        command.Parameters.Add(getParameter
                            (System.Data.DbType.String, System.Data.ParameterDirection.Input, child.Name, child.InnerText));
                    }
                    ret = command.ExecuteNonQuery();
                    foreach (XmlNode child in tChildren)
                    {
                        command.Parameters.RemoveAt("n" + child.Name);
                    }

                    tNode = tNode.NextSibling;
                }
            }
        }

    }

    
}
