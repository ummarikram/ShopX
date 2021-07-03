CREATE DATABASE ShopX
GO
USE ShopX
GO

CREATE TABLE USERS
(
UserID INT Identity(1,1) primary key,
FirstName varchar(30)  not null,
LastName varchar(30)  not null,
Email varchar(30) not null,
[Password] varchar(10) not null,
City varchar(30) not null,
[Address] varchar(50),
Phone varchar(15) not null,
TotalOrders INT,
[Type] varchar(10) CHECK( Type = 'SELLER' OR Type = 'BUYER' )
)
GO

CREATE TABLE BUYERS
(
BuyerID int Identity(1,1) primary key,
UserID INT foreign key references [USERS](UserID),
CreditCard varchar(15)
)
GO

CREATE TABLE SELLERS
(
SellerID int Identity(1,1) primary key,
UserID INT foreign key references [USERS](UserID),
TotalProducts int not null,
Followers int not null
)
GO

CREATE TABLE CATEGORY
(
CategoryID INT Identity(1,1) primary key,
CategoryName varchar(15) CHECK( CategoryName = 'FASHION' OR CategoryName = 'ELECTRONICS' OR CategoryName = 'FOOD') not null,
)
GO

INSERT into CATEGORY(CategoryName) VALUES ('FASHION')
INSERT into CATEGORY(CategoryName) VALUES ('ELECTRONICS')
INSERT into CATEGORY(CategoryName) VALUES ('FOOD')


CREATE TABLE PRODUCTS
(
ProductID INT Identity(1,1) primary key,
ProductName varchar(30)  not null,
ProductDescription varchar(100)  not null,
ProductPrice int not null,
SellerID INT foreign key references [SELLERS](SellerID),
CatogeryID  INT foreign key references [CATEGORY](CategoryID),
Picture varchar(100) not null,
Ranking INT not null
)
GO

CREATE TABLE RANKING
(
ProductID INT foreign key references [PRODUCTS](ProductID),
BuyerID INT foreign key references [BUYERS](BuyerID),
Ranking INT not null
)
GO

CREATE TABLE ORDERS
(
OrderID INT Identity(1,1) primary key,
BuyerID INT foreign key references [BUYERS](BuyerID),
ProductID INT foreign key references [PRODUCTS](ProductID),
OrderDate DATE not null,
PaymentType varchar(5) CHECK( PaymentType = 'COD' OR PaymentType = 'CARD' ) not null,
OrderStatus varchar(15) CHECK( OrderStatus = 'Processing' OR 
								OrderStatus = 'Shipped'  OR
								OrderStatus = 'Delivered') not null
)
GO


CREATE TABLE CART
(
ProductID INT foreign key references [PRODUCTS](ProductID),
BuyerID INT foreign key references [BUYERS](BuyerID),
SellerID INT foreign key references [SELLERS](SellerID)
)
go


CREATE TABLE CHAT
(
Message varchar(100) not null,
Time datetime not null, 
BuyerID INT foreign key references [BUYERS](BuyerID),
SellerID INT foreign key references [SELLERS](SellerID),
SentBy varchar(10) not null CHECK( SentBy = 'SELLER' OR 
								SentBy = 'BUYER')
)
go

--PROCEDURE FOR LOGIN--
create procedure Login_Check
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
go

--PROCEDURE FOR SIGNUP--
go
create procedure Signup_Check
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
go


--PROCEDURE FOR REMOVE PRODUCT--
go
create procedure Remove_Product
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
go


--PROCEDURE FOR ADDING PRODUCT--
go
create procedure Add_Product
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
go


--PROCEDURE FOR UPDATE PRODUCT--
go
create procedure Update_Product
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
go


--PROCEDURE FOR ADDING TO CART--

go
create procedure Add_TO_Cart
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
go

-- PROCEDURE FOR REMOVING FROM CART--
go
create procedure RemoveFromCart
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
go


--PROCEDURE FOR GETTING SELLER ID--
go
create procedure Get_SellerID
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
go

--PROCEDURE FOR GETTING BUYER ID--
go
create procedure Get_BuyerID
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
go

--PROCEDURE FOR GETTING PRODUCT DETAILS--
go
create procedure ProductDetails
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
go
--PROCEDURE SEND MESSAGE--

go
create procedure SendMessage
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
go

--PROCEDURE FOR COUNT OF PRODUCTS BY SELLER

go
create procedure GetProductCount
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
go


--PROCEDURE FOR GIVING RANKING

go
create procedure GiveRanking
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
go

--VIEW FOR MY CART--
go
create view MyCart
as
select [PRODUCTS].ProductID,[PRODUCTS].ProductName,[CART].BuyerID ,[PRODUCTS].ProductPrice
from [CART] join [PRODUCTS] on [CART].ProductID = [PRODUCTS].ProductID
go



--PROCEDURE ON SELLER CHATBOX--
go
create procedure ShowAllBuyerNames
@SID int
as
select  FirstName + ' '+ LastName as BuyerName, BUYERS.BuyerID
from USERS join BUYERS on USERS.UserID = BUYERS.UserID join CHAT on CHAT.SellerID = @SID and CHAT.BuyerID = BUYERS.BuyerID 
group by FirstName + ' '+ LastName, BUYERS.BuyerID
go

--PROCEDURE FOR ON SELLER CHATBOX--

go
create procedure ShowBuyerName
@BID int
as
select  FirstName + ' '+ LastName as BuyerName
from USERS join BUYERS on USERS.UserID=BUYERS.UserID
where BUYERS.BuyerID=@BID
go





--PROCEDURE ON BUYERS CHATBOX--
go
create procedure ShowAllSellerNames
@BID int
as
select  FirstName + ' '+ LastName as SellerName, SELLERS.SellerID
from USERS join SELLERS on USERS.UserID = SELLERS.UserID join CHAT on CHAT.BuyerID = @BID and CHAT.SellerID = SELLERS.SellerID 
group by FirstName + ' '+ LastName, SELLERS.SellerID
go

--PROCEDURE ON BUYER CHATBOX--
go
create procedure ShowSellerName
@SID int
as
select  FirstName + ' '+ LastName as SellerName
from USERS join SELLERS on USERS.UserID=SELLERS.UserID
where SELLERS.SellerID=@SID
go

--PROCEDURE FOR SHOWING CONVERSATION--
go
create procedure ShowConversation
@SID int,
@BID int
as
select * from CHAT
where  SellerID=@SID and BuyerID=@BID
order by Time ASC
go

--PROCEDURE FOR SHOWING PRODUCTS IN SEARCH BAR--
go
create procedure ShowProducts
@PName varchar(30)
as
select top(4) ProductID,ProductName from PRODUCTS
where  ProductName like (@PName + '%')
go

--PROCEDURE FOR PLACING ORDER--
go
create procedure PlaceOrder
@BID int,
@PID int,
@PType varchar(5)
as
begin
	insert into ORDERS values(@BID,@PID,GETDATE(),@PType,'Processing')
end
go

--PROCEDURE FOR VIEWING ORDERS FOR BUYER--
go
create procedure GetOrdersForBuyer
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
go


--PROCEDURE FOR VIEWING ORDERS FOR SELLER--
go
create procedure GetOrdersForSeller
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
go

--PROCEDURE FOR UPDATING ORDER STATUS--
go
create procedure UpdateOrderStatus
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
go



Select * from USERS
Select * from SELLERS
Select * from BUYERS
Select * from CATEGORY
Select * from PRODUCTS
Select* from ORDERS
select * from MyCart
Select* from CHAT
Select* from RANKING
