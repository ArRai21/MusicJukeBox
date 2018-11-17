create schema tamal

create table tamal.Customer
(
	CustomerID int  primary key,
	CustName varchar(20) not null,
	Address varchar(50) not null,
	DOB date not null,
	City varchar(10) not null,
	Password varchar(15) not null,
	MobileNo varchar(20) not null
)


create table tamal.Employee
(
	EmployeeID int  primary key,
	EmpName varchar(20) unique not null,
	Address varchar(50) not null,
	DOB date not null,
	City varchar(10) not null,
	Password varchar(15) not null,
	MobileNo int not null
	)
	create table tamal.Employee1
(
	EmployeeID int  primary key,
	EmpName varchar(20) unique not null,
	Address varchar(50) not null,
	DOB datetime not null,
	City varchar(10) not null,
	Password varchar(15) not null,
	MobileNo int not null
	)


	create table tamal.MusicOrder
	(
		OrderID int identity(1,1) primary key,
		OrderDate date not null,
		DeliveryDate date not null,
		OdrPaymentID  int  not null,
		EmployeeID  int foreign key references tamal.Employee(EmployeeID),
		CustomerID int foreign key references tamal.Customer(CustomerID),
	)

	create table tamal.Payment
	(
		PaymentID int identity(1,1) primary key,
		PayAccName varchar(20) not null,
		PayOrderID int not null,
		PaymentDate date not null,
		Amount money not null,
		PaymentMethod varchar(10) not null
		)

		create table tamal.MusicOrderDetails
		(
			MusicOrderID int identity(1,1) primary key,
			AlbumID int not null foreign key references tamal.Album(AlbumID),
			UnitPrice money not null,
			Qty int not null,
			Discount numeric(2,2) not null,
			PaymentID int not null foreign key references tamal.Payment(PaymentID),
			TotAmount money not null
		)
		create table tamal.Album
		(
			AlbumID int identity(1,1) primary key,
			AlbumName varchar(20) not null,
			Category varchar(20) not null,
			No_Of_Songs int not null,
			[Release Date] date not null,
			Company varchar(20) not null,
			Price money not null,
			Language varchar(20) not null
		)

		create table tamal.Songs
		(
			SongID int identity(1,1) primary key,
			SongName varchar(20) not null,
			Singer varchar(20) not null,
			Movie varchar(20) not null,
			ComposedBy varchar(20) not null,
			Lyrics varchar(20) not null,
			Year int not null,
			AlbumID int not null foreign key references tamal.Album(AlbumID),
			Language varchar(20) not null
		)

alter proc tamal.AddCust(@cid int,@cname varchar(20),@addr varchar(50),@dob date,@city varchar(20),@pass varchar(15),@mobile varchar(20))
as
	begin
		insert into tamal.Customer values(@cid,@cname,@addr,@dob,@city,@pass,@mobile)
		
	end

 delete from tamal.Customer

 select * from tamal.Customer

 alter proc tamal.LoginCust(@cid int,@pass varchar(15))
 as
 begin
  select count(*) from tamal.Customer where CustomerID=@cid and Password=@pass
  end

alter proc tamal.AddEmp(@eid int,@ename varchar(20),@addr varchar(50),@dob datetime,@city varchar(20),@pass varchar(15),@mobile varchar(20))
as
	begin
		insert into tamal.Employee1 values(@eid,@ename,@addr,@dob,@city,@pass,@mobile)
		
	end

	select * from tamal.Employee1

	create proc tamal.LoginEmp(@eid int,@pass varchar(15))
 as
 begin
  select count(*) from tamal.Employee where EmployeeID=@eid and Password=@pass
  end

  create proc tamal.SearchCust(@cid int)
	as
		begin
			select count(*) from tamal.Customer where CustomerID=@cid
		end

	create proc tamal.SearchEmp(@eid int)
	as
		begin
			select count(*) from tamal.Employee where EmployeeID=@eid
		end

	create proc tamal.UpCust(@cid int,@cname varchar(20),@addr varchar(50),@dob date,@city varchar(20),@pass varchar(15),@mobile varchar(20))
	as
	begin
		update tamal.Customer set CustomerID=@cid,CustName=@cname,Address=@addr,DOB=@dob,City=@city,Password=@pass,MobileNo=@mobile where CustomerID=@cid
	end

	create proc tamal.UpEmp(@eid int,@ename varchar(20),@addr varchar(50),@dob date,@city varchar(20),@pass varchar(15),@mobile varchar(20))
	as
	begin
		update tamal.Employee set EmployeeID=@eid,EmpName=@ename,Address=@addr,DOB=@dob,City=@city,Password=@pass,MobileNo=@mobile where EmployeeID=@eid
	end

	create proc tamal.SearchAlbumbyYear(@year int)
	as
	begin
		select * from tamal.Album where Datepart(yyyy,[Release Date])=@year
	end

	create proc tamal.SearchAlbumbySinger(@singer varchar(20))
		as
			begin 
				select * from tamal.Album where AlbumID = (select AlbumID from tamal.Songs where Singer=@singer)
		end

	create proc tamal.SearchSongbySinger(@singer varchar(20))
	as
	begin
		select * from tamal.Songs where Singer=@singer
	end

	create proc tamal.SearchSongbyComposer(@composer varchar(20))
	as
	begin
		select * from tamal.Songs where ComposedBy=@composer
	end

	create proc tamal.SearchSongbyGenre(@genre varchar(20))
	as
	begin
		select * from tamal.Songs where Lyrics=@genre
	end

	

	create proc tamal.AddAlbum(@id int,@name varchar(20),@category varchar(20),@songs int,@date date,@company varchar(20),@price money,@language varchar(20))
		as
			begin
				insert into tamal.Album values(@id,@name,@category,@songs,@date,@company,@price,@language)
			end

	create proc tamal.ShowAlbum
		as
			begin 
				select * from tamal.Album
			end

		create proc tamal.ShowUser
			as
				select * from tamal.Customer

		create proc tamal.ShowOrderDetails
			as 
				select * from tamal.MusicOrderDetails

		create proc tamal.deleteAlbum(@id int)
			as
				delete from tamal.Album where AlbumID=@id

		create proc tamal.deleteUser(@id int)
			as
				delete from tamal.Customer where CustomerID=@id

				
			MusicOrderID int identity(1,1) primary key,
			AlbumID int not null foreign key references tamal.Album(AlbumID),
			UnitPrice money not null,
			Qty int not null,
			Discount numeric(2,2) not null,
			PaymentID int not null foreign key references tamal.Payment(PaymentID),
			TotAmount money not null

	create proc tamal.UpOrderDetails(@mid int,@aid int,@price money,@qty int,@discount numeric(2,2),@pid int,@total money)
		as
			begin 
				update tamal.MusicOrderDetails set MusicOrderID=@mid,AlbumID=@aid,UnitPrice=@price,Qty=@qty,Discount=@discount,PaymentID=@pid,TotAmount=@total where MusicOrderID=@mid
			end