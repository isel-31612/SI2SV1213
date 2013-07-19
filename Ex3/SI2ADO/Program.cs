using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Data;

namespace SI2ADO
{
    public class Program
    {
        private string conString = "Provider=SQLNCLI11;Data Source=EEEPC;Integrated Security=SSPI;Initial Catalog=AulasSI2";
        
        public static void Main(string[] args)
        {
            var p = new Program();
            var con = p.connect();

            //p.Sincroniously(con);
            p.Assincroniously(con);

            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
        
        private void Sincroniously(OleDbConnection con)
        {
            try
            {
                var reader = executeCommand(con);
                printResult(reader);
            }
            finally
            {
                if (con.State != System.Data.ConnectionState.Closed)
                    con.Close();
            }
        }

        private void Assincroniously(OleDbConnection con)
        {
            var dataset = executeCommandForOffline(con);
            printOffline(dataset);
            changeOfflineDB(dataset,con);
            printOffline(dataset);
        }

        private OleDbConnection connect()
        {
            OleDbConnection con = new OleDbConnection(conString);
            con.Open();
            return con;
        }

        private OleDbDataReader executeCommand(OleDbConnection con)
        {
            OleDbCommand cmd = con.CreateCommand();
            cmd.CommandText = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=?";
            OleDbParameter parameter = cmd.CreateParameter();
            parameter.ParameterName = "schema";
            parameter.Value = "dbo";
            parameter.DbType = DbType.String;
            parameter.OleDbType = OleDbType.VarChar;
            cmd.Parameters.Add(parameter);
            OleDbDataReader reader = cmd.ExecuteReader();
            return reader;
        }

        private void printResult(OleDbDataReader reader)
        {
            while (reader.Read())
            {
                Console.WriteLine(reader[0].ToString());
            }
        }

        private DataSet executeCommandForOffline(OleDbConnection con)
        {
            string cmd = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES";
            OleDbDataAdapter adapter = new OleDbDataAdapter(cmd, con);
            DataSet dataset = new DataSet("Tables");
            adapter.Fill(dataset);
            con.Close();
            return dataset;
        }

        private void printOffline(DataSet dataset)
        {
            using (DataTableReader reader = dataset.CreateDataReader())
            {
                while (reader.Read())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        Console.Write(reader[i] + " ");
                    }
                }
            }
        }

        private void changeOfflineDB(DataSet dataset, OleDbConnection con)
        {
            throw new NotImplementedException();
            string NewTable = "Xpto";
            string str = "INSERT INTO Table VALUES(" + NewTable + ")";
            OleDbDataAdapter tmpadapter = new OleDbDataAdapter(str, con);
        }

        private void propagate()
        {

        }
    }
}
