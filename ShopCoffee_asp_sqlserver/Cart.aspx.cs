using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class Cart : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.GridView gvCart;
        protected global::System.Web.UI.WebControls.Label lblTotal;
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.Button btnBack;
        protected global::System.Web.UI.WebControls.Button btnOrder;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        void LoadCart()
        {
            if (Session["Cart"] != null)
            {
                DataTable dt = (DataTable)Session["Cart"];
                gvCart.DataSource = dt;
                gvCart.DataBind();

                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                {
                    total += Convert.ToDecimal(row["Total"]);
                }
                lblTotal.Text = total.ToString("N0");
            }
            else
            {
                lblTotal.Text = "0";
                gvCart.DataSource = null;
                gvCart.DataBind();
            }
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx?msg=Vui lòng đăng nhập để đặt món!");
                return;
            }

            if (Session["Cart"] == null || ((DataTable)Session["Cart"]).Rows.Count == 0)
            {
                lblMsg.Text = "Giỏ hàng của bạn đang trống!";
                return;
            }

            DataTable dtCart = (DataTable)Session["Cart"];
            int userId = Convert.ToInt32(Session["UserId"]);
            decimal total = Convert.ToDecimal(lblTotal.Text.Replace(",", ""));

            // 1. Tạo đơn hàng mới (Table Orders)
            string insertOrder = $"INSERT INTO Orders (UserId, TotalAmount, Status) OUTPUT INSERTED.OrderId VALUES ({userId}, {total}, N'Chờ xác nhận')";
            int orderId = Convert.ToInt32(kn.GetValue(insertOrder));

            // 2. Thêm chi tiết đơn hàng (Table OrderDetails)
            foreach (DataRow row in dtCart.Rows)
            {
                int pId = Convert.ToInt32(row["ProductId"]);
                int qty = Convert.ToInt32(row["Quantity"]);
                decimal price = Convert.ToDecimal(row["Price"]);
                string insertDetail = $"INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Price) VALUES ({orderId}, {pId}, {qty}, {price})";
                kn.Execute(insertDetail);
            }

            // Xóa giỏ hàng
            Session["Cart"] = null;
            lblMsg.Text = "Đặt món thành công! Mã đơn hàng: #" + orderId;
            LoadCart();
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveProduct")
            {
                int pId = Convert.ToInt32(e.CommandArgument);
                DataTable dt = (DataTable)Session["Cart"];
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    if (Convert.ToInt32(dt.Rows[i]["ProductId"]) == pId)
                    {
                        dt.Rows.RemoveAt(i);
                    }
                }
                Session["Cart"] = dt;
                LoadCart();
            }
        }
    }
}
