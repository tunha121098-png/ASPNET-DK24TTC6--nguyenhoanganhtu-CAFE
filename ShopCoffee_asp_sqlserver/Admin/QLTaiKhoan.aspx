<%@ Page Title="Quản lý Tài khoản" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="QLTaiKhoan.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.QLTaiKhoan" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-users"></i> Quản lý Tài khoản người dùng</h2>

        <div class="card" style="margin-bottom: 30px;">
            <h3>Thêm mới / Cập nhật người dùng</h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px;">
                <div class="form-group">
                    <label>Họ tên</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password">
                    </asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Vai trò (Role)</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                        <asp:ListItem Value="User">Khách hàng (User)</asp:ListItem>
                        <asp:ListItem Value="Admin">Quản trị viên (Admin)</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div style="margin-top: 10px;">
                <asp:Button ID="btnAdd" runat="server" Text="Thêm tài khoản" CssClass="btn btn-primary"
                    OnClick="btnAdd_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Lưu thay đổi" CssClass="btn" Visible="false"
                    OnClick="btnUpdate_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn" Visible="false"
                    OnClick="btnCancel_Click" />
                <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="margin-left: 20px;"></asp:Label>
            </div>
        </div>

        <!-- Danh sách Accounts -->
        <div class="card">
            <h3>Danh mục thành viên</h3>
            <asp:GridView ID="gvUsers" runat="server" CssClass="table" AutoGenerateColumns="False" DataKeyNames="UserId"
                OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="UserId" HeaderText="ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Họ tên" />
                    <asp:BoundField DataField="Username" HeaderText="Tên đăng nhập" />
                    <asp:BoundField DataField="Role" HeaderText="Quyền" />
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Sua"
                                CommandArgument='<%# Eval("UserId") %>'><i class="fas fa-user-edit"></i> Sửa
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDel" runat="server" CommandName="Xoa"
                                CommandArgument='<%# Eval("UserId") %>'
                                OnClientClick="return confirm('Bạn chắc chắn muốn xóa người dùng này?')"
                                style="margin-left: 10px; color: red;"><i class="fas fa-user-times"></i> Xóa
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>