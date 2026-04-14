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
            try
            {
                SqlDataAdapter ad = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                ad.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi truy vấn dữ liệu: " + ex.Message);
            }
        }

        // Thực thi lệnh (INSERT, UPDATE, DELETE)
        public void Execute(string sql)
        {
            SqlConnection con = GetConnection();
            SqlCommand cmd = new SqlCommand(sql, con);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi thực thi SQL: " + ex.Message + " [Query: " + sql + "]");
            }
            finally
            {
                if (con.State == ConnectionState.Open) con.Close();
            }
        }

        // Lấy giá trị đơn lẻ (Scalar)
        public object GetValue(string sql)
        {
            SqlConnection con = GetConnection();
            SqlCommand cmd = new SqlCommand(sql, con);
            try
            {
                con.Open();
                object value = cmd.ExecuteScalar();
                return value;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi lấy giá trị: " + ex.Message);
            }
            finally
            {
                if (con.State == ConnectionState.Open) con.Close();
            }
        }
    }
}
