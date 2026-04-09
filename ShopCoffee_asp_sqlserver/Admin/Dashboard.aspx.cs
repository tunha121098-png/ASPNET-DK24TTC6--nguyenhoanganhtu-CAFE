using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.Label lblTotalRevenue;
        protected global::System.Web.UI.WebControls.Label lblOrderCount;
        protected global::System.Web.UI.WebControls.Label lblFreeTables;
        protected global::System.Web.UI.WebControls.Label lblUserCount;
        protected global::System.Web.UI.WebControls.GridView gvBestSellers;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
            }
        }

        void LoadStats()
        {
            // Doanh thu (Đơn hàng đã hoàn thành hoặc đã xác nhận)
            object rev = kn.GetValue("SELECT SUM(TotalAmount) FROM Orders WHERE Status != N'Đã hủy'");
            lblTotalRevenue.Text = rev == DBNull.Value || rev == null ? "0" : Convert.ToDecimal(rev).ToString("N0");

            // Số đơn hàng
            lblOrderCount.Text = kn.GetValue("SELECT COUNT(*) FROM Orders").ToString();

            // Số bàn trống
            lblFreeTables.Text = kn.GetValue("SELECT COUNT(*) FROM Tables WHERE Status = N'Trống'").ToString();

            // Số người dùng
            lblUserCount.Text = kn.GetValue("SELECT COUNT(*) FROM Users WHERE Role='User'").ToString();

            // Món bán chạy
            string sqlBest = @"SELECT TOP 5 p.ProductName, c.CategoryName, SUM(od.Quantity) as TotalSold 
                               FROM OrderDetails od 
                               JOIN Products p ON od.ProductId = p.ProductId 
                               JOIN Categories c ON p.CategoryId = c.CategoryId
                               GROUP BY p.ProductName, c.CategoryName
                               ORDER BY TotalSold DESC";
            gvBestSellers.DataSource = kn.GetTable(sqlBest);
            gvBestSellers.DataBind();
        }
    }
}
