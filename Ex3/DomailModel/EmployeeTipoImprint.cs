using DomainModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DomailModel
{
    public class EmployeeTipoImprint : Imprint
    {
        public Request get()
        {
            return new GetRequest(
                "estadoFunc",
                "SELECT id,nomeEstado FROM estadoFunc",
                new Tuple<String,Object>[0]
                );
        }
    }
}
