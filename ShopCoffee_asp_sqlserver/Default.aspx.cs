using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver
{
    public partial class Default : System.Web.UI.Page
    {
        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        void LoadCategories()
        {
            DataTable dt = kn.GetTable("SELECT * FROM Categories");
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryId";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("Tất cả danh mục", "0"));
        }

        void LoadProducts(string categoryId = "0", string search = "")
        {
            string sql = "SELECT * FROM Products WHERE IsAvailable = 1";
            if (categoryId != "0") sql += $" AND CategoryId = {categoryId}";
            if (search != "") sql += $" AND ProductName LIKE N'%{search}%'";

            rptProducts.DataSource = kn.GetTable(sql);
            rptProducts.DataBind();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProducts(ddlCategory.SelectedValue, txtSearch.Text.Trim());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadProducts(ddlCategory.SelectedValue, txtSearch.Text.Trim());
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                AddToCart(productId);
            }
        }

        void AddToCart(int productId)
        {
            DataTable dtCart;
            if (Session["Cart"] == null)
            {
                dtCart = new DataTable();
                dtCart.Columns.Add("ProductId", typeof(int));
                dtCart.Columns.Add("ProductName", typeof(string));
                dtCart.Columns.Add("Price", typeof(decimal));
                dtCart.Columns.Add("Quantity", typeof(int));
                dtCart.Columns.Add("Total", typeof(decimal));
                dtCart.Columns.Add("ImageUrl", typeof(string));
            }
            else
            {
                dtCart = (DataTable)Session["Cart"];
            }

            bool exists = false;
            foreach (DataRow row in dtCart.Rows)
            {
                if (Convert.ToInt32(row["ProductId"]) == productId)
                {
                    row["Quantity"] = Convert.ToInt32(row["Quantity"]) + 1;
                    row["Total"] = Convert.ToDecimal(row["Quantity"]) * Convert.ToDecimal(row["Price"]);
                    exists = true;
                    break;
                }
            }

            if (!exists)
            {
                DataTable dtProd = kn.GetTable($"SELECT ProductId, ProductName, Price, ImageUrl FROM Products WHERE ProductId={productId}");
                if (dtProd.Rows.Count > 0)
                {
                    DataRow newRow = dtCart.NewRow();
                    newRow["ProductId"] = dtProd.Rows[0]["ProductId"];
                    newRow["ProductName"] = dtProd.Rows[0]["ProductName"];
                    newRow["Price"] = dtProd.Rows[0]["Price"];
                    newRow["Quantity"] = 1;
                    newRow["Total"] = dtProd.Rows[0]["Price"];
                    newRow["ImageUrl"] = dtProd.Rows[0]["ImageUrl"];
                    dtCart.Rows.Add(newRow);
                }
            }

            Session["Cart"] = dtCart;
            string script = "Swal.fire({ icon: 'success', title: 'Đã thêm vào giỏ!', text: 'Sản phẩm đã có trong giỏ hàng của bạn.', showConfirmButton: false, timer: 1500, toast: true, position: 'top-end' });";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
    }
}
