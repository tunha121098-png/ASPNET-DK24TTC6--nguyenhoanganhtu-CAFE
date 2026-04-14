<%@ Page Title="Chi tiết đơn hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.OrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .order-detail-header { background: #fff; padding: 40px; border-radius: var(--radius-md); box-shadow: var(--shadow-md); margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; border-left: 8px solid var(--primary); }
        .order-id { font-size: 2rem; font-weight: 700; color: var(--primary-dark); }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 40px; margin-bottom: 40px; }
        .info-box h4 { color: #888; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px; margin-bottom: 10px; }
        .info-box p { font-weight: 600; font-size: 1.1rem; }
        .product-image-mini { width: 50px; height: 50px; object-fit: cover; border-radius: 8px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <a href="UserProfile.aspx" style="text-decoration: none; color: var(--text-muted); display: inline-flex; align-items: center; gap: 8px; margin-bottom: 20px;">
            <i class="fas fa-chevron-left"></i> Quay lại lịch sử đơn hàng
        </a>

        <div class="order-detail-header">
            <div>
                <div class="order-id">Đơn hàng #<asp:Label ID="lblOrderId" runat="server"></asp:Label></div>
                <div style="margin-top: 5px;">
                    <span class="badge-info"><i class="far fa-clock"></i> <asp:Label ID="lblDate" runat="server"></asp:Label></span>
                </div>
            </div>
            <div style="text-align: right;">
                <asp:Label ID="lblStatus" runat="server" CssClass="status-badge"></asp:Label>
            </div>
        </div>

        <div class="card" style="margin-bottom: 40px;">
            <div class="info-grid">
                <div class="info-box">
                    <h4><i class="fas fa-user"></i> Khách hàng</h4>
                    <p><asp:Label ID="lblCustomer" runat="server"></asp:Label></p>
                </div>
                <div class="info-box">
                    <h4><i class="fas fa-phone"></i> Số điện thoại</h4>
                    <p><asp:Label ID="lblPhone" runat="server"></asp:Label></p>
                </div>
                <div class="info-box">
                    <h4><i class="fas fa-chair"></i> Vị trí bàn</h4>
                    <p><asp:Label ID="lblTableName" runat="server"></asp:Label></p>
                </div>
            </div>

            <h3 class="section-title" style="margin-bottom: 20px;"><i class="fas fa-list"></i> Danh sách món đã đặt</h3>
            <asp:GridView ID="gvDetails" runat="server" AutoGenerateColumns="False" CssClass="table" BorderStyle="None">
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sản phẩm">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <img src='<%# Eval("ImageUrl") %>' class="product-image-mini" onerror="this.src='https://placehold.co/50x50?text=No+Img'" />
                                <strong><%# Eval("ProductName") %></strong>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Price" HeaderText="Đơn giá" DataFormatString="{0:N0} VNĐ" />
                    <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />
                    <asp:TemplateField HeaderText="Thành tiền">
                        <ItemTemplate>
                            <span style="font-weight: 700; color: var(--primary);">
                                <%# string.Format("{0:N0} VNĐ", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div style="margin-top: 30px; text-align: right; padding-top: 20px; border-top: 2px solid #f9f9f9;">
                <div style="font-size: 1.1rem; color: #888; margin-bottom: 5px;">TỔNG THANH TOÁN</div>
                <div style="font-size: 2.2rem; font-weight: 700; color: var(--primary);">
                    <asp:Label ID="lblTotal" runat="server"></asp:Label> VNĐ
                </div>
            </div>
        </div>
    </div>
</asp:Content>
