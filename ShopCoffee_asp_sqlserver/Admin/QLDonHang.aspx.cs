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
        protected global::System.Web.UI.WebControls.GridView gvOrders;
        protected global::System.Web.UI.WebControls.Label lblOrderId;
        protected global::System.Web.UI.WebControls.GridView gvDetails;
        protected global::System.Web.UI.WebControls.Panel pnlDetails;
        protected global::System.Web.UI.WebControls.Button btnCloseDetails;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGrid();
            }
        }

        void LoadGrid()
        {
            string sql = "SELECT o.*, u.FullName FROM Orders o JOIN Users u ON o.UserId = u.UserId ORDER BY o.OrderDate DESC";
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
                string sqlDet = $@"SELECT d.*, p.ProductName, (d.Quantity * d.Price) as Total 
                                   FROM OrderDetails d 
                                   JOIN Products p ON d.ProductId = p.ProductId 
                                   WHERE d.OrderId = {orderId}";
                gvDetails.DataSource = kn.GetTable(sqlDet);
                gvDetails.DataBind();
                pnlDetails.Visible = true;
            }

            if (nextStatus != "")
            {
                kn.Execute($"UPDATE Orders SET Status = N'{nextStatus}' WHERE OrderId = {orderId}");
                LoadGrid();
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;
        }
    }
}
