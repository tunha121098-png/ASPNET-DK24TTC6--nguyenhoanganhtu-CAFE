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
        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
                LoadTables();
            }
        }

        void LoadTables()
        {
            DataTable dt = kn.GetTable("SELECT * FROM Tables");
            rptTables.DataSource = dt;
            rptTables.DataBind();
        }

        protected void rptTables_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectTable")
            {
                ViewState["SelectedTableId"] = e.CommandArgument;
                hfSelectedTableId.Value = e.CommandArgument.ToString();
                LoadTables();
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
                    total += Convert.ToDecimal(row["Total"]);
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
                Response.Redirect("Login.aspx");
                return;
            }

            if (Session["Cart"] == null || ((DataTable)Session["Cart"]).Rows.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Giỏ hàng trống!', 'Vui lòng chọn món trước khi đặt hàng.', 'warning');", true);
                return;
            }

            string phone = txtPhone.Text.Trim().Replace("'", "''");
            string tableId = hfSelectedTableId.Value;

            if (phone == "" || tableId == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Thiếu thông tin!', 'Vui lòng nhập số điện thoại và chọn vị trí bàn.', 'error');", true);
                return;
            }

            DataTable dtCart = (DataTable)Session["Cart"];
            int userId = Convert.ToInt32(Session["UserId"]);
            decimal total = 0;
            foreach (DataRow row in dtCart.Rows) total += Convert.ToDecimal(row["Total"]);
            string sqlTotal = total.ToString(System.Globalization.CultureInfo.InvariantCulture);

            try
            {
                string insertOrder = $"INSERT INTO Orders (UserId, TotalAmount, Status, Phone, TableId) OUTPUT INSERTED.OrderId VALUES ({userId}, {sqlTotal}, N'Chờ xác nhận', '{phone}', {tableId})";
                int orderId = Convert.ToInt32(kn.GetValue(insertOrder));

                kn.Execute($"UPDATE Tables SET Status = N'Đang có khách' WHERE TableId = {tableId}");

                foreach (DataRow row in dtCart.Rows)
                {
                    int pId = Convert.ToInt32(row["ProductId"]);
                    int qty = Convert.ToInt32(row["Quantity"]);
                    decimal price = Convert.ToDecimal(row["Price"]);
                    kn.Execute($"INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Price) VALUES ({orderId}, {pId}, {qty}, {price.ToString(System.Globalization.CultureInfo.InvariantCulture)})");
                }

                Session["Cart"] = null;
                txtPhone.Text = "";
                hfSelectedTableId.Value = "";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"showOrderSuccess({orderId});", true);
                LoadCart();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"Swal.fire('Lỗi', '{ex.Message.Replace("'", "\"")}', 'error');", true);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Session["Cart"] = null;
            LoadCart();
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            DataTable dt = (DataTable)Session["Cart"];
            int pId = Convert.ToInt32(e.CommandArgument);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (Convert.ToInt32(dt.Rows[i]["ProductId"]) == pId)
                {
                    if (e.CommandName == "RemoveProduct") dt.Rows.RemoveAt(i);
                    else if (e.CommandName == "Increase")
                    {
                        dt.Rows[i]["Quantity"] = Convert.ToInt32(dt.Rows[i]["Quantity"]) + 1;
                        dt.Rows[i]["Total"] = Convert.ToInt32(dt.Rows[i]["Quantity"]) * Convert.ToDecimal(dt.Rows[i]["Price"]);
                    }
                    else if (e.CommandName == "Decrease")
                    {
                        int currentQty = Convert.ToInt32(dt.Rows[i]["Quantity"]);
                        if (currentQty > 1)
                        {
                            dt.Rows[i]["Quantity"] = currentQty - 1;
                            dt.Rows[i]["Total"] = (currentQty - 1) * Convert.ToDecimal(dt.Rows[i]["Price"]);
                        }
                        else dt.Rows.RemoveAt(i);
                    }
                    break;
                }
            }
            Session["Cart"] = dt;
            LoadCart();
        }
    }
}
