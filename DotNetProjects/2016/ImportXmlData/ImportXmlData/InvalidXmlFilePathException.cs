using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImportXmlData
{
    class InvalidXmlFilePathException : Exception
    {
        public InvalidXmlFilePathException() : base("Xml File path is invalid") { }

        public InvalidXmlFilePathException(string message) : base(message) { }
    }
}
