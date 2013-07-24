using DomainModel;
using System;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

namespace AccessModel
{
    public class DBManager
    {
        private SqlConnection con=null;
        private DataSet repo;
        private static DBManager SINGLETON;

        private DBManager(DbInfo info)
        {
            prepare(info);
            repo = new DataSet();
            SINGLETON = null;
        }

        public static DBManager getSingleton()
        {
            if(SINGLETON == null)
                SINGLETON = new DBManager(new TestInfo());
            return SINGLETON;
        }

        public DataSet execute(Request r)
        {
            if (!repo.Tables.Contains(r.tableName))
            {
                r.cmd = "SELECT TOP 1 * FROM " + r.tableName; //This will bring the 1st row from the table. Usefull for avoiding to create the table staticly
                query(r);
            }
            r.perform(repo);
            return repo;
        }

        public DataSet query(Request r)
        {
            string cmd = r.cmd;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd, con);
            DataSet set = new DataSet();
            adapter.Fill(set);
            con.Close();
            set.Tables[0].TableName = r.tableName; //TODO doesnt seem very flexible...
            repo.Merge(set);
            return repo;
        }

        public void prepare(DbInfo info)
        {
            if (con != null)
            {
                con.Close();
                con = null;
            }
            con = new SqlConnection(info.getConnectionString());
            con.Open();
        }

        public void Close()
        {
            repo.AcceptChanges();
            SqlDataAdapter adapter = new SqlDataAdapter(null, con);
            foreach (DataTable dt in repo.Tables)
                adapter.Update(dt);
            //TODO DataBase is not updated with these changes, must look into it
        }
    }

}
