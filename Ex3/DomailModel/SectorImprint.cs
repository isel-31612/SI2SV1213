using DomainModel;
using System;

namespace DomailModel
{
    public class SectorImprint : Imprint
    {
        public Request get(int id)
        {
            return new GetRequest("Sector",
                                  "SELECT piso,zona,instalacao,descr,extintor FROM Sector WHERE id=?",
                                  new Tuple<String,Object>[] { new Tuple<String,Object>("id",id) });
        }

        public Request get()
        {
            return new GetRequest("Sector",
                                  "SELECT piso,zona,instalacao,descr,extintor FROM Sector",
                                  null);
        }
    }
}