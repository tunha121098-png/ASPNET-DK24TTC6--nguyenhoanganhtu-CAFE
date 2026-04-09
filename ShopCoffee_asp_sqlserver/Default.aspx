<%@ Page Title="Trang chủ - Coffee House" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Default" ResponseEncoding="utf-8" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <!-- Hero Section -->
        <div class="hero">
            <h2>Chào mừng bạn đến với Coffee House</h2>
            <p>Hương vị truyền thống, trải nghiệm hiện đại.</p>
            <a href="#menu" class="btn btn-primary" style="margin-top: 20px;">Khám phá Menu</a>
        </div>

        <div class="container" id="menu">
            <h2 style="margin-bottom: 30px; text-align: center;">Danh mục Menu</h2>

            <!-- Filter & Search -->
            <div style="margin-bottom: 40px; display: flex; gap: 10px; justify-content: center;">
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" style="width: 200px;"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                    <asp:ListItem Value="0">Tất cả danh mục</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" style="width: 300px;"
                    placeholder="Tìm kiếm món..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Tìm" CssClass="btn btn-primary"
                    OnClick="btnSearch_Click" />
            </div>

            <!-- Product Grid -->
            <div class="product-grid">
                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <img src='<%# "https://via.placeholder.com/300x200?text=" + Eval("ProductName") %>'
                                alt='<%# Eval("ProductName") %>' class="product-image">
                            <div class="product-info">
                                <h3>
                                    <%# Eval("ProductName") %>
                                </h3>
                                <p style="color: #666; font-size: 0.9rem; margin-bottom: 10px;">
                                    <%# Eval("Description") %>
                                </p>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span class="product-price">
                                        <%# string.Format("{0:N0} VNĐ", Eval("Price")) %>
                                    </span>
                                    <asp:LinkButton ID="btnAddCart" runat="server" CssClass="btn btn-primary"
                                        CommandName="AddToCart" CommandArgument='<%# Eval("ProductId") %>'>
                                        <i class="fas fa-cart-plus"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </asp:Content>