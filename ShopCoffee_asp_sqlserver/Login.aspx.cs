using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class Login : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox txtUsername;
        protected global::System.Web.UI.WebControls.TextBox txtPassword;
        protected global::System.Web.UI.WebControls.Button btnLogin;
        protected global::System.Web.UI.WebControls.Label lblMessage;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();

            if (user == "" || pass == "")
            {
                lblMessage.Text = "Vui lòng nhập đầy đủ thông tin!";
                return;
            }

            // Truy vấn kiểm tra đăng nhập
            string sql = $"SELECT * FROM Users WHERE Username = '{user}' AND Password = '{pass}'";
            DataTable dt = kn.GetTable(sql);

            if (dt.Rows.Count > 0)
            {
                // Lưu session
                Session["UserId"] = dt.Rows[0]["UserId"];
                Session["Username"] = dt.Rows[0]["Username"];
                Session["FullName"] = dt.Rows[0]["FullName"];
                Session["Role"] = dt.Rows[0]["Role"];

                // Điều hướng dựa trên quyền
                if (dt.Rows[0]["Role"].ToString() == "Admin")
                {
                    Response.Redirect("Admin/Dashboard.aspx");
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                lblMessage.Text = "Sai tài khoản hoặc mật khẩu!";
            }
        }
    }
}
