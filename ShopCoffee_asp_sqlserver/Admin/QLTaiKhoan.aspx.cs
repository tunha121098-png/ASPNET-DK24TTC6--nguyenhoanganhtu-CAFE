using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class QLTaiKhoan : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox txtFullName;
        protected global::System.Web.UI.WebControls.TextBox txtUsername;
        protected global::System.Web.UI.WebControls.TextBox txtPassword;
        protected global::System.Web.UI.WebControls.DropDownList ddlRole;
        protected global::System.Web.UI.WebControls.Button btnAdd;
        protected global::System.Web.UI.WebControls.Button btnUpdate;
        protected global::System.Web.UI.WebControls.Button btnCancel;
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.GridView gvUsers;

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
            gvUsers.DataSource = kn.GetTable("SELECT * FROM Users ORDER BY Role ASC");
            gvUsers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;

            if (user == "" || pass == "") { lblMsg.Text = "Tên đăng nhập và mật khẩu là bắt buộc!"; return; }

            string sql = $"INSERT INTO Users (Username, Password, FullName, Role) VALUES ('{user}', '{pass}', N'{fullName}', '{role}')";
            kn.Execute(sql);
            lblMsg.Text = "Đã thêm tài khoản mới!";
            ResetForm();
            LoadGrid();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Xoa")
            {
                // Không tự xóa chính mình nếu đang đăng nhập
                if (id == Convert.ToInt32(Session["UserId"]))
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Không thể tự xóa chính mình!";
                    return;
                }

                kn.Execute($"DELETE FROM Users WHERE UserId={id}");
                LoadGrid();
            }
            else if (e.CommandName == "Sua")
            {
                DataTable dt = kn.GetTable($"SELECT * FROM Users WHERE UserId={id}");
                if (dt.Rows.Count > 0)
                {
                    txtFullName.Text = dt.Rows[0]["FullName"].ToString();
                    txtUsername.Text = dt.Rows[0]["Username"].ToString();
                    txtPassword.Text = dt.Rows[0]["Password"].ToString();
                    ddlRole.SelectedValue = dt.Rows[0]["Role"].ToString();
                    ViewState["EditUserId"] = id;
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                    btnCancel.Visible = true;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int id = (int)ViewState["EditUserId"];
            string fullName = txtFullName.Text.Trim();
            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;

            string sql = "";
            if (string.IsNullOrEmpty(pass))
            {
                sql = $"UPDATE Users SET FullName=N'{fullName}', Username='{user}', Role='{role}' WHERE UserId={id}";
            }
            else
            {
                sql = $"UPDATE Users SET FullName=N'{fullName}', Username='{user}', Password='{pass}', Role='{role}' WHERE UserId={id}";
            }
            kn.Execute(sql);
            lblMsg.Text = "Đã cập nhật thông tin!";
            ResetForm();
            LoadGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        void ResetForm()
        {
            txtFullName.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            ViewState["EditUserId"] = null;
        }
    }
}
