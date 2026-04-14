<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ShopCoffee_asp_sqlserver.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-container { display: grid; grid-template-columns: 2fr 1fr; gap: 30px; margin-top: 40px; }
        .cart-items { }
        .checkout-card { position: sticky; top: 100px; height: fit-content; }
        .qty-box { display: flex; align-items: center; background: #f8f9fa; border-radius: 50px; padding: 5px 15px; border: 1px solid #eee; }
        .btn-qty { color: var(--primary); font-size: 1.2rem; cursor: pointer; transition: 0.2s; }
        .btn-qty:hover { color: var(--secondary); transform: scale(1.1); }
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 1rem; }
        .summary-total { border-top: 2px dashed #eee; padding-top: 20px; margin-top: 20px; font-size: 1.3rem; font-weight: 700; color: var(--primary); }
        .empty-cart-state { text-align: center; padding: 80px 0; }
        .empty-cart-state i { font-size: 5rem; color: #eee; margin-bottom: 20px; display: block; }
        .btn-clear-cart { background: none; border: none; color: #999; font-size: 0.9rem; cursor: pointer; padding: 5px 0; transition: color 0.2s; }
        .btn-clear-cart:hover { color: #e53e3e; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2 style="margin-bottom: 35px; font-weight: 700; display: flex; align-items: center; gap: 15px;">
            <i class="fas fa-shopping-basket" style="color: var(--secondary);"></i> Giỏ hàng <%= (Session["Cart"] != null ? "(" + ((System.Data.DataTable)Session["Cart"]).Rows.Count + ")" : "") %>
        </h2>

        <% if (Session["Cart"] == null || ((System.Data.DataTable)Session["Cart"]).Rows.Count == 0) { %>
            <div class="card empty-cart-state">
                <i class="fas fa-shopping-cart"></i>
                <h3>Giỏ hàng của bạn đang trống</h3>
                <p style="color: #888; margin-bottom: 30px;">Hãy quay lại Menu để chọn những món uống tuyệt vời nhất nhé!</p>
                <a href="Default.aspx" class="btn btn-primary">Khám phá Menu ngay</a>
            </div>
        <% } else { %>
            <div class="cart-container">
                <!-- Cart Items -->
                <div class="cart-items">
                    <div class="card" style="padding: 20px;">
                        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="table" BorderStyle="None" OnRowCommand="gvCart_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Sản phẩm">
                                    <ItemTemplate>
                                        <div style="display: flex; align-items: center; gap: 15px;">
                                            <div style="width: 60px; height: 60px; background: #f5f5f5; border-radius: 8px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                                <img src='<%# string.IsNullOrEmpty(Eval("ImageUrl").ToString()) ? "https://placehold.co/60x60?text=Coffee" : Eval("ImageUrl") %>' 
                                                     style="width: 100%; height: 100%; object-fit: cover;" />
                                            </div>
                                            <div>
                                                <div style="font-weight: 600; color: var(--text-main);"><%# Eval("ProductName") %></div>
                                                <div style="font-size: 0.85rem; color: #888;">ID: #<%# Eval("ProductId") %></div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Price" HeaderText="Giá" DataFormatString="{0:N0}" />
                                <asp:TemplateField HeaderText="Số lượng">
                                    <ItemTemplate>
                                        <div class="qty-box">
                                            <asp:LinkButton ID="btnDec" runat="server" CommandName="Decrease" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-qty"><i class="fas fa-minus-circle"></i></asp:LinkButton>
                                            <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Quantity") %>' style="width: 35px; text-align: center; font-weight: 700;"></asp:Label>
                                            <asp:LinkButton ID="btnInc" runat="server" CommandName="Increase" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-qty"><i class="fas fa-plus-circle"></i></asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tổng">
                                    <ItemTemplate>
                                        <div style="font-weight: 700; color: var(--primary);"><%# string.Format("{0:N0}", Eval("Total")) %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveProduct" CommandArgument='<%# Eval("ProductId") %>' style="color: #EB5757;"><i class="fas fa-trash-alt"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <div style="margin-top: 20px;">
                            <asp:Button ID="btnClear" runat="server" Text="🗑 Xóa tất cả" OnClick="btnClear_Click" CssClass="btn-clear-cart" OnClientClick="return confirm('Xóa toàn bộ giỏ hàng?');" />
                        </div>
                    </div>
                </div>

                <!-- Checkout info -->
                <div class="checkout-card">
                    <div class="card">
                        <h3 style="margin-bottom: 25px; font-weight: 700; color: var(--primary-dark);">Thông tin đặt bàn</h3>
                        
                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Số điện thoại</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="0xxx xxx xxx"></asp:TextBox>
                        </div>

                        <div class="form-group" style="margin-top: 25px;">
                            <label style="margin-bottom: 15px; display: block;"><i class="fas fa-chair"></i> Chọn vị trí bàn</label>
                            <div class="table-selection-grid">
                                <asp:Repeater ID="rptTables" runat="server" OnItemCommand="rptTables_ItemCommand">
                                    <ItemTemplate>
                                        <div class='table-item <%# Eval("Status").ToString() == "Trống" ? "" : "occupied" %> <%# (ViewState["SelectedTableId"] != null && ViewState["SelectedTableId"].ToString() == Eval("TableId").ToString()) ? "selected" : "" %>'>
                                            <asp:LinkButton ID="lnkSelectTable" runat="server" 
                                                CommandName="SelectTable" 
                                                CommandArgument='<%# Eval("TableId") %>'
                                                Enabled='<%# Eval("Status").ToString() == "Trống" %>'
                                                style="text-decoration: none; color: inherit; display: block; width: 100%;">
                                                <i class="fas fa-couch"></i>
                                                <span class="table-name"><%# Eval("TableName") %></span>
                                                <span class="table-status"><%# Eval("Status") %></span>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <asp:HiddenField ID="hfSelectedTableId" runat="server" />
                        </div>

                        <div class="summary-total">
                            <div class="summary-item">
                                <span>Thành tiền:</span>
                                <span><asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label> VNĐ</span>
                            </div>
                        </div>

                        <asp:Button ID="btnOrder" runat="server" Text="Xác nhận đặt hàng" CssClass="btn btn-primary" Width="100%" style="margin-top: 20px; padding: 15px;" OnClick="btnOrder_Click" />
                        
                        <div style="margin-top: 15px; text-align: center;">
                            <a href="Default.aspx" style="color: #888; text-decoration: none; font-size: 0.9rem;"><i class="fas fa-arrow-left"></i> Tiếp tục chọn món</a>
                        </div>
                    </div>
                    <asp:Label ID="lblMsg" runat="server" style="display: block; margin-top: 15px; text-align: center; font-weight: 600;"></asp:Label>
                </div>
            </div>
        <% } %>
    </div>

    <script>
        function showOrderSuccess(orderId) {
            Swal.fire({
                icon: 'success',
                title: 'Đặt hàng thành công!',
                text: 'Mã đơn hàng của bạn là #' + orderId,
                confirmButtonColor: '#6F4E37',
                confirmButtonText: 'Xem đơn hàng'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'UserProfile.aspx';
                }
            });
        }
    </script>
</asp:Content>