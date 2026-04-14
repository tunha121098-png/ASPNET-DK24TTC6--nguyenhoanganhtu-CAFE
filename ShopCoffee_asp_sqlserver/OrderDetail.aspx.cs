using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class OrderDetail : System.Web.UI.Page
    {
        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; }
            if (Request.QueryString["id"] == null) { Response.Redirect("UserProfile.aspx"); return; }
            if (!IsPostBack) LoadOrderDetail();
        }

        void LoadOrderDetail()
        {
            int orderId = Convert.ToInt32(Request.QueryString["id"]);
            int userId = Convert.ToInt32(Session["UserId"]);

            string sqlOrder = $@"SELECT o.*, u.FullName, t.TableName 
                                FROM Orders o 
                                JOIN Users u ON o.UserId = u.UserId 
                                LEFT JOIN Tables t ON o.TableId = t.TableId
                                WHERE o.OrderId = {orderId}";

            if (Session["Role"]?.ToString() != "Admin")
                sqlOrder += $" AND o.UserId = {userId}";

            DataTable dtOrder = kn.GetTable(sqlOrder);
            if (dtOrder.Rows.Count > 0)
            {
                DataRow row = dtOrder.Rows[0];
                lblOrderId.Text = orderId.ToString();
                lblDate.Text = Convert.ToDateTime(row["OrderDate"]).ToString("dd/MM/yyyy HH:mm");
                lblStatus.Text = row["Status"].ToString();
                lblStatus.CssClass = "status-badge " + GetStatusClass(row["Status"].ToString());
                lblCustomer.Text = row["FullName"].ToString();
                lblPhone.Text = row["Phone"] != DBNull.Value ? row["Phone"].ToString() : "N/A";
                lblTableName.Text = row["TableName"] != DBNull.Value ? row["TableName"].ToString() : "Tại quầy";
                lblTotal.Text = Convert.ToDecimal(row["TotalAmount"]).ToString("N0");

                string sqlDet = $"SELECT d.*, p.ProductName, p.ImageUrl FROM OrderDetails d JOIN Products p ON d.ProductId = p.ProductId WHERE d.OrderId = {orderId}";
                gvDetails.DataSource = kn.GetTable(sqlDet);
                gvDetails.DataBind();
            }
            else Response.Redirect("UserProfile.aspx");
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
    }
}
