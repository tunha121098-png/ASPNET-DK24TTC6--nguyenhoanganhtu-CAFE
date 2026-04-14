<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header.ascx.cs" Inherits="ShopCoffee_asp_sqlserver.UserControls.Header" %>

<header>
    <div class="logo">
        <h1><i class="fas fa-mug-hot" style="color: var(--secondary);"></i> COFFEE HOUSE</h1>
    </div>
    <nav>
        <ul>
            <li><a href="Default.aspx"><i class="fas fa-home"></i> Trang chủ</a></li>
            <li><a href="Cart.aspx">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng 
                <span id="cartCount" class="badge" style="background: var(--secondary); color: #fff; padding: 2px 7px; border-radius: 50%; font-size: 0.75rem; vertical-align: top; display: <%= (Session["Cart"] != null && ((System.Data.DataTable)Session["Cart"]).Rows.Count > 0) ? "inline" : "none" %>;">
                    <%= (Session["Cart"] != null) ? ((System.Data.DataTable)Session["Cart"]).Rows.Count : 0 %>
                </span>
            </a></li>
            <% if (Session["Username"] == null) { %>
                <li><a href="Login.aspx" class="btn btn-primary" style="padding: 8px 20px; color: #fff;"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a></li>
            <% } else { %>
                <li style="position: relative;" class="user-menu-parent">
                    <a href="UserProfile.aspx" style="display: flex; align-items: center; gap: 8px;">
                        <div style="width: 32px; height: 32px; background: var(--secondary); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff;">
                            <%= Session["FullName"]?.ToString().Substring(0, 1).ToUpper() %>
                        </div>
                        <span style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <%= Session["FullName"] ?? Session["Username"] %>
                        </span>
                        <i class="fas fa-chevron-down" style="font-size: 0.7rem;"></i>
                    </a>
                    <!-- User Dropdown could be added here for a more "wow" factor -->
                </li>
                <li><a href="Logout.aspx" style="color: #ff7675;"><i class="fas fa-power-off"></i></a></li>
                <% if (Session["Role"]?.ToString() == "Admin") { %>
                    <li><a href="Admin/Dashboard.aspx" style="color: var(--secondary); font-weight: bold;">[ADMIN]</a></li>
                <% } %>
            <% } %>
        </ul>
    </nav>
</header>
