using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class DatBan : System.Web.UI.Page
    {
        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTables();
            }
        }

        void LoadTables()
        {
            DataTable dt = kn.GetTable("SELECT * FROM Tables");
            rptTables.DataSource = dt;
            rptTables.DataBind();

            DataTable dtFree = kn.GetTable("SELECT * FROM Tables WHERE Status = N'Trống'");
            ddlTables.DataSource = dtFree;
            ddlTables.DataTextField = "TableName";
            ddlTables.DataValueField = "TableId";
            ddlTables.DataBind();
            ddlTables.Items.Insert(0, new ListItem("-- Chọn bàn --", "0"));
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string tableId = ddlTables.SelectedValue;
            string bookingTime = txtBookingTime.Text;
            int userId = Convert.ToInt32(Session["UserId"]);

            if (tableId == "0" || string.IsNullOrEmpty(bookingTime))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Vui lòng chọn bàn và thời gian!";
                return;
            }

            string sql = $"INSERT INTO Bookings (UserId, TableId, BookingTime, Status) VALUES ({userId}, {tableId}, '{bookingTime}', N'Chờ duyệt')";
            try
            {
                kn.Execute(sql);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Gửi yêu cầu đặt bàn thành công! Vui lòng chờ Admin xác nhận.";
                LoadTables();
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Lỗi: " + ex.Message;
            }
        }
    }
}
