using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class QLDatBan : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.GridView gvBookings;
        protected global::System.Web.UI.WebControls.Label lblMsg;

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
            string sql = @"SELECT b.*, u.FullName, t.TableName 
                           FROM Bookings b 
                           JOIN Users u ON b.UserId = u.UserId 
                           JOIN Tables t ON b.TableId = t.TableId 
                           ORDER BY b.BookingTime ASC";
            gvBookings.DataSource = kn.GetTable(sql);
            gvBookings.DataBind();
        }

        protected string GetBookingClass(string status)
        {
            switch (status)
            {
                case "Chờ duyệt": return "status-pending";
                case "Đã duyệt": return "status-confirmed";
                case "Đã hủy": return "status-cancelled";
                default: return "status-default";
            }
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Duyet")
            {
                kn.Execute($"UPDATE Bookings SET Status = N'Đã duyệt' WHERE BookingId = {id}");
                lblMsg.Text = "Đã duyệt yêu cầu đặt bàn!";
                LoadGrid();
            }
            else if (e.CommandName == "Huy")
            {
                kn.Execute($"UPDATE Bookings SET Status = N'Đã hủy' WHERE BookingId = {id}");
                lblMsg.Text = "Đã hủy yêu cầu đặt bàn!";
                LoadGrid();
            }
            else if (e.CommandName == "Xoa")
            {
                kn.Execute($"DELETE FROM Bookings WHERE BookingId = {id}");
                LoadGrid();
            }
        }
    }
}
