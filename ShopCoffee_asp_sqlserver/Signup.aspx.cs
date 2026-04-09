using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class Signup : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox txtFullName;
        protected global::System.Web.UI.WebControls.TextBox txtUsername;
        protected global::System.Web.UI.WebControls.TextBox txtPassword;
        protected global::System.Web.UI.WebControls.TextBox txtEmail;
        protected global::System.Web.UI.WebControls.Button btnSignup;
        protected global::System.Web.UI.WebControls.Label lblMessage;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (fullName == "" || user == "" || pass == "" || email == "")
            {
                lblMessage.Text = "Tất cả các trường là bắt buộc!";
                return;
            }

            // Kiểm tra username trùng lặp
            string checkSql = $"SELECT * FROM Users WHERE Username = '{user}'";
            DataTable dt = kn.GetTable(checkSql);
            if (dt.Rows.Count > 0)
            {
                lblMessage.Text = "Tên đăng nhập đã tồn tại!";
                return;
            }

            // Lưu người dùng mới
            string insertSql = $"INSERT INTO Users (Username, Password, FullName, Email, Role) VALUES ('{user}', '{pass}', N'{fullName}', '{email}', 'User')";
            try
            {
                kn.Execute(insertSql);
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Đăng ký thành công! Đang chuyển hướng...";
                
                // Trì hoãn chuyển hướng
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}
