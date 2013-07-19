using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccessModel
{
    public class TestInfo : DbInfo
    {
        string DbInfo.getConnectionString()
        {
            return "Data Source=EEEPC;Integrated Security=SSPI;Initial Catalog=TrabFinalSI2";
        }
    }
}
