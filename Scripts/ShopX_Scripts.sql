/****** Object:  Database [ShopX]    Script Date: 6/24/2021 11:14:39 PM ******/
CREATE DATABASE [ShopX]  (EDITION = 'Basic', SERVICE_OBJECTIVE = 'Basic', MAXSIZE = 2 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS;
GO
ALTER DATABASE [ShopX] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [ShopX] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShopX] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShopX] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShopX] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShopX] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShopX] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShopX] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShopX] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShopX] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShopX] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShopX] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShopX] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShopX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShopX] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [ShopX] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShopX] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ShopX] SET  MULTI_USER 
GO
ALTER DATABASE [ShopX] SET ENCRYPTION ON
GO
ALTER DATABASE [ShopX] SET QUERY_STORE = ON
GO
ALTER DATABASE [ShopX] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[PRODUCTS]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTS](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](30) NOT NULL,
	[ProductDescription] [varchar](100) NOT NULL,
	[ProductPrice] [int] NOT NULL,
	[SellerID] [int] NULL,
	[CatogeryID] [int] NULL,
	[Picture] [varchar](100) NOT NULL,
	[Ranking] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CART]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CART](
	[ProductID] [int] NULL,
	[BuyerID] [int] NULL,
	[SellerID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MyCart]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[MyCart]
as
select [PRODUCTS].ProductID,[PRODUCTS].ProductName,[CART].BuyerID ,[PRODUCTS].ProductPrice
from [CART] join [PRODUCTS] on [CART].ProductID = [PRODUCTS].ProductID
GO
/****** Object:  Table [dbo].[BUYERS]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BUYERS](
	[BuyerID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[CreditCard] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[BuyerID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHAT]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHAT](
	[Message] [varchar](100) NOT NULL,
	[Time] [datetime] NOT NULL,
	[BuyerID] [int] NULL,
	[SellerID] [int] NULL,
	[SentBy] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERS]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[BuyerID] [int] NULL,
	[ProductID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[PaymentType] [varchar](5) NOT NULL,
	[OrderStatus] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RANKING]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RANKING](
	[ProductID] [int] NULL,
	[BuyerID] [int] NULL,
	[Ranking] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SELLERS]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SELLERS](
	[SellerID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[TotalProducts] [int] NOT NULL,
	[Followers] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SellerID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[Password] [varchar](10) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](15) NOT NULL,
	[TotalOrders] [int] NULL,
	[Type] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BUYERS]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[USERS] ([UserID])
GO
ALTER TABLE [dbo].[CART]  WITH CHECK ADD FOREIGN KEY([BuyerID])
REFERENCES [dbo].[BUYERS] ([BuyerID])
GO
ALTER TABLE [dbo].[CART]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[PRODUCTS] ([ProductID])
GO
ALTER TABLE [dbo].[CART]  WITH CHECK ADD FOREIGN KEY([SellerID])
REFERENCES [dbo].[SELLERS] ([SellerID])
GO
ALTER TABLE [dbo].[CHAT]  WITH CHECK ADD FOREIGN KEY([BuyerID])
REFERENCES [dbo].[BUYERS] ([BuyerID])
GO
ALTER TABLE [dbo].[CHAT]  WITH CHECK ADD FOREIGN KEY([SellerID])
REFERENCES [dbo].[SELLERS] ([SellerID])
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD FOREIGN KEY([BuyerID])
REFERENCES [dbo].[BUYERS] ([BuyerID])
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[PRODUCTS] ([ProductID])
GO
ALTER TABLE [dbo].[PRODUCTS]  WITH CHECK ADD FOREIGN KEY([CatogeryID])
REFERENCES [dbo].[CATEGORY] ([CategoryID])
GO
ALTER TABLE [dbo].[PRODUCTS]  WITH CHECK ADD FOREIGN KEY([SellerID])
REFERENCES [dbo].[SELLERS] ([SellerID])
GO
ALTER TABLE [dbo].[RANKING]  WITH CHECK ADD FOREIGN KEY([BuyerID])
REFERENCES [dbo].[BUYERS] ([BuyerID])
GO
ALTER TABLE [dbo].[RANKING]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[PRODUCTS] ([ProductID])
GO
ALTER TABLE [dbo].[SELLERS]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[USERS] ([UserID])
GO
ALTER TABLE [dbo].[CATEGORY]  WITH CHECK ADD CHECK  (([CategoryName]='FASHION' OR [CategoryName]='ELECTRONICS' OR [CategoryName]='FOOD'))
GO
ALTER TABLE [dbo].[CHAT]  WITH CHECK ADD CHECK  (([SentBy]='SELLER' OR [SentBy]='BUYER'))
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD CHECK  (([OrderStatus]='Processing' OR [OrderStatus]='Shipped' OR [OrderStatus]='Delivered'))
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD CHECK  (([PaymentType]='COD' OR [PaymentType]='CARD'))
GO
ALTER TABLE [dbo].[USERS]  WITH CHECK ADD CHECK  (([Type]='SELLER' OR [Type]='BUYER'))
GO
/****** Object:  StoredProcedure [dbo].[Add_Product]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Add_Product]
@PName varchar(30),
@PDesc varchar(100),
@PPrice int,
@PCat varchar(30),
@SID int,
@PPicture varchar(100),
@flag int output
as
begin
	declare @CID int
	set @CID = (select CATEGORY.CategoryID
				from CATEGORY 
				where CATEGORY.CategoryName = @PCat)

	if exists ( select * from PRODUCTS where [PRODUCTS].ProductName = @PName and [PRODUCTS].CatogeryID = @CID and [PRODUCTS].SellerID = @SID)
	 begin
		set @flag = 0
	 end
	else
	 begin
		set @flag = 1
		insert into PRODUCTS (ProductName, ProductDescription, CatogeryID, Ranking,SellerID, Picture, ProductPrice) VALUES (@PName, @PDesc, @CID,0, @SID, @PPicture, @PPrice)
		
		-- UPDATE TOTAL PRODUCTS FOR THAT SELLER
		update SELLERS
		set SELLERS.TotalProducts = SELLERS.TotalProducts + 1
		where SELLERS.SellerID = @SID

	 end
end
GO
/****** Object:  StoredProcedure [dbo].[Add_TO_Cart]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Add_TO_Cart]
@PID int,
@BID int,
@flag int output
as
begin
 if exists (select * from CART where CART.ProductID = @PID and CART.BuyerID=@BID)
	begin
	 set @flag = 0
	end
 else
	 begin
		set @flag = 1
		declare @SID int
		set @SID = (select PRODUCTS.SellerID from PRODUCTS
					where PRODUCTS.ProductID = @PID)
		insert into CART(ProductID,BuyerID,SellerID) VALUES (@PID,@BID, @SID)
	 end
end
GO
/****** Object:  StoredProcedure [dbo].[Get_BuyerID]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Get_BuyerID]
@email varchar(30),
@BID int output
as
begin
	if exists ( select * from USERS
				where USERS.Email = @email and USERS.Type = 'BUYER')
	begin
		
		set @BID = (select BUYERS.BuyerID from BUYERS
					JOIN USERS ON USERS.UserID = BUYERS.UserID
					where USERS.Email = @email and USERS.Type = 'BUYER')
	end
	else
		begin
			set @BID = 0
		end
end
GO
/****** Object:  StoredProcedure [dbo].[Get_SellerID]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Get_SellerID]
@email varchar(30),
@SID int output
as
begin
	if exists ( select * from USERS
				where USERS.Email = @email and USERS.Type = 'SELLER')
	begin
		
		set @SID = (select SELLERS.SellerID from SELLERS
					JOIN USERS ON USERS.UserID = SELLERS.UserID
					where USERS.Email = @email and USERS.Type = 'SELLER')
	end
	else
		begin
			set @SID = 0
		end
end
GO
/****** Object:  StoredProcedure [dbo].[GetOrdersForBuyer]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetOrdersForBuyer]
@BID int
as
begin
if exists (select * from BUYERS where BuyerID = @BID)
	begin
		select ORDERS.OrderID, ProductName, ProductPrice, ORDERS.OrderStatus
		from ORDERS join PRODUCTS on ORDERS.ProductID = PRODUCTS.ProductID
		where ORDERS.BuyerID = @BID
	end
end
GO
/****** Object:  StoredProcedure [dbo].[GetOrdersForSeller]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetOrdersForSeller]
@SID int
as
begin
if exists (select * from SELLERS where SellerID = @SID)
	begin
		select ORDERS.OrderID, ProductName, ProductPrice, ORDERS.OrderStatus
		from ORDERS join PRODUCTS on ORDERS.ProductID = PRODUCTS.ProductID
		where PRODUCTS.SellerID = @SID
	end
end
GO
/****** Object:  StoredProcedure [dbo].[GetProductCount]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductCount]
@email varchar(30),
@Count int out
as
begin
	
	declare @UID int
	set @UID = (select USERS.UserID 
				from USERS
				where USERS.Email = @email)
	
	set @Count = (select SELLERS.TotalProducts
					from SELLERS
					where SELLERS.UserID = @UID)

end
GO
/****** Object:  StoredProcedure [dbo].[GiveRanking]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GiveRanking]
@PID int,
@BID int,
@RANK int
as
begin
	if exists (select * from RANKING where ProductID= @PID and BuyerID =@BID)
		begin
			
			update RANKING
			set Ranking=@RANK
			where ProductID= @PID and BuyerID =@BID

			declare @Total int
			set @Total = (select sum(Ranking) from RANKING
							where ProductID= @PID)

			declare @Count int
			set @Count = (select count(*) from RANKING
							where ProductID= @PID)
			
			declare @Avg int
			set @Avg = @Total / @Count

			update PRODUCTS
			set Ranking = @Avg
			where ProductID = @PID

		end
	else
		begin
			Insert into RANKING values(@PID,@BID,@RANK)

			set @Total = (select sum(Ranking) from RANKING
							where ProductID= @PID)

			set @Count = (select count(*) from RANKING
							where ProductID= @PID)
			
			set @Avg = @Total / @Count

			update PRODUCTS
			set Ranking = @Avg
			where ProductID = @PID

		end
end
GO
/****** Object:  StoredProcedure [dbo].[Login_Check]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--PROCEDURE FOR LOGIN--
create procedure [dbo].[Login_Check]
@email varchar(30),
@password varchar(10),
@flag int output
as
begin
	if exists ( select * from USERS where  [USERS].Email = @email and  [USERS].[Password] = @password )
	 begin
		set @flag = 1
	 end
	else
	 begin
		set @flag = 0
		print 'Invalid Email or Passward'
	 end
end
GO
/****** Object:  StoredProcedure [dbo].[PlaceOrder]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PlaceOrder]
@BID int,
@PID int,
@PType varchar(5)
as
begin
	insert into ORDERS values(@BID,@PID,GETDATE(),@PType,'Processing')
end
GO
/****** Object:  StoredProcedure [dbo].[ProductDetails]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ProductDetails]
@PID int,
@PName varchar(20) output,
@PDesc varchar(100) output,
@PPrice int output
as
begin
	set @PName = (select ProductName from PRODUCTS
					where ProductID = @PID)
set @PDesc = (select ProductDescription from PRODUCTS
					where ProductID = @PID)
		set @PPrice = (select ProductPrice from PRODUCTS
		where ProductID = @PID)
end
GO
/****** Object:  StoredProcedure [dbo].[Remove_Product]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Remove_Product]
@id int,
@PrevPicture varchar(100) output,
@flag int output
as
begin
	if exists ( select * from PRODUCTS where [PRODUCTS].ProductID = @id)
	 begin
		set @flag = 1

		declare @SID int

		set @SID = (select [PRODUCTS].SellerID from PRODUCTS
					where [PRODUCTS].ProductID = @id)
		
		set @PrevPicture = (select Picture from PRODUCTS
							where [PRODUCTS].ProductID = @id)
        delete from CART
		where CART.ProductID = @id

		delete from PRODUCTS
		where [PRODUCTS].ProductID = @id

		-- UPDATE TOTAL PRODUCTS FOR THAT SELLER
		update SELLERS
		set SELLERS.TotalProducts = SELLERS.TotalProducts - 1
		where SELLERS.SellerID = @SID

		
	 end
	else
	 begin
		set @PrevPicture = ''
		set @flag = 0
	 end
end
GO
/****** Object:  StoredProcedure [dbo].[RemoveFromCart]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveFromCart]
@PID int,
@BID int,
@flag int output
as
begin
	if exists (select * from CART 
				where CART.ProductID = @PID and CART.BuyerID = @BID)
		begin
			set @flag = 1

			delete from CART
			where CART.ProductID = @PID and CART.BuyerID = @BID

		end
	else
		begin
			set @flag = 0
		end
end
GO
/****** Object:  StoredProcedure [dbo].[SendMessage]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SendMessage]
@Message varchar(100),
@BID int,
@SID int,
@SentBy varchar(10),
@flag int output
as
begin
	if exists (select * from BUYERS where BuyerID = @BID)
		begin
			if exists (select * from SELLERS where SellerID = @SID)
				begin
					set @flag = 1
					insert into CHAT values(@Message,GETDATE(),@BID,@SID,@SentBy)
				end
			else
				begin
				set @flag = 0
				end
		end
	else
		begin
			set @flag = 0
		end
end
GO
/****** Object:  StoredProcedure [dbo].[ShowAllBuyerNames]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowAllBuyerNames]
@SID int
as
select  FirstName + ' '+ LastName as BuyerName, BUYERS.BuyerID
from USERS join BUYERS on USERS.UserID = BUYERS.UserID join CHAT on CHAT.SellerID = @SID and CHAT.BuyerID = BUYERS.BuyerID 
group by FirstName + ' '+ LastName, BUYERS.BuyerID
GO
/****** Object:  StoredProcedure [dbo].[ShowAllSellerNames]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowAllSellerNames]
@BID int
as
select  FirstName + ' '+ LastName as SellerName, SELLERS.SellerID
from USERS join SELLERS on USERS.UserID = SELLERS.UserID join CHAT on CHAT.BuyerID = @BID and CHAT.SellerID = SELLERS.SellerID 
group by FirstName + ' '+ LastName, SELLERS.SellerID
GO
/****** Object:  StoredProcedure [dbo].[ShowBuyerName]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowBuyerName]
@BID int
as
select  FirstName + ' '+ LastName as BuyerName
from USERS join BUYERS on USERS.UserID=BUYERS.UserID
where BUYERS.BuyerID=@BID
GO
/****** Object:  StoredProcedure [dbo].[ShowConversation]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowConversation]
@SID int,
@BID int
as
select * from CHAT
where  SellerID=@SID and BuyerID=@BID
order by Time ASC
GO
/****** Object:  StoredProcedure [dbo].[ShowProducts]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowProducts]
@PName varchar(30)
as
select top(4) ProductID,ProductName from PRODUCTS
where  ProductName like (@PName + '%')
GO
/****** Object:  StoredProcedure [dbo].[ShowSellerName]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowSellerName]
@SID int
as
select  FirstName + ' '+ LastName as SellerName
from USERS join SELLERS on USERS.UserID=SELLERS.UserID
where SELLERS.SellerID=@SID
GO
/****** Object:  StoredProcedure [dbo].[Signup_Check]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Signup_Check]
@firstaname varchar(30),
@lastaname varchar(30),
@email varchar(30),
@password varchar(10),
@City varchar(30),
@Phone varchar(15),
@type varchar(10),
@flag int output
as
begin
	--IF USER ALREADY EXISTS THEN SET FLAG = 0
	if exists ( select * from USERS where  [USERS].Email = @email)
	 begin	
		set @flag = 0
		print 'Insert Invalid'
	 end
	else
	 begin		
		set @flag = 1

		--INSERT THE NEW USER AND SET FLAG = 1
		INSERT [dbo].USERS([FirstName], [LastName],[Email],[Password],[City],[Phone],[Type],[TotalOrders])
		values (@firstaname,@lastaname,@email,@password,@City,@Phone,@type,0)

		declare @UID int

		--CHECK NEW USER TYPE AND ADD ACCORDINGLY
		if exists (select * from USERS where  [USERS].Email = @email and [USERS].Type = 'SELLER')
			begin
			set @UID = (select [USERS].UserID from USERS where  [USERS].Email = @email and [USERS].Type = 'SELLER')
			insert into SELLERS(UserID,TotalProducts,Followers) VALUES (@UID,0,0)
			end
		else
			begin
			set @UID = (select [USERS].UserID from USERS where  [USERS].Email = @email and [USERS].Type = 'BUYER')
			insert into BUYERS(UserID) VALUES (@UID)
			end
		print 'User Inserted'	
	 end
end
GO
/****** Object:  StoredProcedure [dbo].[Update_Product]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Update_Product]
@id int,
@PName varchar(30),
@PDesc varchar(100),
@PPrice int,
@PCat varchar(30),
@PPicture varchar(100),
@PrevPicture varchar(100) output,
@flag int output
as
begin
	if exists ( select * from PRODUCTS where [PRODUCTS].ProductID = @id)
	 begin
		set @flag = 1

		declare @CID int
		set @CID = (select CATEGORY.CategoryID
					from CATEGORY 
					where CATEGORY.CategoryName = @PCat)
		
		set @PrevPicture = (select Picture from PRODUCTS
							where [PRODUCTS].ProductID = @id)

		update PRODUCTS
		set ProductName=@PName, ProductDescription=@PDesc, ProductPrice = @PPrice, CatogeryID=@CID,Picture=@PPicture
		where [PRODUCTS].ProductID = @id

	 end
	else
	 begin
		set @PrevPicture = ''
		set @flag = 0
	 end
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 6/24/2021 11:14:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateOrderStatus]
@OID int,
@Status varchar(15)
as
begin
	if exists (select * from ORDERS where OrderID = @OID)
		begin
			Update ORDERS
			set OrderStatus=@Status
			where OrderID = @OID
		end
end
GO
ALTER DATABASE [ShopX] SET  READ_WRITE 
GO
