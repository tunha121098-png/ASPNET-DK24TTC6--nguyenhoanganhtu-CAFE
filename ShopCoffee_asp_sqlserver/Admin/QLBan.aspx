<%@ Page Title="Quản lý Bàn" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="QLBan.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.QLBan" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-table"></i> Quản lý Bàn</h2>

        <div class="card" style="margin-bottom: 30px;">
            <h3>Thêm bàn mới</h3>
            <div style="display: flex; gap: 20px; margin-top: 15px;">
                <asp:TextBox ID="txtTableName" runat="server" CssClass="form-control"
                    placeholder="Tên bàn (vd: Bàn 10)"></asp:TextBox>
                <asp:Button ID="btnAddTable" runat="server" Text="Thêm bàn" CssClass="btn btn-primary"
                    OnClick="btnAddTable_Click" />
            </div>
        </div>

        <div class="card">
            <h3>Danh sách bàn và trạng thái</h3>
            <asp:GridView ID="gvTables" runat="server" CssClass="table" AutoGenerateColumns="False"
                DataKeyNames="TableId" OnRowCommand="gvTables_RowCommand">
                <Columns>
                    <asp:BoundField DataField="TableId" HeaderText="ID" />
                    <asp:BoundField DataField="TableName" HeaderText="Tên bàn" />
                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <span class='<%# Eval("Status").ToString() == "Trống" ? "status-green" : "status-red" %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggle" runat="server" CommandName="ToggleStatus"
                                CommandArgument='<%# Eval("TableId") %>' CssClass="btn"
                                style="font-size: 0.8rem; background: #eee;">Đổi trạng thái</asp:LinkButton>
                            <asp:LinkButton ID="btnDel" runat="server" CommandName="XoaTable"
                                CommandArgument='<%# Eval("TableId") %>' OnClientClick="return confirm('Xóa bàn này?')"
                                style="margin-left: 10px; color: red;"><i class="fas fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>