<%@ Page Title="Đăng ký" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs"
    Inherits="ShopCoffee_asp_sqlserver.Signup" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container auth-container">
            <div class="card">
                <h2 style="text-align: center; margin-bottom: 20px;">Đăng ký tài khoản</h2>
                <div class="form-group">
                    <label>Họ và tên</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Nhập họ tên">
                    </asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                        placeholder="Tên đăng nhập mới"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"
                        placeholder="Ít nhất 6 ký tự"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"
                        placeholder="Nhập email"></asp:TextBox>
                </div>
                <asp:Button ID="btnSignup" runat="server" Text="Đăng ký" CssClass="btn btn-primary" Width="100%"
                    OnClick="btnSignup_Click" />
                <div style="margin-top: 15px; text-align: center;">
                    <p>Đã có tài khoản? <a href="Login.aspx">Đăng nhập</a></p>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display: block; margin-top: 10px;">
                    </asp:Label>
                </div>
            </div>
        </div>
    </asp:Content>