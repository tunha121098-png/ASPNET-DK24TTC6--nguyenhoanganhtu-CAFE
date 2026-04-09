/* 
   FILE: db_coffee.sql
   Mô tả: Khởi tạo CSDL cho hệ thống Shop Coffee Management
   Database: ShopCoffeeDB
*/

USE master;
GO

-- Xóa database cũ nếu tồn tại
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ShopCoffeeDB')
BEGIN
    DROP DATABASE ShopCoffeeDB;
END
GO

CREATE DATABASE ShopCoffeeDB;
GO

USE ShopCoffeeDB;
GO

-- 1. Bảng Users (Người dùng & Admin)
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Role NVARCHAR(20) DEFAULT 'User', -- 'Admin' hoặc 'User'
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 2. Bảng Categories (Danh mục sản phẩm)
CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL
);

-- 3. Bảng Products (Menu trà, cà phê...)
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    CategoryId INT REFERENCES Categories(CategoryId),
    ProductName NVARCHAR(200) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    Description NVARCHAR(MAX),
    ImageUrl NVARCHAR(500),
    IsAvailable BIT DEFAULT 1
);

-- 4. Bảng Tables (Quản lý bàn quán)
CREATE TABLE Tables (
    TableId INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(50) NOT NULL,
    Status NVARCHAR(50) DEFAULT N'Trống' -- 'Trống', 'Đang có khách'
);

-- 5. Bảng Orders (Đơn đặt hàng)
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT REFERENCES Users(UserId),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2),
    Status NVARCHAR(50) DEFAULT N'Chờ xác nhận', -- 'Đã xác nhận', 'Đã hủy', 'Hoàn thành'
    Note NVARCHAR(500)
);

-- 6. Bảng OrderDetails (Chi tiết đơn hàng)
CREATE TABLE OrderDetails (
    OrderDetailId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT REFERENCES Orders(OrderId),
    ProductId INT REFERENCES Products(ProductId),
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL
);

-- 7. Bảng Bookings (Đặt bàn trực tuyến)
CREATE TABLE Bookings (
    BookingId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT REFERENCES Users(UserId),
    TableId INT REFERENCES Tables(TableId),
    BookingTime DATETIME NOT NULL,
    Status NVARCHAR(50) DEFAULT N'Chờ duyệt' -- 'Đã duyệt', 'Đã hủy'
);

-----------------------------------------------------------
-- CHÈN DỮ LIỆU MẪU
-----------------------------------------------------------

-- 1. Tài khoản mẫu (Admin: admin/123, User: user/123)
-- Lưu ý trong thực tế nên SHA1 password
INSERT INTO Users (Username, Password, FullName, Email, Role) VALUES 
('admin', '123', N'Quản trị viên', 'admin@coffee.com', 'Admin'),
('user', '123', N'Khách hàng 01', 'khach01@gmail.com', 'User');

-- 2. Danh mục mẫu
INSERT INTO Categories (CategoryName) VALUES 
(N'Cà phê'), (N'Trà sữa'), (N'Bạc xỉu'), (N'Trà đào'), (N'Đồ ăn nhẹ');

-- 3. Sản phẩm mẫu
INSERT INTO Products (CategoryId, ProductName, Price, Description, ImageUrl) VALUES 
(1, N'Cà phê đen', 25000, N'Cà phê truyền thống đậm đà.', 'coffee_den.jpg'),
(1, N'Cà phê sữa', 29000, N'Cà phê sữa thơm ngon.', 'coffee_sua.jpg'),
(2, N'Trà sữa Trân châu', 45000, N'Trà sữa truyền thống kèm trân châu đen.', 'milktea.jpg'),
(3, N'Bạc xỉu đá', 32000, N'Bạc xỉu 3 tầng đẹp mắt.', 'bacxiu.jpg'),
(4, N'Trà đào cam sả', 40000, N'Trà thanh mát cho mùa hè.', 'peach_tea.jpg');

-- 4. Bàn mẫu
INSERT INTO Tables (TableName) VALUES 
(N'Bàn 01'), (N'Bàn 02'), (N'Bàn 03'), (N'Bàn 04'), (N'Bàn 05'),
(N'Bàn 06'), (N'Bàn 07'), (N'Bàn 08'), (N'VIP 01'), (N'VIP 02');

GO
PRINT 'Database ShopCoffeeDB installed successfully with sample data.';
