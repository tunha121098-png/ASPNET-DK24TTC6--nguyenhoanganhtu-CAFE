<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs"
    Inherits="ShopCoffee_asp_sqlserver.Cart" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container">
            <h2 style="margin-bottom: 30px;"><i class="fas fa-shopping-cart"></i> Giỏ hàng của bạn</h2>

            <div class="card">
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="table"
                    OnRowCommand="gvCart_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Tên món" />
                        <asp:BoundField DataField="Price" HeaderText="Đơn giá" DataFormatString="{0:N0}" />
                        <asp:TemplateField HeaderText="Số lượng">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Quantity") %>' Width="50px"
                                    CssClass="form-control" style="display:inline-block;"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Total" HeaderText="Thành tiền" DataFormatString="{0:N0}" />
                        <asp:TemplateField HeaderText="Thao tác">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveProduct"
                                    CommandArgument='<%# Eval("ProductId") %>' ForeColor="Red">
                                    <i class="fas fa-trash"></i> Xóa
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <div style="margin-top: 20px; text-align: right;">
                    <h3>Tổng cộng: <asp:Label ID="lblTotal" runat="server" Text="0" ForeColor="#6F4E37"></asp:Label> VNĐ
                    </h3>
                    <div style="margin-top: 20px;">
                        <asp:Button ID="btnBack" runat="server" Text="Tiếp tục mua sắm" CssClass="btn"
                            PostBackUrl="Default.aspx" />
                        <asp:Button ID="btnOrder" runat="server" Text="Xác nhận đặt món" CssClass="btn btn-primary"
                            style="margin-left: 10px;" OnClick="btnOrder_Click" />
                    </div>
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="display: block; margin-top: 10px;">
                    </asp:Label>
                </div>
            </div>
        </div>
    </asp:Content>