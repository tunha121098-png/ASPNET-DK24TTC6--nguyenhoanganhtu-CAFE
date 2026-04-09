<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="Dashboard.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-home"></i> Bảng điều khiển</h2>
        <p style="color: #666; margin-bottom: 30px;">Chào mừng bạn trở lại, hệ thống đang hoạt động ổn định.</p>

        <!-- Thống kê nhanh -->
        <div class="stats-grid">
            <div class="stat-box">
                <h4>TỔNG DOANH THU</h4>
                <div class="value">
                    <asp:Label ID="lblTotalRevenue" runat="server" Text="0"></asp:Label>
                </div>
                <p>VNĐ</p>
            </div>
            <div class="stat-box">
                <h4>ĐƠN HÀNG</h4>
                <div class="value">
                    <asp:Label ID="lblOrderCount" runat="server" Text="0"></asp:Label>
                </div>
                <p>Đơn đã đặt</p>
            </div>
            <div class="stat-box">
                <h4>BÀN TRỐNG</h4>
                <div class="value">
                    <asp:Label ID="lblFreeTables" runat="server" Text="0"></asp:Label>
                </div>
                <p>Sẵn sàng phục vụ</p>
            </div>
            <div class="stat-box">
                <h4>KHÁCH HÀNG</h4>
                <div class="value">
                    <asp:Label ID="lblUserCount" runat="server" Text="0"></asp:Label>
                </div>
                <p>Tài khoản đăng ký</p>
            </div>
        </div>

        <!-- Món bán chạy (Danh sách đơn giản) -->
        <div class="card">
            <h3><i class="fas fa-star"></i> Món bán chạy nhất</h3>
            <asp:GridView ID="gvBestSellers" runat="server" CssClass="table" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Tên món" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    <asp:BoundField DataField="TotalSold" HeaderText="Số lượng bán" />
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>