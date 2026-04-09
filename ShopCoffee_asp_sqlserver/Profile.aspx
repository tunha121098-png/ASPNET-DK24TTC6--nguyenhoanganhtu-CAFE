<%@ Page Title="Hồ sơ cá nhân" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-container { max-width: 600px; margin: 50px auto; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container profile-container">
        <div class="card">
            <h2 style="text-align: center; margin-bottom: 30px;"><i class="fas fa-user-circle"></i> Hồ sơ của bạn</h2>
            
            <div class="form-group">
                <label>Tên đăng nhập (Username)</label>
                <asp:TextBox ID="lblUsername" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" style="background: #f9f9f9;"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Họ và tên</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Nhập họ tên mới"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Nhập email mới"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Mật khẩu mới (Để trống nếu không muốn đổi)</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Mật khẩu mới"></asp:TextBox>
            </div>

            <div style="margin-top: 30px; text-align: center;">
                <asp:Button ID="btnUpdate" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary" Width="100%" OnClick="btnUpdate_Click" />
                <asp:Label ID="lblMsg" runat="server" style="display: block; margin-top: 20px;"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
