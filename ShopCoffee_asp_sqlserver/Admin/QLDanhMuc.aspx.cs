using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class QLDanhMuc : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox txtCategoryName;
        protected global::System.Web.UI.WebControls.Button btnAdd;
        protected global::System.Web.UI.WebControls.Button btnUpdate;
        protected global::System.Web.UI.WebControls.Button btnCancel;
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.GridView gvCategories;

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
            gvCategories.DataSource = kn.GetTable("SELECT * FROM Categories");
            gvCategories.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string name = txtCategoryName.Text.Trim();
            if (name == "") return;

            string sql = $"INSERT INTO Categories (CategoryName) VALUES (N'{name}')";
            kn.Execute(sql);
            lblMsg.Text = "Đã thêm danh mục mới!";
            txtCategoryName.Text = "";
            LoadGrid();
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Xoa")
            {
                // Kiểm tra xem có sản phẩm nào thuộc danh mục này không
                object count = kn.GetValue($"SELECT COUNT(*) FROM Products WHERE CategoryId={id}");
                if (Convert.ToInt32(count) > 0)
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Không thể xóa danh mục đang có sản phẩm!";
                    return;
                }

                kn.Execute($"DELETE FROM Categories WHERE CategoryId={id}");
                LoadGrid();
            }
            else if (e.CommandName == "Sua")
            {
                DataTable dt = kn.GetTable($"SELECT * FROM Categories WHERE CategoryId={id}");
                if (dt.Rows.Count > 0)
                {
                    txtCategoryName.Text = dt.Rows[0]["CategoryName"].ToString();
                    ViewState["EditCatId"] = id;
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                    btnCancel.Visible = true;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int id = (int)ViewState["EditCatId"];
            string name = txtCategoryName.Text.Trim();
            kn.Execute($"UPDATE Categories SET CategoryName=N'{name}' WHERE CategoryId={id}");
            lblMsg.Text = "Đã cập nhật danh mục!";
            ResetForm();
            LoadGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        void ResetForm()
        {
            txtCategoryName.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            ViewState["EditCatId"] = null;
        }
    }
}
