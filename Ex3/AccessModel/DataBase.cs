using DomainModel;
using System;
using System.Data;

namespace AccessModel
{
    public abstract class DataBase
    {
        public abstract DataSet execute(Request r,bool refresh=false);
        public abstract void prepare(DbInfo info);
    }
}
