<%@ Page Title="Đặt bàn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatBan.aspx.cs"
    Inherits="ShopCoffee_asp_sqlserver.DatBan" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container">
            <h2 style="margin-bottom: 30px;"><i class="fas fa-calendar-alt"></i> Đặt bàn trực tuyến</h2>

            <div class="row" style="display: flex; gap: 30px;">
                <!-- Sơ đồ bàn -->
                <div style="flex: 2;">
                    <h3 style="margin-bottom: 20px;">Sơ đồ bàn hiện tại</h3>
                    <div class="table-grid">
                        <asp:Repeater ID="rptTables" runat="server">
                            <ItemTemplate>
                                <div
                                    class='<%# "table-box " + (Eval("Status").ToString() == "Trống" ? "available" : "occupied") %>'>
                                    <i class="fas fa-couch"></i><br />
                                    <strong>
                                        <%# Eval("TableName") %>
                                    </strong><br />
                                    <span style="font-size: 0.8rem;">
                                        <%# Eval("Status") %>
                                    </span>
                                    <div style="margin-top: 10px;">
                                        <%# Eval("Status").ToString()=="Trống"
                                            ? "<span class='btn btn-primary' style='padding: 5px 10px; font-size: 0.7rem;'>Chọn</span>"
                                            : "" %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- Form đặt bàn -->
                <div style="flex: 1;" class="card">
                    <h3>Thủ tục đặt bàn</h3>
                    <div class="form-group" style="margin-top:20px;">
                        <label>Chọn bàn</label>
                        <asp:DropDownList ID="ddlTables" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Thời gian đến</label>
                        <asp:TextBox ID="txtBookingTime" runat="server" CssClass="form-control"
                            TextMode="DateTimeLocal"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Ghi chú</label>
                        <asp:TextBox ID="txtNote" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3">
                        </asp:TextBox>
                    </div>
                    <asp:Button ID="btnBook" runat="server" Text="Gửi yêu cầu đặt bàn" CssClass="btn btn-primary"
                        Width="100%" OnClick="btnBook_Click" />
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" style="display: block; margin-top: 10px;">
                    </asp:Label>
                </div>
            </div>
        </div>
    </asp:Content>