<%@ Page Title="Quản lý Đơn hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="QLDonHang.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.QLDonHang" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</h2>

        <div class="card">
            <h3>Danh mục đơn hàng mới nhất</h3>
            <asp:GridView ID="gvOrders" runat="server" CssClass="table" AutoGenerateColumns="False"
                DataKeyNames="OrderId" OnRowCommand="gvOrders_RowCommand">
                <Columns>
                    <asp:BoundField DataField="OrderId" HeaderText="ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Khách hàng" />
                    <asp:BoundField DataField="TableName" HeaderText="Vị trí bàn" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Ngày đặt"
                        DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Tổng tiền" DataFormatString="{0:N0}" />
                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <span class='<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnConfirm" runat="server" CommandName="XacNhan"
                                CommandArgument='<%# Eval("OrderId") %>'
                                Visible='<%# Eval("Status").ToString() == "Chờ xác nhận" %>'><i
                                    class="fas fa-check"></i> Duyệt</asp:LinkButton>
                            <asp:LinkButton ID="btnComplete" runat="server" CommandName="HoanThanh"
                                CommandArgument='<%# Eval("OrderId") %>'
                                Visible='<%# Eval("Status").ToString() == "Đã xác nhận" %>' style="color: green;"><i
                                    class="fas fa-check-double"></i> Xong</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Huy"
                                CommandArgument='<%# Eval("OrderId") %>'
                                Visible='<%# Eval("Status").ToString() == "Chờ xác nhận" %>'
                                style="margin-left: 10px; color: red;"><i class="fas fa-times"></i> Hủy</asp:LinkButton>
                            <asp:LinkButton ID="btnView" runat="server" CommandName="XemChiTiet"
                                CommandArgument='<%# Eval("OrderId") %>' style="margin-left: 10px; color: blue;"><i
                                    class="fas fa-eye"></i> Chi tiết</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Chi tiết đơn hàng -->
        <asp:Panel ID="pnlDetails" runat="server" CssClass="card" Visible="false"
            style="margin-top: 30px; border-top: 5px solid #6F4E37;">
            <h3><i class="fas fa-list"></i> Chi tiết đơn hàng #<asp:Label ID="lblOrderId" runat="server"></asp:Label>
            </h3>
            <asp:GridView ID="gvDetails" runat="server" CssClass="table" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Tên món" />
                    <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />
                    <asp:BoundField DataField="Price" HeaderText="Đơn giá" DataFormatString="{0:N0}" />
                    <asp:BoundField DataField="Total" HeaderText="Thành tiền" DataFormatString="{0:N0}" />
                </Columns>
            </asp:GridView>
            <div style="text-align: right; margin-top: 15px;">
                <asp:Button ID="btnCloseDetails" runat="server" Text="Đóng chi tiết" CssClass="btn"
                    OnClick="btnCloseDetails_Click" />
            </div>
        </asp:Panel>

        <!-- Popup Chi tiết (Tùy chọn hiển thị thêm) -->
    </asp:Content>