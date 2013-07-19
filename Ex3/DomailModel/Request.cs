using System;
using System.Data;
using System.Data.SqlClient;

namespace DomainModel
{
    public abstract class Request
    {
        public String tableName;
        public Tuple<String, Object>[] args;
        public String cmd;

        public Request(String table, String cmd, Tuple<String, Object>[] args)
        {
            this.tableName = table;
            this.cmd = cmd;
            this.args = args;
        }

        public abstract void perform(DataSet set);
    }

    public class AddRequest : Request
    {
        public AddRequest(String table, String cmd, Tuple<String, Object>[] args) : base(table,cmd,args) { }

        public override void perform(DataSet set)
        {
            DataRow newRow = set.Tables[tableName].NewRow();
            for (int idx = 0; idx < args.Length; idx++)
                newRow[args[idx].Item1] = args[idx].Item2;
            set.Tables[tableName].Rows.Add(newRow);
        }
    }

    public class EditRequest : Request
    {
        public EditRequest(String table, String cmd, Tuple<String, Object>[] args) : base(table, cmd, args) { }

        public override void perform(DataSet set)
        {
            if (!args[0].Item1.Equals("id"))
                throw new ArgumentException("First argument of edit operation must be the ID.");
            Int32 id = (Int32)args[0].Item2;
            DataRow editRow = set.Tables[tableName].Rows[id];
            for (int idx = 0; idx < args.Length; idx++)
                editRow[idx] = args[idx];
        }
    }

    public class GetRequest : Request
    {
        public GetRequest(String table, String cmd, Tuple<String, Object>[] args) : base(table, cmd, args) { }

        public override void perform(DataSet set) { }
    }

    public class RemoveRequest : Request
    {
        public RemoveRequest(String table, String cmd, Tuple<String, Object>[] args) : base(table, cmd, args) { }

        public override void perform(DataSet set)
        {
            if (!args[0].Item1.Equals("id"))
                throw new ArgumentException("First argument of remove operation must be the ID.");
            Int32 id = (Int32)args[0].Item2;
            set.Tables[tableName].Rows[id].Delete();
            
            set.AcceptChanges();
        }
    }
}
