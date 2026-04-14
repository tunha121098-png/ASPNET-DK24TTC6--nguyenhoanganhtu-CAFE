using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class UserProfile : System.Web.UI.Page
    {
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
                txtUsernameDisplay.Text = dt.Rows[0]["Username"].ToString();
                txtFullName.Text = dt.Rows[0]["FullName"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"]?.ToString() ?? "";
            }
            LoadOrders(userId);
        }

        void LoadOrders(int userId)
        {
            gvOrders.DataSource = kn.GetTable($"SELECT o.*, t.TableName FROM Orders o LEFT JOIN Tables t ON o.TableId = t.TableId WHERE o.UserId={userId} ORDER BY o.OrderDate DESC");
            gvOrders.DataBind();
        }

        protected string GetStatusClass(string status)
        {
            switch (status)
            {
                case "Chờ xác nhận": return "status-pending";
                case "Đã xác nhận": return "status-confirmed";
                case "Hoàn thành": return "status-completed";
                case "Đã hủy": return "status-cancelled";
                default: return "";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string fullName = txtFullName.Text.Trim().Replace("'", "''");
            string email = txtEmail.Text.Trim().Replace("'", "''");
            string pass = txtPassword.Text.Trim().Replace("'", "''");

            if (fullName == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Lỗi', 'Họ tên không được để trống!', 'error');", true);
                return;
            }

            string sql = $"UPDATE Users SET FullName=N'{fullName}', Email='{email}'";
            if (pass != "") sql += $", Password='{pass}'";
            sql += $" WHERE UserId={userId}";

            try
            {
                kn.Execute(sql);
                Session["FullName"] = fullName;
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Thành công!', 'Hồ sơ đã được cập nhật.', 'success');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"Swal.fire('Lỗi', '{ex.Message.Replace("'", "\"")}', 'error');", true);
            }
        }
    }
}
