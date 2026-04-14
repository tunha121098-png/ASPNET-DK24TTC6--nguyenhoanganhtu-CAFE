using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class QLBan : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox txtTableName;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl hFormTitle;
        protected global::System.Web.UI.WebControls.Button btnAddTable;
        protected global::System.Web.UI.WebControls.Button btnUpdateTable;
        protected global::System.Web.UI.WebControls.Button btnCancelEdit;
        protected global::System.Web.UI.WebControls.GridView gvTables;

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
            gvTables.DataSource = kn.GetTable("SELECT * FROM Tables");
            gvTables.DataBind();
        }

        protected void btnAddTable_Click(object sender, EventArgs e)
        {
            string name = txtTableName.Text.Trim();
            if (name == "") return;

            string sql = $"INSERT INTO Tables (TableName, Status) VALUES (N'{name}', N'Trống')";
            kn.Execute(sql);
            ResetForm();
            LoadGrid();
        }

        protected void btnUpdateTable_Click(object sender, EventArgs e)
        {
            if (ViewState["EditTableId"] == null) return;
            int id = (int)ViewState["EditTableId"];
            string name = txtTableName.Text.Trim();
            if (name == "") return;

            kn.Execute($"UPDATE Tables SET TableName=N'{name}' WHERE TableId={id}");
            ResetForm();
            LoadGrid();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        void ResetForm()
        {
            txtTableName.Text = "";
            hFormTitle.InnerText = "Thêm bàn mới";
            btnAddTable.Visible = true;
            btnUpdateTable.Visible = false;
            btnCancelEdit.Visible = false;
            ViewState["EditTableId"] = null;
        }

        protected void gvTables_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "XoaTable")
            {
                kn.Execute($"DELETE FROM Tables WHERE TableId={id}");
                LoadGrid();
            }
            else if (e.CommandName == "SuaTable")
            {
                DataTable dt = kn.GetTable($"SELECT * FROM Tables WHERE TableId={id}");
                if (dt.Rows.Count > 0)
                {
                    txtTableName.Text = dt.Rows[0]["TableName"].ToString();
                    hFormTitle.InnerText = "Sửa tên bàn";
                    btnAddTable.Visible = false;
                    btnUpdateTable.Visible = true;
                    btnCancelEdit.Visible = true;
                    ViewState["EditTableId"] = id;
                }
            }
            else if (e.CommandName == "ToggleStatus")
            {
                DataTable dt = kn.GetTable($"SELECT * FROM Tables WHERE TableId={id}");
                if (dt.Rows.Count > 0)
                {
                    string currentStatus = dt.Rows[0]["Status"].ToString();
                    string nextStatus = currentStatus == "Trống" ? "Đang có khách" : "Trống";
                    kn.Execute($"UPDATE Tables SET Status=N'{nextStatus}' WHERE TableId={id}");
                    LoadGrid();
                }
            }
        }
    }
}
