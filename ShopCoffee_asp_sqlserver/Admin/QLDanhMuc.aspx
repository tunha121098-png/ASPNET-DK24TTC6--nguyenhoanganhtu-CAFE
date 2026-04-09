<%@ Page Title="Quản lý Danh mục" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="QLDanhMuc.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.QLDanhMuc" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-tags"></i> Quản lý Danh mục sản phẩm</h2>

        <div class="card" style="margin-bottom: 30px;">
            <h3>Thêm / Sửa danh mục</h3>
            <div style="display: flex; gap: 20px; margin-top: 15px;">
                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control"
                    placeholder="Tên danh mục (vd: Sinh tố)"></asp:TextBox>
                <asp:Button ID="btnAdd" runat="server" Text="Thêm mới" CssClass="btn btn-primary"
                    OnClick="btnAdd_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Cập nhật" CssClass="btn" Visible="false"
                    OnClick="btnUpdate_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn" Visible="false"
                    OnClick="btnCancel_Click" />
            </div>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="display: block; margin-top: 10px;">
            </asp:Label>
        </div>

        <div class="card">
            <h3>Danh sách các loại hiện có</h3>
            <asp:GridView ID="gvCategories" runat="server" CssClass="table" AutoGenerateColumns="False"
                DataKeyNames="CategoryId" OnRowCommand="gvCategories_RowCommand">
                <Columns>
                    <asp:BoundField DataField="CategoryId" HeaderText="ID" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Tên danh mục" />
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Sua"
                                CommandArgument='<%# Eval("CategoryId") %>'><i class="fas fa-edit"></i> Sửa
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDel" runat="server" CommandName="Xoa"
                                CommandArgument='<%# Eval("CategoryId") %>'
                                OnClientClick="return confirm('Xóa danh mục này?')"
                                style="margin-left: 10px; color: red;"><i class="fas fa-trash"></i> Xóa</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>