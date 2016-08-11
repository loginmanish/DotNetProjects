using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImportXmlData
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length == 0 || args[0] == "-h" || args[0] == "help" || args[0] == "-help")
            {
                commandDetails();
                return;
            }
            ImportXml importData = new ImportXml();
            try
            {
                string strCommand = args[0].ToLower();
                if (strCommand == "relational" || strCommand == "-r")
                    importData.saveXmlToData(InsertType.InsertRelationalData);
                else if (strCommand == "direct" || strCommand == "-d")
                    importData.saveXmlToData(InsertType.InsertDirect);
                else
                    Console.WriteLine("Invalid command. Please run with -h to get help.");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadKey();
            }
            importData = null;
        }

        static void commandDetails()
        {
            Console.WriteLine("XML Import Usage\n\n");
            Console.WriteLine("Commands are case insensitive");
            Console.WriteLine("Commands:-");
            Console.WriteLine("-h\t\tGet Usage Help");
            Console.WriteLine("-help\t\tGet Usage Help");
            Console.WriteLine("help\t\tGet Usage Help");
            Console.WriteLine("-r\t\tRun to import in relational tables");
            Console.WriteLine("relational\t\tRun to import in complex relational tables");
            Console.WriteLine("-d\t\tRun to import in simple relational tables");
            Console.WriteLine("direct\t\tRun to import in simple relational tables");
        }
    }
}
