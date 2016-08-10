using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ImportXmlData
{
    public class InvalidConnectionStringException : Exception
    {
        public InvalidConnectionStringException()
            : base("Connection string not provided")
        {
        }

        public InvalidConnectionStringException(string message)
            : base(message)
        {
        }
    }
}
