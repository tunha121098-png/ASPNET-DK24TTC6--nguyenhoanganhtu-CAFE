<%@ Page Title="Hồ sơ cá nhân" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-header { background: linear-gradient(135deg, var(--primary), var(--primary-dark)); padding: 60px 0; color: white; border-radius: 0 0 var(--radius-lg) var(--radius-lg); margin-bottom: -50px; position: relative; z-index: 1; text-align: center; }
        .profile-avatar { width: 120px; height: 120px; border-radius: 50%; background: white; margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; font-size: 3rem; color: var(--primary); box-shadow: var(--shadow-md); border: 5px solid rgba(255,255,255,0.2); }
        .profile-main { position: relative; z-index: 2; display: grid; grid-template-columns: 1fr 2fr; gap: 30px; margin-top: 0; }
        .section-title { font-weight: 700; font-size: 1.5rem; margin-bottom: 25px; display: flex; align-items: center; gap: 12px; color: var(--primary-dark); }
        .section-title i { color: var(--secondary); background: rgba(236, 177, 118, 0.1); width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; border-radius: 12px; }
        .history-card { margin-bottom: 25px; }
        .badge-info { background: #f0f0f0; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; color: #666; font-weight: 600; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="profile-header">
        <div class="profile-avatar">
            <i class="fas fa-user"></i>
        </div>
        <h1><%= Session["FullName"] %></h1>
        <p><i class="fas fa-envelope"></i> <%= Session["Username"] %> | <i class="fas fa-id-badge"></i> <%= Session["Role"] %></p>
    </div>

    <div class="container" style="margin-top: 50px;">
        <div class="profile-main">
            <!-- Settings Card -->
            <div class="card" style="align-self: start;">
                <h3 class="section-title"><i class="fas fa-cog"></i> Cài đặt</h3>
                
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <asp:TextBox ID="txtUsernameDisplay" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" style="background: #fdfdfd; cursor: not-allowed;"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Họ và tên</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Nhập họ và tên"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Email liên hệ</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="email@example.com"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Đổi mật khẩu <span class="badge-info">Để trống nếu không đổi</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>

                <div style="margin-top: 35px;">
                    <asp:Button ID="btnUpdate" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary" Width="100%" OnClick="btnUpdate_Click" />
                    <asp:Label ID="lblMsg" runat="server" style="display: block; margin-top: 20px; text-align:center; font-weight: 600;"></asp:Label>
                </div>
            </div>

            <!-- History Section -->
            <div class="history-section">
                <!-- Orders History -->
                <div class="card history-card">
                    <h3 class="section-title"><i class="fas fa-history"></i> Lịch sử đơn hàng</h3>
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="table" EmptyDataText="Bạn chưa có đơn hàng nào." BorderStyle="None">
                        <Columns>
                            <asp:TemplateField HeaderText="Mã đơn">
                                <ItemTemplate>
                                    <strong>#<%# Eval("OrderId") %></strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OrderDate" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                            <asp:TemplateField HeaderText="Tổng tiền">
                                <ItemTemplate>
                                    <span style="color: var(--primary); font-weight: 700;">
                                        <%# string.Format("{0:N0} VNĐ", Eval("TotalAmount")) %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trạng thái">
                                <ItemTemplate>
                                    <span class='status-badge <%# GetStatusClass(Eval("Status").ToString()) %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <a href='OrderDetail.aspx?id=<%# Eval("OrderId") %>' class="btn" style="padding: 5px 15px; border: 1px solid #ddd; font-size: 0.8rem; border-radius: 8px;">
                                        Chi tiết <i class="fas fa-arrow-right" style="font-size: 0.7rem;"></i>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Script update feedback -->
    <script>
        function showSuccess(msg) {
            Swal.fire({ icon: 'success', title: 'Thành công', text: msg, confirmButtonColor: '#6F4E37' });
        }
        function showError(msg) {
            Swal.fire({ icon: 'error', title: 'Lỗi', text: msg, confirmButtonColor: '#EB5757' });
        }
    </script>
</asp:Content>
