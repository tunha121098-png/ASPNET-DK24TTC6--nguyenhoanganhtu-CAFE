<%@ Page Title="Quản lý Đặt bàn" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="QLDatBan.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Admin.QLDatBan" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="AdminMainContent" runat="server">
        <h2><i class="fas fa-calendar-check"></i> Quản lý yêu cầu Đặt bàn</h2>

        <div class="card">
            <h3>Danh sách các yêu cầu đặt chỗ</h3>
            <asp:GridView ID="gvBookings" runat="server" CssClass="table" AutoGenerateColumns="False"
                DataKeyNames="BookingId" OnRowCommand="gvBookings_RowCommand">
                <Columns>
                    <asp:BoundField DataField="BookingId" HeaderText="ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Khách hàng" />
                    <asp:BoundField DataField="TableName" HeaderText="Bàn" />
                    <asp:BoundField DataField="BookingTime" HeaderText="Thời gian"
                        DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <span class='<%# GetBookingClass(Eval("Status").ToString()) %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnApprove" runat="server" CommandName="Duyet"
                                CommandArgument='<%# Eval("BookingId") %>'
                                Visible='<%# Eval("Status").ToString() == "Chờ duyệt" %>'><i class="fas fa-check"></i>
                                Duyệt</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Huy"
                                CommandArgument='<%# Eval("BookingId") %>'
                                Visible='<%# Eval("Status").ToString() == "Chờ duyệt" %>'
                                style="margin-left: 10px; color: red;"><i class="fas fa-times"></i> Hủy</asp:LinkButton>
                            <asp:LinkButton ID="btnComplete" runat="server" CommandName="Xoa"
                                CommandArgument='<%# Eval("BookingId") %>' style="margin-left: 10px; color: #888;"><i
                                    class="fas fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="margin-top: 15px; display: block;">
            </asp:Label>
        </div>

        <style>
            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: bold;
            }
        </style>
    </asp:Content>