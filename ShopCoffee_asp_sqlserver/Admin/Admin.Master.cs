using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopCoffee_asp_sqlserver.Admin
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền Admin
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("../Login.aspx");
            }
        }
    }
}
