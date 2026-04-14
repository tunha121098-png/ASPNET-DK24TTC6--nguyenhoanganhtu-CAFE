using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class QLMenu : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox txtProductName;
        protected global::System.Web.UI.WebControls.DropDownList ddlCategory;
        protected global::System.Web.UI.WebControls.TextBox txtPrice;
        protected global::System.Web.UI.WebControls.TextBox txtDesc;
        protected global::System.Web.UI.WebControls.TextBox txtImageUrl;
        protected global::System.Web.UI.WebControls.Button btnAdd;
        protected global::System.Web.UI.WebControls.Button btnUpdate;
        protected global::System.Web.UI.WebControls.Button btnCancel;
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.Image imgPreview;
        protected global::System.Web.UI.WebControls.GridView gvMenu;

        KetNoi kn = new KetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadGrid();
            }
        }

        void LoadCategories()
        {
            ddlCategory.DataSource = kn.GetTable("SELECT * FROM Categories");
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryId";
            ddlCategory.DataBind();
        }

        void LoadGrid()
        {
            gvMenu.DataSource = kn.GetTable("SELECT p.*, c.CategoryName FROM Products p JOIN Categories c ON p.CategoryId = c.CategoryId");
            gvMenu.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtProductName.Text.Trim().Replace("'", "''");
                string price = txtPrice.Text.Trim();
                string desc = txtDesc.Text.Trim().Replace("'", "''");
                string catId = ddlCategory.SelectedValue;
                string imageUrl = txtImageUrl.Text.Trim().Replace("'", "''");

                if (name == "" || price == "") { lblMsg.ForeColor = System.Drawing.Color.Red; lblMsg.Text = "Tên và giá là bắt buộc!"; return; }

                // Standardize price for SQL (No dots/commas, invariant culture)
                decimal priceVal = 0;
                decimal.TryParse(price.Replace(",", "").Replace(".", ""), out priceVal);
                string sqlPrice = priceVal.ToString(System.Globalization.CultureInfo.InvariantCulture);

                string sql = $"INSERT INTO Products (ProductName, Price, Description, CategoryId, ImageUrl) VALUES (N'{name}', {sqlPrice}, N'{desc}', {catId}, N'{imageUrl}')";
                kn.Execute(sql);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Đã thêm món mới!";
                ClearForm();
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Lỗi khi thêm món: " + ex.Message;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        void ClearForm()
        {
            txtProductName.Text = "";
            txtPrice.Text = "";
            txtDesc.Text = "";
            txtImageUrl.Text = "";
            imgPreview.ImageUrl = "https://placehold.co/80x80?text=No+Image";
            ViewState["EditId"] = null;
            ViewState["OldImageUrl"] = null;
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            lblMsg.Text = "";
        }

        protected void gvMenu_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Xoa")
            {
                kn.Execute($"DELETE FROM Products WHERE ProductId={id}");
                LoadGrid();
            }
            else if (e.CommandName == "Sua")
            {
                DataTable dt = kn.GetTable($"SELECT * FROM Products WHERE ProductId={id}");
                if (dt.Rows.Count > 0)
                {
                    txtProductName.Text = dt.Rows[0]["ProductName"].ToString();

                    // Format price as integer for Vietnamese currency
                    decimal priceVal = Convert.ToDecimal(dt.Rows[0]["Price"]);
                    txtPrice.Text = ((long)priceVal).ToString();

                    txtDesc.Text = dt.Rows[0]["Description"].ToString();
                    ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();

                    string imageUrl = dt.Rows[0]["ImageUrl"]?.ToString() ?? "";
                    txtImageUrl.Text = imageUrl;
                    ViewState["OldImageUrl"] = imageUrl;

                    // Update Preview
                    if (string.IsNullOrEmpty(imageUrl))
                    {
                        imgPreview.ImageUrl = "https://placehold.co/80x80?text=No+Image";
                    }
                    else if (imageUrl.StartsWith("http"))
                    {
                        imgPreview.ImageUrl = imageUrl;
                    }
                    else
                    {
                        // Handle local path: check if it already contains "Content/"
                        if (imageUrl.Contains("/"))
                            imgPreview.ImageUrl = "~/" + imageUrl;
                        else
                            imgPreview.ImageUrl = "~/Content/Images/" + imageUrl;
                    }

                    ViewState["EditId"] = id;
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                    btnCancel.Visible = true;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["EditId"] == null) return;
                int id = (int)ViewState["EditId"];
                string name = txtProductName.Text.Trim().Replace("'", "''");
                string price = txtPrice.Text.Trim();
                string desc = txtDesc.Text.Trim().Replace("'", "''");
                string catId = ddlCategory.SelectedValue;

                // Use new URL if provided, otherwise keep old
                string imageUrl = txtImageUrl.Text.Trim().Replace("'", "''");
                if (string.IsNullOrEmpty(imageUrl))
                {
                    imageUrl = ViewState["OldImageUrl"]?.ToString() ?? "";
                }

                // Standardize price for SQL (No dots/commas, invariant culture)
                decimal priceVal = 0;
                decimal.TryParse(price.Replace(",", "").Replace(".", ""), out priceVal);
                string sqlPrice = priceVal.ToString(System.Globalization.CultureInfo.InvariantCulture);

                string sql = $"UPDATE Products SET ProductName=N'{name}', Price={sqlPrice}, Description=N'{desc}', CategoryId={catId}, ImageUrl=N'{imageUrl}' WHERE ProductId={id}";
                kn.Execute(sql);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Đã cập nhật món!";
                ClearForm();
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Lỗi khi cập nhật: " + ex.Message;
            }
        }
    }
}
