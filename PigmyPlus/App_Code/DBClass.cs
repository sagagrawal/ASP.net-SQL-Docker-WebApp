using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PigmyPlus
{
    public class DBClass
    {
        private static SqlConnection cn;

        public static String ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            }
        }

        public static SqlConnection Connection
        {
            get
            {
                if (cn == null)
                    cn = new SqlConnection(ConnectionString);

                if (cn.State == ConnectionState.Closed)
                    cn.Open();

                return cn;
            }
        }

        public static void CloseConnection()
        {
            if (cn.State == ConnectionState.Open)
                cn.Close();
        }

        public static DataSet getDataSet(string Sql, string TableName, CommandType commandType = CommandType.Text, params SqlParameter[] Parameters)
        {
            SqlDataAdapter Da = new SqlDataAdapter(Sql, ConnectionString);
            DataSet Ds = new DataSet();
            Da.SelectCommand.CommandType = commandType;

            foreach (SqlParameter param in Parameters)
                Da.SelectCommand.Parameters.Add(param);

            Da.Fill(Ds, TableName);
            return Ds;
        }

        public static DataTable getDataTable(string Sql, string TableName, CommandType commandType = CommandType.Text, params SqlParameter[] Parameters)
        {
            return getDataSet(Sql, TableName, commandType, Parameters).Tables[0];
        }

        public static SqlCommand getCommand(string Sql, CommandType commandType = CommandType.Text, params SqlParameter[] SqlParameters)
        {
            SqlCommand cmd = new SqlCommand(Sql, Connection);
            cmd.CommandType = commandType;

            foreach (SqlParameter param in SqlParameters)
                cmd.Parameters.Add(param);

            return cmd;
        }

        public static SqlDataReader Reader(string Sql, CommandType commandType = CommandType.Text, params SqlParameter[] SqlParameters)
        {
            return getCommand(Sql, commandType, SqlParameters).ExecuteReader();
        }

        public static object Scalar(string Sql, CommandType commandType = CommandType.Text, params SqlParameter[] SqlParameters)
        {
            return getCommand(Sql, commandType, SqlParameters).ExecuteScalar();
        }

        public static int NonQuery(string Sql, CommandType commandType = CommandType.Text, params SqlParameter[] SqlParameters)
        {
            return getCommand(Sql, commandType, SqlParameters).ExecuteNonQuery();
        }
    }
}