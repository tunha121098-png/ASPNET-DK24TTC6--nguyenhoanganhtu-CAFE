<%@ Page Title="Quản lý Menu" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="QLMenu.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.QLMenu" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-utensils"></i> Quản lý thực đơn (Menu)</h2>

        <div class="card" style="margin-bottom: 30px;">
            <h3>Thêm / Sửa món mới</h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px;">
                <div class="form-group">
                    <label>Tên món</label>
                    <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Danh mục</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Giá bán (VNĐ)</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mô tả</label>
                    <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div style="margin-top: 10px;">
                <asp:Button ID="btnAdd" runat="server" Text="Thêm món" CssClass="btn btn-primary"
                    OnClick="btnAdd_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Cập nhật" CssClass="btn" Visible="false"
                    OnClick="btnUpdate_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn" Visible="false"
                    OnClick="btnCancel_Click" />
                <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="margin-left: 20px;"></asp:Label>
            </div>
        </div>

        <!-- Danh sách Menu -->
        <div class="card">
            <h3>Danh mục sản phẩm hiện có</h3>
            <asp:GridView ID="gvMenu" runat="server" CssClass="table" AutoGenerateColumns="False"
                DataKeyNames="ProductId" OnRowCommand="gvMenu_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ProductId" HeaderText="ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Tên món" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Danh mục" />
                    <asp:BoundField DataField="Price" HeaderText="Giá" DataFormatString="{0:N0}" />
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Sua"
                                CommandArgument='<%# Eval("ProductId") %>'><i class="fas fa-edit"></i> Sửa
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDel" runat="server" CommandName="Xoa"
                                CommandArgument='<%# Eval("ProductId") %>'
                                OnClientClick="return confirm('Bạn chắc chắn xóa món này?')"
                                style="margin-left: 10px; color: red;"><i class="fas fa-trash"></i> Xóa</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>