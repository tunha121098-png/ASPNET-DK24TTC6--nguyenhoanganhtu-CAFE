<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Login" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container auth-container">
            <div class="card">
                <h2 style="text-align: center; margin-bottom: 20px;">Đăng nhập</h2>
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nhập username">
                    </asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"
                        placeholder="Nhập mật khẩu"></asp:TextBox>
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn btn-primary" Width="100%"
                    OnClick="btnLogin_Click" />
                <div style="margin-top: 15px; text-align: center;">
                    <p>Chưa có tài khoản? <a href="Signup.aspx">Đăng ký ngay</a></p>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display: block; margin-top: 10px;">
                    </asp:Label>
                </div>
            </div>
        </div>
    </asp:Content>