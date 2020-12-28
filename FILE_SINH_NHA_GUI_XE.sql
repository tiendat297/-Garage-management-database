/****** Object:  UserDefinedFunction [dbo].[KIEM_TRA_XE]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[KIEM_TRA_XE](@bienso nvarchar(25), @mavenhap nvarchar(25))
returns nvarchar(50)
as
begin
declare @thongbao nvarchar(50);
declare @mave nvarchar(25);
 select @mave = mave from xevaora where bienso = @bienso and trangthai = '0';
 if @mave = @mavenhap
   begin
      set  @thongbao = N'Thông tin xe đúng, mời thanh toán'
      return @thongbao;
   end
 else 
     
       set @thongbao = N'Sai xe hoặc sai vé, mời quay lại'
       return @thongbao;
      
  end
GO
/****** Object:  UserDefinedFunction [dbo].[So_Cho_Trong]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[So_Cho_Trong](@vitri nvarchar(25))
returns int
as
begin
Declare @chotrong int
DECLARE @i INT
set @i = (select soxemax from vitri where vitri = @vitri);
set @chotrong = (select @i - count(bienso) from xevaora where vitri = @vitri and trangthai = '0')
return @chotrong
end
GO
/****** Object:  UserDefinedFunction [dbo].[THU_TAI_KHOAN]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[THU_TAI_KHOAN](@VITRI NVARCHAR(25),@NGAY DATE)
RETURNS INT AS
BEGIN 
DECLARE @TONGTIEN INT
select @TONGTIEN = sum(giangay + gia_qua_dem)  from xe_da_tt where matt = 'tk'
RETURN @TONGTIEN
END
GO
/****** Object:  UserDefinedFunction [dbo].[THU_TIEN_MAT]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[THU_TIEN_MAT](@VITRI NVARCHAR(25), @NGAY DATE)
RETURNs int as
begin
declare @I int
select @I = sum(giangay + gia_qua_dem)  from xe_da_tt where matt = 'tm' and CONVERT(date, giora) =  @NGAY
  RETURN @I

end
GO
/****** Object:  UserDefinedFunction [dbo].[TONG_THU_CA_NAM]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[TONG_THU_CA_NAM](@nam int, @vitri nvarchar(25))
returns int as
begin
declare @tien int
select @tien = sum(giangay + gia_qua_dem)  from xe_da_tt where year(giora) = @nam and vitri = @vitri
return @tien
end
GO
/****** Object:  Table [dbo].[BANGGIA]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGGIA](
	[Maloaixe] [nvarchar](25) NOT NULL,
	[Matt] [nchar](10) NOT NULL,
	[Giangay] [money] NOT NULL,
	[Giaquadem] [money] NOT NULL,
 CONSTRAINT [PK_Banggia] PRIMARY KEY CLUSTERED 
(
	[Maloaixe] ASC,
	[Matt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONGVIEC]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONGVIEC](
	[MaCV] [nchar](10) NOT NULL,
	[TenCV] [nvarchar](25) NOT NULL,
	[Mota] [nvarchar](50) NOT NULL,
	[Mucluong] [money] NOT NULL,
 CONSTRAINT [PK_Congviec] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTSUCO]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTSUCO](
	[MaSC] [nchar](10) NOT NULL,
	[TenSC] [nvarchar](50) NULL,
	[GiaiPhap] [nvarchar](100) NULL,
 CONSTRAINT [PK_CTSUCO] PRIMARY KEY CLUSTERED 
(
	[MaSC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTTHIETBI]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTTHIETBI](
	[MaTB] [char](10) NOT NULL,
	[TenTB] [nvarchar](25) NOT NULL,
	[NhaCC] [nvarchar](25) NULL,
	[Gia] [money] NULL,
 CONSTRAINT [PK_CTThietBi] PRIMARY KEY CLUSTERED 
(
	[MaTB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HAOHUT]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HAOHUT](
	[Vitri] [nvarchar](25) NOT NULL,
	[MaTB] [char](10) NOT NULL,
	[NgayHH] [nchar](10) NOT NULL,
	[SLHH] [int] NULL,
 CONSTRAINT [PK_HAOHUT] PRIMARY KEY CLUSTERED 
(
	[Vitri] ASC,
	[MaTB] ASC,
	[NgayHH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAIXE]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAIXE](
	[MaLoaiXe] [nvarchar](25) NOT NULL,
	[Kieuxe] [nvarchar](25) NULL,
	[Tenxe] [nvarchar](25) NULL,
	[Dientich] [float] NULL,
 CONSTRAINT [PK_Loaixe] PRIMARY KEY CLUSTERED 
(
	[MaLoaiXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NGUOIDUNG]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NGUOIDUNG](
	[Manv] [char](8) NOT NULL,
	[Password] [text] NOT NULL,
	[level] [text] NULL,
 CONSTRAINT [PK_LoginHethong] PRIMARY KEY CLUSTERED 
(
	[Manv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nhanvien]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhanvien](
	[Manv] [char](8) NOT NULL,
	[Hoten] [nvarchar](25) NOT NULL,
	[Diachi] [nvarchar](50) NULL,
	[Gioitinh] [nvarchar](25) NULL,
	[vitri] [nvarchar](25) NOT NULL,
	[MaCV] [nchar](10) NULL,
 CONSTRAINT [PK_Nhanvien] PRIMARY KEY CLUSTERED 
(
	[Manv] ASC,
	[vitri] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PTTHANHTOAN]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PTTHANHTOAN](
	[Matt] [nchar](10) NOT NULL,
	[Hinhthuc] [nvarchar](25) NULL,
	[Mota] [nvarchar](50) NULL,
 CONSTRAINT [PK_PTTHANHTOAN] PRIMARY KEY CLUSTERED 
(
	[Matt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUCO]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUCO](
	[Ngay] [datetime] NOT NULL,
	[Bienso] [nvarchar](50) NOT NULL,
	[MaSC] [nchar](10) NOT NULL,
	[Vitri] [nvarchar](25) NULL,
	[Tenxe] [nvarchar](25) NULL,
	[Mota] [nvarchar](100) NULL,
	[TenKH] [nvarchar](25) NULL,
	[Denbu] [money] NOT NULL,
	[Manv] [char](8) NULL,
 CONSTRAINT [PK_SUCO] PRIMARY KEY CLUSTERED 
(
	[Bienso] ASC,
	[MaSC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANGTHIETBI]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANGTHIETBI](
	[Vitri] [nvarchar](25) NOT NULL,
	[MaTB] [char](10) NOT NULL,
	[Soluong] [int] NOT NULL,
	[Donvi] [nvarchar](20) NULL,
 CONSTRAINT [PK_Trangthietbi] PRIMARY KEY CLUSTERED 
(
	[Vitri] ASC,
	[MaTB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VEGUI]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VEGUI](
	[Mave] [nvarchar](25) NOT NULL,
	[Vitri] [nvarchar](25) NULL,
 CONSTRAINT [PK_VEGUI] PRIMARY KEY CLUSTERED 
(
	[Mave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENV]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENV](
	[Mave] [nvarchar](25) NOT NULL,
	[TenNV] [nvarchar](25) NULL,
	[Phongban] [nvarchar](25) NULL,
 CONSTRAINT [PK_VENV] PRIMARY KEY CLUSTERED 
(
	[Mave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VETK]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VETK](
	[Mave] [nvarchar](25) NOT NULL,
	[Maloaixe] [nvarchar](25) NULL,
	[TenChuVe] [nvarchar](25) NULL,
	[Diachi] [nvarchar](25) NULL,
	[STK] [text] NULL,
 CONSTRAINT [PK_VETK] PRIMARY KEY CLUSTERED 
(
	[Mave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VITRI]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VITRI](
	[Vitri] [nvarchar](25) NOT NULL,
	[Tenvitri] [nvarchar](25) NULL,
	[Mota] [nvarchar](25) NULL,
	[Soxemax] [int] NULL,
	[Dientich] [int] NULL,
 CONSTRAINT [PK_Vitri] PRIMARY KEY CLUSTERED 
(
	[Vitri] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XeMatVe]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XeMatVe](
	[Bienso] [nvarchar](50) NOT NULL,
	[Tenchuxe] [nvarchar](25) NOT NULL,
	[DiaChi] [nvarchar](25) NOT NULL,
	[SoCMT] [text] NOT NULL,
	[MaLoaixe] [char](10) NOT NULL,
	[Tenxe] [nvarchar](25) NOT NULL,
	[Mau] [nvarchar](25) NOT NULL,
	[Dungtich] [int] NOT NULL,
	[Thoigian] [datetime] NOT NULL,
	[Vitri] [nvarchar](25) NULL,
 CONSTRAINT [PK_XeMatVe] PRIMARY KEY CLUSTERED 
(
	[Bienso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XEVAORA]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XEVAORA](
	[STT] [int] IDENTITY(1,1) NOT NULL,
	[Bienso] [nvarchar](50) NOT NULL,
	[Mave] [nvarchar](25) NOT NULL,
	[Maloaixe] [nvarchar](25) NULL,
	[Giovao] [datetime] NOT NULL,
	[Giora] [datetime] NULL,
	[Vitri] [nvarchar](25) NOT NULL,
	[Trangthai] [nvarchar](25) NOT NULL,
	[Matt] [nchar](10) NULL,
 CONSTRAINT [PK_Xevaora_1] PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[XE_DA_TT]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[XE_DA_TT] as select bienso,xevaora.mave,xevaora.maloaixe,giovao,giora,vitri, DATEDIFF(DD, giovao, giora) AS SoNgay,giangay,DATEDIFF(DD, giovao, giora)* giaquadem as Gia_Qua_dem,trangthai, xevaora.matt from xevaora inner join Banggia on xevaora.Maloaixe = Banggia.Maloaixe
where xevaora.matt = banggia.matt and xevaora.matt in('tm','tk')
GO
/****** Object:  UserDefinedFunction [dbo].[Tong_tien_Thu]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Tong_tien_Thu](@Ngay date)
returns table
as 
return select vitri,sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu  from xe_da_tt 
where CONVERT(date, giora) =  @Ngay  group by vitri
GO
/****** Object:  UserDefinedFunction [dbo].[So_xe_chua_lay]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[So_xe_chua_lay]()
returns table
as
return select xevaora.vitri,maloaixe, (count(xevaora.bienso)) as so_xe_chua_lay from xevaora 
where  trangthai = '0' group by xevaora.vitri,maloaixe
GO
/****** Object:  UserDefinedFunction [dbo].[SO_xe_hien_tai]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SO_xe_hien_tai]()
returns table as 
return select vitri,maloaixe,count(bienso) as Số_xe_đang_gửi from xevaora where trangthai = '0' group by vitri,maloaixe
GO
/****** Object:  UserDefinedFunction [dbo].[Thiet_bi_hien_co]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Thiet_bi_hien_co]()
returns table as
return select Vitri,trangthietbi.matb,soluong,donvi,tenTB,Nhacc,gia, soluong * gia as tổng_giá_trị 
from trangthietbi inner join ctthietbi on trangthietbi.matb = ctthietbi.matb
GO
/****** Object:  UserDefinedFunction [dbo].[Tim_kiem_nhan_vien_trong_xe]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Tim_kiem_nhan_vien_trong_xe](@bienso nvarchar(25))
returns table as 

 return  select bienso, mave, giovao,giora,xevaora.vitri,manv,hoten from xevaora inner join Nhanvien on xevaora.vitri = nhanvien.vitri 
where bienso = @bienso and Macv = 'TX01'
GO
/****** Object:  UserDefinedFunction [dbo].[Tong_so_xe_da_lay_trong_ngay]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Tong_so_xe_da_lay_trong_ngay](@Ngay date)
 returns table as
 return select vitri,maloaixe,count(bienso) so_xe_da_lay from xevaora 
where trangthai ='1' and CONVERT(date, giora) =  @Ngay group by vitri,maloaixe 
GO
INSERT [dbo].[BANGGIA] ([Maloaixe], [Matt], [Giangay], [Giaquadem]) VALUES (N'OT', N'TK        ', 15000.0000, 25000.0000)
INSERT [dbo].[BANGGIA] ([Maloaixe], [Matt], [Giangay], [Giaquadem]) VALUES (N'OT        ', N'TM        ', 20000.0000, 30000.0000)
INSERT [dbo].[BANGGIA] ([Maloaixe], [Matt], [Giangay], [Giaquadem]) VALUES (N'XD', N'TK        ', 2000.0000, 4000.0000)
INSERT [dbo].[BANGGIA] ([Maloaixe], [Matt], [Giangay], [Giaquadem]) VALUES (N'XD        ', N'TM        ', 3000.0000, 5000.0000)
INSERT [dbo].[BANGGIA] ([Maloaixe], [Matt], [Giangay], [Giaquadem]) VALUES (N'XM', N'TK        ', 4000.0000, 6000.0000)
INSERT [dbo].[BANGGIA] ([Maloaixe], [Matt], [Giangay], [Giaquadem]) VALUES (N'XM        ', N'TM        ', 5000.0000, 7000.0000)
GO
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [Mota], [Mucluong]) VALUES (N'BT01      ', N'Bảo trì', N'Bảo trì các trang thiết bị nhà xe', 6000000.0000)
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [Mota], [Mucluong]) VALUES (N'BV01      ', N'Bảo vệ', N'Trông coi xe', 5000000.0000)
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [Mota], [Mucluong]) VALUES (N'LC01      ', N'Lao công', N'Vệ sinh các nhà xe', 4000000.0000)
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [Mota], [Mucluong]) VALUES (N'TX01      ', N'Trông xe ', N'Tại các cổng ra vào check biển số', 5000000.0000)
GO
INSERT [dbo].[CTSUCO] ([MaSC], [TenSC], [GiaiPhap]) VALUES (N'SC01      ', N'Mất xe', N'Lập biên bản người trông giữ xe, đền bù khách')
INSERT [dbo].[CTSUCO] ([MaSC], [TenSC], [GiaiPhap]) VALUES (N'SC02      ', N'Hỏng hóc xe', N'Đền bù nếu quá nặng')
INSERT [dbo].[CTSUCO] ([MaSC], [TenSC], [GiaiPhap]) VALUES (N'SC03      ', N'Mất mát thiết bị trên xe', N'Quá 200.000 đền bù ')
GO
INSERT [dbo].[CTTHIETBI] ([MaTB], [TenTB], [NhaCC], [Gia]) VALUES (N'BR        ', N'Barie', N'CTY thiết bị Sông Hồng', 200000.0000)
INSERT [dbo].[CTTHIETBI] ([MaTB], [TenTB], [NhaCC], [Gia]) VALUES (N'CMR       ', N'Camera', N'CTY thiết bị 3M', 1000000.0000)
INSERT [dbo].[CTTHIETBI] ([MaTB], [TenTB], [NhaCC], [Gia]) VALUES (N'MT        ', N'Máy Tính ', N'CTY Thiết bị 3M', 5000000.0000)
INSERT [dbo].[CTTHIETBI] ([MaTB], [TenTB], [NhaCC], [Gia]) VALUES (N'RC        ', N'Rào chắn', N'CTY Thiết bị Sông Hồng', 100000.0000)
GO
INSERT [dbo].[HAOHUT] ([Vitri], [MaTB], [NgayHH], [SLHH]) VALUES (N'B1', N'BR        ', N'2020-06-14', 2)
INSERT [dbo].[HAOHUT] ([Vitri], [MaTB], [NgayHH], [SLHH]) VALUES (N'B1', N'RC        ', N'2020-06-14', 5)
GO
INSERT [dbo].[LOAIXE] ([MaLoaiXe], [Kieuxe], [Tenxe], [Dientich]) VALUES (N'MT        ', N'Xe may', N'Xemay', 2)
INSERT [dbo].[LOAIXE] ([MaLoaiXe], [Kieuxe], [Tenxe], [Dientich]) VALUES (N'OT        ', N'Ô tô', N'Ô tô', 10)
INSERT [dbo].[LOAIXE] ([MaLoaiXe], [Kieuxe], [Tenxe], [Dientich]) VALUES (N'XD        ', N'Xe đạp', N'Xe đạp', 1.5)
GO
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1000  ', N'Mạc Tùng A', N'Hải Dương', N'Nam', N'D9', N'TX01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1001  ', N'Nguyễn Văn Đức', N'Hà Nội', N'Nam', N'D9', N'TX01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1002  ', N'Nguyễn Tiến Đạt', N'Hà Nội', N'Nam', N'D9', N'BT01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1003  ', N'Nguyễn Thị Huyền', N'Thái Nguyên', N'Nữ', N'D9', N'LC01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1004  ', N'Cao Đắc Anh Đức', N'Hà Nội', N'Nam', N'B10', N'TX01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1005  ', N'Từ Bảo Tươi', N'Hải Dương', N'Nữ', N'B10', N'BT01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1006  ', N'Thanh Sơn', N'Thanh Hóa', N'Nữ', N'B1', N'TX01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1007  ', N'Lê Quốc Đạt', N'Lào Cai', N'Nam', N'B1', N'TX01      ')
INSERT [dbo].[Nhanvien] ([Manv], [Hoten], [Diachi], [Gioitinh], [vitri], [MaCV]) VALUES (N'NV1008  ', N'Thanh Hằng', N'Thanh Hóa', N'nữ', N'B1', N'LC01      ')
GO
INSERT [dbo].[PTTHANHTOAN] ([Matt], [Hinhthuc], [Mota]) VALUES (N'TK        ', N'Tài Khoản', N'Thanh toán bằng tài khoản ')
INSERT [dbo].[PTTHANHTOAN] ([Matt], [Hinhthuc], [Mota]) VALUES (N'TM        ', N'Tiền mặt', N' Thanh toán bằng tiền mặt')
GO
INSERT [dbo].[SUCO] ([Ngay], [Bienso], [MaSC], [Vitri], [Tenxe], [Mota], [TenKH], [Denbu], [Manv]) VALUES (CAST(N'2020-06-16T09:00:00.000' AS DateTime), N'76-N01-3316', N'SC01      ', N'D9', N'Wave Honda 110cc', N'mất xe', N'Nguyễn Văn A', 5000000.0000, N'NV1000  ')
GO
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B1', N'BR        ', 8, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B1', N'CMR       ', 8, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B1', N'MT        ', 4, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B1', N'RC        ', 300, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B10', N'BR        ', 4, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B10', N'CMR       ', 2, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B10', N'MT        ', 1, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'B10', N'RC        ', 150, N'Tấm')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'D9', N'BR        ', 6, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'D9', N'CMR       ', 6, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'D9', N'MT        ', 2, N'Cái')
INSERT [dbo].[TRANGTHIETBI] ([Vitri], [MaTB], [Soluong], [Donvi]) VALUES (N'D9', N'RC        ', 200, N'Tấm')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10001', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10002', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10003', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10004', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10005', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10006', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10007', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10008', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10009', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1001', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10010', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10011', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10012', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10013', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10014', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10015', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10016', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10017', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10018', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10019', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1002', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10020', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10021', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10022', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10023', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10024', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10025', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10026', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10027', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10028', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10029', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1003', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10030', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10031', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10032', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10033', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10034', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10035', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10036', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10037', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10038', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10039', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1004', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10040', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10041', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10042', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10043', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10044', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10045', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10046', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10047', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10048', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10049', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1005', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10050', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10051', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10052', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10053', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10054', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10055', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10056', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10057', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10058', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10059', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1006', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10060', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10061', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10062', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10063', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10064', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10065', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10066', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10067', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10068', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10069', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1007', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10070', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10071', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10072', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10073', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10074', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10075', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10076', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10077', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10078', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10079', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1008', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10080', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10081', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10082', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10083', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10084', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10085', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10086', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10087', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10088', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10089', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1009', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10090', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10091', N'B10')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10092', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10093', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10094', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10095', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10096', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10097', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10098', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10099', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1010', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10100', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10101', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10102', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10103', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10104', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10105', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10106', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10107', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10108', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10109', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1011', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10110', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10111', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10112', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10113', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10114', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10115', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10116', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10117', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10118', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10119', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1012', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10120', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10121', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10122', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10123', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10124', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10125', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10126', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10127', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10128', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10129', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1013', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10130', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10131', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10132', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10133', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10134', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10135', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10136', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10137', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10138', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10139', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1014', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10140', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10141', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10142', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10143', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10144', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10145', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10146', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10147', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10148', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10149', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1015', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10150', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10151', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10152', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10153', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10154', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10155', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10156', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10157', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10158', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10159', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1016', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B10160', N'B10')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1017', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1018', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1019', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1020', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1021', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1022', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1023', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1024', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1025', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1026', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1027', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1028', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1029', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1030', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1031', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1032', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1033', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1034', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1035', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1036', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1037', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1038', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1039', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1040', N'B1')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1041', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1042', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1043', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1044', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1045', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1046', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1047', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1048', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1049', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1050', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1051', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1052', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1053', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1054', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1055', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1056', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1057', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1058', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1059', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1060', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1061', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1062', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1063', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1064', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1065', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1066', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1067', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1068', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1069', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1070', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1071', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1072', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1073', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1074', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1075', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1076', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1077', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1078', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1079', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1080', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1081', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1082', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1083', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1084', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1085', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1086', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1087', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1088', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1089', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1090', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1091', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1092', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1093', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1094', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1095', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1096', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1097', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1098', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1099', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1100', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1101', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1102', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1103', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1104', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1105', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1106', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1107', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1108', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1109', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1110', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1111', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1112', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1113', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1114', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1115', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1116', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1117', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1118', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1119', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1120', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1121', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1122', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1123', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1124', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1125', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1126', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1127', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1128', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1129', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1130', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1131', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1132', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1133', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1134', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1135', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1136', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1137', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1138', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1139', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1140', N'B1')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1141', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1142', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1143', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1144', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1145', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1146', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1147', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1148', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1149', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1150', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1151', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1152', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1153', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1154', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1155', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1156', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1157', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1158', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1159', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1160', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1161', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1162', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1163', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1164', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1165', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1166', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1167', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1168', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1169', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1170', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1171', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1172', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1173', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1174', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1175', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1176', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1177', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1178', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1179', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1180', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1181', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1182', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1183', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1184', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1185', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1186', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1187', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1188', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1189', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1190', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1191', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1192', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1193', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1194', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1195', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1196', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1197', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1198', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1199', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1200', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1201', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1202', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1203', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1204', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1205', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1206', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1207', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1208', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1209', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1210', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1211', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1212', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1213', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1214', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1215', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1216', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1217', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1218', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1219', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1220', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1221', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1222', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1223', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1224', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1225', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1226', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1227', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1228', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1229', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1230', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1231', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1232', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1233', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1234', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1235', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1236', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1237', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1238', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1239', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1240', N'B1')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1241', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1242', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1243', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1244', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1245', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1246', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1247', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1248', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1249', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1250', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1251', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1252', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1253', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1254', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1255', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1256', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1257', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1258', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1259', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1260', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1261', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1262', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1263', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1264', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1265', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1266', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1267', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1268', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1269', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1270', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1271', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1272', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1273', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1274', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1275', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1276', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1277', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1278', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1279', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1280', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1281', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1282', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1283', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1284', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1285', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1286', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1287', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1288', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1289', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1290', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1291', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1292', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1293', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1294', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1295', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1296', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1297', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1298', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1299', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1300', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1301', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1302', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1303', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1304', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1305', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1306', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1307', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1308', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'B1309', N'B1')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3001', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3002', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3003', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3004', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3005', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3006', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3007', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3008', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3009', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3010', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3011', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3012', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3013', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3014', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3015', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3016', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3017', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3018', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3019', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3020', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3021', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3022', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3023', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3024', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3025', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3026', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3027', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3028', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3029', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3030', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3031', N'D3')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3032', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3033', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3034', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3035', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3036', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3037', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3038', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3039', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3040', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3041', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3042', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3043', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3044', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3045', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3046', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3047', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3048', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3049', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3050', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3051', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3052', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3053', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3054', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3055', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3056', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3057', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3058', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3059', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3060', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3061', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3062', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3063', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3064', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3065', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3066', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3067', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3068', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3069', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3070', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3071', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3072', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3073', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3074', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3075', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3076', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3077', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3078', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3079', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3080', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3081', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3082', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3083', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3084', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3085', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3086', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3087', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3088', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3089', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3090', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3091', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3092', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3093', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3094', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3095', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3096', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3097', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3098', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3099', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3100', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3101', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3102', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3103', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3104', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3105', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3106', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3107', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3108', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3109', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3110', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3111', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3112', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3113', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3114', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3115', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3116', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3117', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3118', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3119', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3120', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3121', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3122', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3123', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3124', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3125', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3126', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3127', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3128', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3129', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3130', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3131', N'D3')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3132', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3133', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3134', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3135', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3136', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3137', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3138', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3139', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3140', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3141', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3142', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3143', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3144', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3145', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3146', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3147', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3148', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3149', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3150', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3151', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3152', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3153', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3154', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3155', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3156', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3157', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3158', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3159', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3160', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3161', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3162', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3163', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3164', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3165', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3166', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3167', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3168', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3169', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D3170', N'D3')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9001', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9002', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9003', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9004', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9005', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9006', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9007', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9008', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9009', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9010', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9011', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9012', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9013', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9014', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9015', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9016', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9017', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9018', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9019', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9020', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9021', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9022', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9023', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9024', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9025', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9026', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9027', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9028', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9029', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9030', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9031', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9032', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9033', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9034', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9035', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9036', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9037', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9038', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9039', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9040', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9041', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9042', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9043', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9044', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9045', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9046', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9047', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9048', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9049', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9050', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9051', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9052', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9053', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9054', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9055', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9056', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9057', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9058', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9059', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9060', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9061', N'D9')
GO
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9062', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9063', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9064', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9065', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9066', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9067', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9068', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9069', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9070', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9071', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9072', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9073', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9074', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9075', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9076', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9077', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9078', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9079', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9080', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9081', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9082', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9083', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9084', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9085', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9086', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9087', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9088', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9089', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9090', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9091', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9092', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9093', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9094', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9095', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9096', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9097', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9098', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9099', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9100', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9101', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9102', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9103', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9104', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9105', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9106', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9107', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9108', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9109', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9110', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9111', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9112', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9113', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9114', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9115', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9116', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9117', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9118', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9119', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9120', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9121', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9122', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9123', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9124', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9125', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9126', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9127', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9128', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9129', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9130', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9131', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9132', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9133', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9134', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9135', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9136', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9137', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9138', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9139', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9140', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9141', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9142', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9143', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9144', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9145', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9146', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9147', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9148', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9149', N'D9')
INSERT [dbo].[VEGUI] ([Mave], [Vitri]) VALUES (N'D9150', N'D9')
GO
INSERT [dbo].[VENV] ([Mave], [TenNV], [Phongban]) VALUES (N'NV01    ', N'Cao Đức', N'Đào Tạo')
INSERT [dbo].[VENV] ([Mave], [TenNV], [Phongban]) VALUES (N'NV02    ', N'Văn Tiến', N'Đào Tạo')
INSERT [dbo].[VENV] ([Mave], [TenNV], [Phongban]) VALUES (N'NV03    ', N'Lê chí Ngọc', N'Toán Tin')
GO
INSERT [dbo].[VETK] ([Mave], [Maloaixe], [TenChuVe], [Diachi], [STK]) VALUES (N'TK01    ', N'XM', N'Nguyễn Tiến Đạt', N'Hà Nội', N'001099018596')
INSERT [dbo].[VETK] ([Mave], [Maloaixe], [TenChuVe], [Diachi], [STK]) VALUES (N'TK02    ', N'XM', N'Nguyễn Thị Huyền', N'Hà Nam', N'0012345678')
INSERT [dbo].[VETK] ([Mave], [Maloaixe], [TenChuVe], [Diachi], [STK]) VALUES (N'TK03    ', N'OTO', N'Nguyễn Văn A', N'Nam Định', N'0454622649')
GO
INSERT [dbo].[VITRI] ([Vitri], [Tenvitri], [Mota], [Soxemax], [Dientich]) VALUES (N'B1', N'Nhà xe B1', N'Dưới chân nhà B1', 300, 200)
INSERT [dbo].[VITRI] ([Vitri], [Tenvitri], [Mota], [Soxemax], [Dientich]) VALUES (N'B10', N'Nhà xe KTX B10', N'Số 7 TQB', 150, 200)
INSERT [dbo].[VITRI] ([Vitri], [Tenvitri], [Mota], [Soxemax], [Dientich]) VALUES (N'D3', N'Nhà xe D3', N'Cạnh cổng Trần Đại Nghĩa', 150, 500)
INSERT [dbo].[VITRI] ([Vitri], [Tenvitri], [Mota], [Soxemax], [Dientich]) VALUES (N'D9', N'Nhà xe D9', N'Sau thư viện TQB', 150, 350)
GO
INSERT [dbo].[XeMatVe] ([Bienso], [Tenchuxe], [DiaChi], [SoCMT], [MaLoaixe], [Tenxe], [Mau], [Dungtich], [Thoigian], [Vitri]) VALUES (N'29-Y9-0058', N'Hoàng Anh', N'Hà Nội', N'001099018696', N'XM        ', N'Xe dream', N'Nâu', 97, CAST(N'2020-06-03T08:00:00.000' AS DateTime), N'B1')
GO
SET IDENTITY_INSERT [dbo].[XEVAORA] ON 

INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (1, N'01-F22-1123', N'BK1001', N'XM', CAST(N'2016-07-07T13:22:11.000' AS DateTime), CAST(N'2016-07-07T20:00:00.000' AS DateTime), N'B1', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (2, N'02-I11-6511', N'BK1002', N'XM', CAST(N'2016-07-07T13:00:21.000' AS DateTime), CAST(N'2016-07-09T20:00:00.000' AS DateTime), N'B10', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (4, N'22B-T20-0081', N'BK1004', N'XM', CAST(N'2016-07-08T10:21:00.000' AS DateTime), CAST(N'2020-06-17T11:24:01.863' AS DateTime), N'B10', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (5, N'25-K8-9999', N'BK1058', N'XM', CAST(N'2016-07-08T09:11:21.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (6, N'28-J21-7711', N'BK1005', N'XM', CAST(N'2016-07-09T12:02:11.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (7, N'29-Y21-6666', N'BK1006', N'XM', CAST(N'2016-07-09T15:20:10.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (8, N'29-Y7-7425', N'BK1120', N'XM', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (9, N'29-Y7-7426', N'BK1122', N'XM', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (10, N'29-Y7-7427', N'BK1124', N'XM', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (11, N'29-Y7-7428', N'BK1126', N'XM', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (12, N'29-Y7-7429', N'BK1128', N'XM', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (13, N'29-Y7-7430', N'BK1130', N'OT', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (14, N'29-Y9-0058', N'BK2222', N'XM', CAST(N'2020-06-01T00:00:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (15, N'30-A11-0881', N'BK1007', N'XM', CAST(N'2016-07-05T07:20:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (16, N'30-A11-0881', N'BK1101', N'OT', CAST(N'2020-06-11T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (17, N'30-A11-0885', N'BK1102', N'OT', CAST(N'2020-06-11T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (18, N'30-A11-0889', N'BK1103', N'OT', CAST(N'2020-06-11T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (19, N'30-A11-0893', N'BK1104', N'OT', CAST(N'2020-05-25T08:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (20, N'30-A11-0897', N'BK1106', N'OT', CAST(N'2020-05-26T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (21, N'30-A11-0901', N'BK1108', N'OT', CAST(N'2020-05-27T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (22, N'30-C55-9211', N'BK1008', N'OT', CAST(N'2016-07-03T13:11:00.000' AS DateTime), CAST(N'2016-07-05T20:00:00.000' AS DateTime), N'B10', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (23, N'32-K01-3200', N'BK1056', N'OT', CAST(N'2016-07-03T08:29:11.000' AS DateTime), CAST(N'2016-07-05T12:00:00.000' AS DateTime), N'B10', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (24, N'33-D6-0096', N'Bk1004', N'XM', CAST(N'2020-06-02T10:00:00.000' AS DateTime), CAST(N'2020-06-05T12:00:00.000' AS DateTime), N'D9', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (25, N'33-P6-0094', N'VT1000', N'XM', CAST(N'2016-06-01T05:00:00.000' AS DateTime), CAST(N'2016-06-01T10:00:00.000' AS DateTime), N'B10', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (26, N'33-P6-0095', N'BK1002', N'XM', CAST(N'2020-06-02T00:00:00.000' AS DateTime), CAST(N'2020-06-02T12:00:00.000' AS DateTime), N'B10', N'1', N'TK        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (27, N'33-p6-0096', N'Bk1002', N'XM', CAST(N'2020-06-02T10:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (28, N'45-N01-3313', N'NV2223', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), CAST(N'2020-06-04T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (29, N'45-N01-3314', N'NV2224', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), CAST(N'2020-06-05T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (30, N'45-N01-3315', N'NV2225', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), CAST(N'2020-06-06T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (31, N'45-N01-3316', N'NV2226', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), CAST(N'2020-06-07T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (32, N'45-N01-3317', N'NV2227', N'XM', CAST(N'2020-06-01T05:00:00.000' AS DateTime), CAST(N'2020-06-08T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (33, N'45-N01-3318', N'NV2228', N'XM', CAST(N'2020-06-01T05:00:00.000' AS DateTime), CAST(N'2020-06-09T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (34, N'49-M10-4222', N'BK1060', N'XM', CAST(N'2016-05-29T07:15:20.000' AS DateTime), CAST(N'2016-05-29T15:00:00.000' AS DateTime), N'B10', N'1', N'TK        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (35, N'50-B12-3333', N'BK1062', N'XM', CAST(N'2016-06-01T08:00:05.000' AS DateTime), CAST(N'2016-06-02T10:00:05.000' AS DateTime), N'D9', N'1', N'TK        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (36, N'51-K81-6999', N'BK1064', N'XM', CAST(N'2016-06-02T09:02:52.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (37, N'51-L09-2311', N'BK1066', N'XM', CAST(N'2016-05-29T07:38:00.000' AS DateTime), CAST(N'2016-05-29T10:38:00.000' AS DateTime), N'B1', N'1', N'TK        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (38, N'55-P6-0094', N'Bk1999', N'XM', CAST(N'2020-06-10T10:00:00.000' AS DateTime), CAST(N'2020-06-11T20:00:00.000' AS DateTime), N'D9', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (39, N'57K-11-0991', N'BK1068', N'XM', CAST(N'2016-07-02T15:01:11.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (40, N'58K-11-4112', N'BK1110', N'OT', CAST(N'2020-05-28T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (41, N'58K-11-4113', N'BK1112', N'OT', CAST(N'2020-05-29T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (42, N'58K-11-4114', N'BK1114', N'OT', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (43, N'58K-11-4115', N'BK1116', N'OT', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (44, N'58K-11-4116', N'BK1118', N'OT', CAST(N'2020-05-30T08:00:00.000' AS DateTime), NULL, N'B1', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (45, N'59-K90-9870', N'BK1070', N'XM', CAST(N'2016-06-03T10:01:00.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (46, N'62-Y19-0901', N'BK1072', N'XM', CAST(N'2016-07-04T12:09:11.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (47, N'64-K20-4444', N'BK1074', N'XM', CAST(N'2016-05-30T13:00:00.000' AS DateTime), CAST(N'2016-06-01T15:00:00.000' AS DateTime), N'D9', N'1', N'TK        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (48, N'65-M22-4211', N'BK1076', N'XM', CAST(N'2016-06-15T20:01:43.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (49, N'71-C11-6010', N'BK1078', N'XM', CAST(N'2016-07-01T07:14:20.000' AS DateTime), NULL, N'D9', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (50, N'76-K02-3312', N'NV2222', NULL, CAST(N'2020-06-03T05:00:00.000' AS DateTime), CAST(N'2020-06-04T05:00:00.000' AS DateTime), N'B10', N'1', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (51, N'76-N01-3312', N'BK1094', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), CAST(N'2020-06-17T15:25:50.223' AS DateTime), N'B10', N'1', N'TM        ')
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (52, N'76-N01-3313', N'BK1095', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (53, N'76-N01-3314', N'BK1096', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (54, N'76-N01-3315', N'BK1097', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (55, N'76-N01-3316', N'BK1098', N'XM', CAST(N'2020-06-03T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (56, N'76-N01-3317', N'BK1099', N'OT', CAST(N'2020-06-01T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (57, N'76-N01-3318', N'BK1100', N'OT', CAST(N'2020-06-01T05:00:00.000' AS DateTime), NULL, N'B10', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (58, N'XD1234', N'XD1234', N'XD', CAST(N'2020-06-02T08:00:00.000' AS DateTime), NULL, N'D3', N'0', NULL)
INSERT [dbo].[XEVAORA] ([STT], [Bienso], [Mave], [Maloaixe], [Giovao], [Giora], [Vitri], [Trangthai], [Matt]) VALUES (59, N'14-M7-12345', N'B1100', N'XM', CAST(N'2020-06-17T15:03:45.983' AS DateTime), CAST(N'2020-06-17T15:10:56.030' AS DateTime), N'B1', N'1', N'TM        ')
SET IDENTITY_INSERT [dbo].[XEVAORA] OFF
GO
ALTER TABLE [dbo].[HAOHUT]  WITH CHECK ADD  CONSTRAINT [FK_HAOHUT_VITRI1] FOREIGN KEY([Vitri])
REFERENCES [dbo].[VITRI] ([Vitri])
GO
ALTER TABLE [dbo].[HAOHUT] CHECK CONSTRAINT [FK_HAOHUT_VITRI1]
GO
ALTER TABLE [dbo].[Nhanvien]  WITH CHECK ADD  CONSTRAINT [FK_Nhanvien_Congviec] FOREIGN KEY([MaCV])
REFERENCES [dbo].[CONGVIEC] ([MaCV])
GO
ALTER TABLE [dbo].[Nhanvien] CHECK CONSTRAINT [FK_Nhanvien_Congviec]
GO
ALTER TABLE [dbo].[Nhanvien]  WITH CHECK ADD  CONSTRAINT [FK_Nhanvien_Vitri] FOREIGN KEY([vitri])
REFERENCES [dbo].[VITRI] ([Vitri])
GO
ALTER TABLE [dbo].[Nhanvien] CHECK CONSTRAINT [FK_Nhanvien_Vitri]
GO
ALTER TABLE [dbo].[TRANGTHIETBI]  WITH CHECK ADD  CONSTRAINT [FK_Trangthietbi_CTThietBi] FOREIGN KEY([MaTB])
REFERENCES [dbo].[CTTHIETBI] ([MaTB])
GO
ALTER TABLE [dbo].[TRANGTHIETBI] CHECK CONSTRAINT [FK_Trangthietbi_CTThietBi]
GO
ALTER TABLE [dbo].[TRANGTHIETBI]  WITH CHECK ADD  CONSTRAINT [FK_Trangthietbi_Vitri] FOREIGN KEY([Vitri])
REFERENCES [dbo].[VITRI] ([Vitri])
GO
ALTER TABLE [dbo].[TRANGTHIETBI] CHECK CONSTRAINT [FK_Trangthietbi_Vitri]
GO
/****** Object:  StoredProcedure [dbo].[LUONG_NHAN_VIEN]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[LUONG_NHAN_VIEN]
 AS
 BEGIN
    select Manv,Hoten,vitri,Nhanvien.macv,mucluong from Nhanvien inner join CONGVIEC on Nhanvien.Macv = congviec.MaCV
 END
GO
/****** Object:  StoredProcedure [dbo].[SL_XE_NV]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SL_XE_NV]
 AS
  BEGIN
   DECLARE @SL INT
   SELECT @SL = COUNT(MAVE) FROM VENV
   RETURN @SL
  END
GO
/****** Object:  StoredProcedure [dbo].[SO_VE_DK_TK]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SO_VE_DK_TK]
 AS 
 BEGIN 
    DECLARE @SOVE INT
	SELECT @SOVE = COUNT(MAVE) FROM VETK
	RETURN @SOVE
 END
GO
/****** Object:  StoredProcedure [dbo].[THANH_TOAN_XE]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[THANH_TOAN_XE](@BIENSO NVARCHAR(25),@MAVE NVARCHAR(25),@MATT NVARCHAR(25))
AS 
BEGIN 
   select bienso,xevaora.mave,xevaora.maloaixe,giovao,giora,vitri, DATEDIFF(DD, giovao, giora) AS SoNgay,giangay,DATEDIFF(DD, giovao, giora)* giaquadem as Gia_Qua_dem,trangthai, banggia.matt from xevaora inner join Banggia on xevaora.maloaixe = banggia.maloaixe 
   where xevaora.matt = banggia.matt and mave = @MAVE and bienso = @BIENSO and xevaora.matt = @MATT
END
GO
/****** Object:  StoredProcedure [dbo].[THEM_TT_XE_RA]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[THEM_TT_XE_RA](@MATT NVARCHAR(25),@BIENSO NVARCHAR(25),@MAVE NVARCHAR(25))
AS
BEGIN
update xevaora set giora = CURRENT_TIMESTAMP, trangthai = '1' ,matt = @MATT
where bienso = @BIENSO and mave = @MAVE
END
GO
/****** Object:  StoredProcedure [dbo].[THEM_TT_XE_VAO]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[THEM_TT_XE_VAO](@BIENSO NVARCHAR(25),@MAVE NVARCHAR(25),@MALOAIXE NVARCHAR(25),@VITRI NVARCHAR(25))
	AS 
	BEGIN
	insert into dbo.xevaora (Bienso,mave,maloaixe,giovao,vitri,trangthai) values 
    (@BIENSO,@MAVE,@MALOAIXE,CURRENT_TIMESTAMP,@VITRI,0);
	END
GO
/****** Object:  StoredProcedure [dbo].[THONG_TIN_MAT_VE]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[THONG_TIN_MAT_VE]
 AS
 BEGIN
     select *
	 from xematve inner join xevaora on xematve.bienso = xevaora.bienso 
 END
GO
/****** Object:  StoredProcedure [dbo].[THU_NHAP_NAM]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[THU_NHAP_NAM](@NAM INT, @VITRI NVARCHAR(25))
AS
 BEGIN
   DECLARE @tien int
   select @tien = sum(giangay + gia_qua_dem)  from xe_da_tt where year(giora) = @nam and vitri = @vitri
   return @tien
 END
GO
/****** Object:  StoredProcedure [dbo].[TIEN_DEN_BU]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TIEN_DEN_BU] 

AS 
BEGIN
   DECLARE @TIEN INT
   SELECT @TIEN =  sum(denbu) from suco
   RETURN @TIEN;
END
GO
/****** Object:  StoredProcedure [dbo].[XE_GUI_NHIEU]    Script Date: 17/06/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XE_GUI_NHIEU]
AS
BEGIN
    select bienso,Mave,Maloaixe,giovao,giora,Vitri,Trangthai,matt from xevaora
    where  DATEDIFF(DD, giovao, getdate()) > 7 and trangthai = '0'
END
GO
