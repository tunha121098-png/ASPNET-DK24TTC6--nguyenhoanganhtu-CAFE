using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class QLDonHang : System.Web.UI.Page
    {
        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadGrid();
        }

        void LoadGrid()
        {
            string sql = @"SELECT o.*, u.FullName, t.TableName 
                          FROM Orders o 
                          JOIN Users u ON o.UserId = u.UserId 
                          LEFT JOIN Tables t ON o.TableId = t.TableId
                          ORDER BY o.OrderDate DESC";
            gvOrders.DataSource = kn.GetTable(sql);
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
                default: return "status-default";
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            string nextStatus = "";

            if (e.CommandName == "XacNhan") nextStatus = "Đã xác nhận";
            else if (e.CommandName == "HoanThanh") nextStatus = "Hoàn thành";
            else if (e.CommandName == "Huy") nextStatus = "Đã hủy";
            else if (e.CommandName == "XemChiTiet")
            {
                lblOrderId.Text = orderId.ToString();
                string sqlDet = $"SELECT d.*, p.ProductName, (d.Quantity * d.Price) as Total FROM OrderDetails d JOIN Products p ON d.ProductId = p.ProductId WHERE d.OrderId = {orderId}";
                gvDetails.DataSource = kn.GetTable(sqlDet);
                gvDetails.DataBind();
                pnlDetails.Visible = true;
            }

            if (nextStatus != "")
            {
                kn.Execute($"UPDATE Orders SET Status = N'{nextStatus}' WHERE OrderId = {orderId}");
                if (nextStatus == "Hoàn thành" || nextStatus == "Đã hủy")
                {
                    DataTable dt = kn.GetTable($"SELECT TableId FROM Orders WHERE OrderId = {orderId}");
                    if (dt.Rows.Count > 0 && dt.Rows[0]["TableId"] != DBNull.Value)
                        kn.Execute($"UPDATE Tables SET Status = N'Trống' WHERE TableId = {Convert.ToInt32(dt.Rows[0]["TableId"])}");
                }
                LoadGrid();
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;
        }
    }
}
