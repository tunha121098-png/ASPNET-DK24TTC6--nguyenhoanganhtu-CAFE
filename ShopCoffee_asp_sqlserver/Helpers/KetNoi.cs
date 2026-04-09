using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ShopCoffee_asp_sqlserver
{
    public class KetNoi
    {
        string strCon = ConfigurationManager.ConnectionStrings["CoffeeDB"].ConnectionString;

        public SqlConnection GetConnection()
        {
            return new SqlConnection(strCon);
        }

        // Lấy dữ liệu (SELECT)
        public DataTable GetTable(string sql)
        {
            SqlConnection con = GetConnection();
            SqlDataAdapter ad = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            ad.Fill(dt);
            return dt;
        }

        // Thực thi lệnh (INSERT, UPDATE, DELETE)
        public void Execute(string sql)
        {
            SqlConnection con = GetConnection();
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        // Lấy giá trị đơn lẻ (Scalar)
        public object GetValue(string sql)
        {
            SqlConnection con = GetConnection();
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            object value = cmd.ExecuteScalar();
            con.Close();
            return value;
        }
    }
}
