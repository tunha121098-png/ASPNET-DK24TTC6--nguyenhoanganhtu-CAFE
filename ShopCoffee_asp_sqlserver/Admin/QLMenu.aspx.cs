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
        protected global::System.Web.UI.WebControls.Button btnAdd;
        protected global::System.Web.UI.WebControls.Button btnUpdate;
        protected global::System.Web.UI.WebControls.Button btnCancel;
        protected global::System.Web.UI.WebControls.Label lblMsg;
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
            string name = txtProductName.Text.Trim();
            string price = txtPrice.Text.Trim();
            string desc = txtDesc.Text.Trim();
            string catId = ddlCategory.SelectedValue;

            if (name == "" || price == "") { lblMsg.Text = "Tên và giá là bắt buộc!"; return; }

            string sql = $"INSERT INTO Products (ProductName, Price, Description, CategoryId) VALUES (N'{name}', {price}, N'{desc}', {catId})";
            kn.Execute(sql);
            lblMsg.Text = "Đã thêm món mới!";
            ClearForm();
            LoadGrid();
        }

        void ClearForm()
        {
            txtProductName.Text = "";
            txtPrice.Text = "";
            txtDesc.Text = "";
            ViewState["EditId"] = null;
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
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
                    txtPrice.Text = dt.Rows[0]["Price"].ToString();
                    txtDesc.Text = dt.Rows[0]["Description"].ToString();
                    ddlCategory.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                    ViewState["EditId"] = id;
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                    btnCancel.Visible = true;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int id = (int)ViewState["EditId"];
            string name = txtProductName.Text.Trim();
            string price = txtPrice.Text.Trim();
            string desc = txtDesc.Text.Trim();
            string catId = ddlCategory.SelectedValue;

            string sql = $"UPDATE Products SET ProductName=N'{name}', Price={price}, Description=N'{desc}', CategoryId={catId} WHERE ProductId={id}";
            kn.Execute(sql);
            lblMsg.Text = "Đã cập nhật món!";
            ClearForm();
            LoadGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }
    }
}
