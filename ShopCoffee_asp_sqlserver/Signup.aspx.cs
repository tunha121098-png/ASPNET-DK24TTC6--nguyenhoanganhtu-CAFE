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
        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (fullName == "" || user == "" || pass == "" || email == "")
            {
                lblMessage.Text = "Vui lòng nhập đầy đủ thông tin!";
                return;
            }

            DataTable dt = kn.GetTable($"SELECT * FROM Users WHERE Username = '{user}'");
            if (dt.Rows.Count > 0) { lblMessage.Text = "Tên đăng nhập đã tồn tại!"; return; }

            try
            {
                kn.Execute($"INSERT INTO Users (Username, Password, FullName, Email, Role) VALUES ('{user}', '{pass}', N'{fullName}', '{email}', 'User')");
                Response.Redirect("Login.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
            }
        }
    }
}
