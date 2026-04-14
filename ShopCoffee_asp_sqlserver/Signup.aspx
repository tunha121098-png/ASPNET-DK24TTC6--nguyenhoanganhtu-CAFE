<%@ Page Title="Đăng ký" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs"
    Inherits="ShopCoffee_asp_sqlserver.Signup" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .auth-container { max-width: 420px; margin: 60px auto; }
        .auth-container .card { padding: 45px 40px; border-radius: 20px; box-shadow: 0 8px 40px rgba(0,0,0,0.10); }
        .auth-container h2 { font-size: 2rem; font-weight: 800; color: var(--primary-dark); text-align: center; margin-bottom: 30px; }
        .auth-container .form-group { margin-bottom: 20px; }
        .auth-container .form-group label { display: block; font-weight: 600; margin-bottom: 8px; color: #555; font-size: 0.92rem; }
        .auth-container .form-control { width: 100%; padding: 14px 18px; border: 1.5px solid #e0d8cf; border-radius: 12px; font-size: 1rem; background: #fdfaf7; box-sizing: border-box; transition: border-color 0.2s; }
        .auth-container .form-control:focus { outline: none; border-color: var(--primary); background: #fff; }
        .btn-submit { display: block; width: 100%; padding: 15px; border: none; border-radius: 12px; background: var(--primary-dark); color: white; font-size: 1.05rem; font-weight: 700; cursor: pointer; margin-top: 25px; transition: all 0.2s; letter-spacing: 0.5px; }
        .btn-submit:hover { background: var(--primary); transform: translateY(-1px); box-shadow: 0 4px 15px rgba(93,54,30,0.3); }
        .auth-footer { text-align: center; margin-top: 20px; color: #888; }
        .auth-footer a { color: var(--primary); font-weight: 600; text-decoration: none; }
        .auth-footer a:hover { text-decoration: underline; }
        .auth-error { color: #e53e3e; text-align: center; margin-top: 12px; font-size: 0.9rem; display: block; }
    </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container auth-container">
            <div class="card">
                <h2>Đăng ký tài khoản</h2>
                <div class="form-group">
                    <label>Họ và tên</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Nhập họ tên"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Tên đăng nhập mới"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ít nhất 6 ký tự"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Nhập email"></asp:TextBox>
                </div>
                <asp:Button ID="btnSignup" runat="server" Text="Đăng ký" CssClass="btn-submit" OnClick="btnSignup_Click" />
                <div class="auth-footer">
                    <p>Đã có tài khoản? <a href="Login.aspx">Đăng nhập</a></p>
                    <asp:Label ID="lblMessage" runat="server" CssClass="auth-error"></asp:Label>
                </div>
            </div>
        </div>
    </asp:Content>