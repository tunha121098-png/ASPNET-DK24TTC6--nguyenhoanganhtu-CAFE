using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class Profile : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox lblUsername;
        protected global::System.Web.UI.WebControls.TextBox txtFullName;
        protected global::System.Web.UI.WebControls.TextBox txtEmail;
        protected global::System.Web.UI.WebControls.TextBox txtPassword;
        protected global::System.Web.UI.WebControls.Button btnUpdate;
        protected global::System.Web.UI.WebControls.Label lblMsg;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        void LoadProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            DataTable dt = kn.GetTable($"SELECT * FROM Users WHERE UserId={userId}");
            if (dt.Rows.Count > 0)
            {
                lblUsername.Text = dt.Rows[0]["Username"].ToString();
                txtFullName.Text = dt.Rows[0]["FullName"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"]?.ToString() ?? "";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text.Trim();

            if (fullName == "")
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Họ tên không được để trống!";
                return;
            }

            string sql = $"UPDATE Users SET FullName=N'{fullName}', Email='{email}'";
            if (pass != "")
            {
                sql += $", Password='{pass}'";
            }
            sql += $" WHERE UserId={userId}";

            try
            {
                kn.Execute(sql);
                
                // Cập nhật lại Session nếu đổi tên
                Session["FullName"] = fullName;

                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Cập nhật hồ sơ thành công!";
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Có lỗi xảy ra: " + ex.Message;
            }
        }
    }
}
