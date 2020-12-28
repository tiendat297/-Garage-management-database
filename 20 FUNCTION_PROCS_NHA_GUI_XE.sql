------------------------------------FUNCTION---------------------------------------------------------
-----------------------------------------------------------------------------------------------------
--1 10 tạo Function với truyền vào là vị trí, đầu ra là số chỗ trống của nhà xe
create function So_Cho_Trong(@vitri nvarchar(25))
returns int
as
begin
Declare @chotrong int
DECLARE @i INT
set @i = (select soxemax from vitri where vitri = @vitri);
set @chotrong = (select @i - count(bienso) from xevaora where vitri = @vitri and trangthai = '0')
return @chotrong
end
-------- TRUY VẤN -----------------------
select dbo.so_cho_trong('B10') as số_chỗ_trống
-- 2 5 Tạo function số xe chưa lấy của mỗi nhà xe 
create function So_xe_chua_lay()
returns table
as
return select xevaora.vitri,maloaixe, (count(xevaora.bienso)) as so_xe_chua_lay from xevaora 
where  trangthai = '0' group by xevaora.vitri,maloaixe
---truy vấn-------------
select * from  dbo.So_xe_chua_lay();
--3 6 tính tổng tiền thu được(cả tm và tk) của mỗi nhà xe của một ngày, tham số truyền vào là ngày
create function Tong_tien_Thu(@Ngay date)
returns table
as 
return select vitri,sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu  from xe_da_tt 
where CONVERT(date, giora) =  @Ngay  group by vitri
-- truy vấn--------------------
	select * from Tong_tien_Thu('2016-06-2')
-- 4 Tính tổng số mỗi loại xe  đã lấy ra trong ngày của mỗi nhà xe
create function Tong_so_xe_da_lay_trong_ngay(@Ngay date)
 returns table as
 return select vitri,maloaixe,count(bienso) so_xe_da_lay from xevaora 
where trangthai ='1' and CONVERT(date, giora) =  @Ngay group by vitri,maloaixe 
-- truy vấn ----------------------------------
select * from Tong_so_xe_da_lay_trong_ngay('2020-06-02')
	
-- 5 xem tên nhân viên đã thanh toán xe
create function Tim_kiem_nhan_vien_trong_xe(@bienso nvarchar(25))
returns table as 

 return  select bienso, mave, giovao,giora,xevaora.vitri,manv,hoten from xevaora inner join Nhanvien on xevaora.vitri = nhanvien.vitri 
where bienso = @bienso and Macv = 'TX01'
---------------------TRUY VẤN --------------------------------------------
select * from Tim_kiem_nhan_vien_trong_xe('33-P6-0094')

-- 6 TẠO FUNCTION KIỂM TRA XEM XE RA VÀ MÃ VÉ CÓ TRÙNG VỚI LÚC VÀO HAY KHÔNG
create function KIEM_TRA_XE(@bienso nvarchar(25), @mavenhap nvarchar(25))
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

-- truy vấn
select dbo.kiem_tra_xe('25-K8-9999','BK1058')
-- 7 TÍNH SỐ XE HIỆN ĐANG GỬI Ở MỖI NHÀ XE
create function SO_xe_hien_tai()
returns table as 
return select vitri,maloaixe,count(bienso) as Số_xe_đang_gửi from xevaora where trangthai = '0' group by vitri,maloaixe
select * from SO_xe_hien_tai()
-- 8 SỐ TIỀN MẶT ĐÃ THU CỦA NHÀ XE ( ĐẦU VÀO LÀ MÃ NHÀ XE, NGÀY)
CREATE FUNCTION THU_TIEN_MAT(@VITRI NVARCHAR(25), @NGAY DATE)
RETURNs int as
begin
declare @I int
select @I = sum(giangay + gia_qua_dem)  from xe_da_tt where matt = 'tm' and CONVERT(date, giora) =  @NGAY
  RETURN @I

end
-----------TRUY VẤN DEMO
select DBO.THU_TIEN_MAT('B10','2016-07-05') AS Số_tiền_mặt_thu

-- 8 SỐ TIỀN QUA TÀI KHOẢN ĐÃ THU QUA TÀI KHOẢN NGÂN HÀNG ( ĐẦU VÀO LÀ MÃ NHÀ XE, NGÀY) 
CREATE FUNCTION THU_TAI_KHOAN(@VITRI NVARCHAR(25),@NGAY DATE)
RETURNS INT AS
BEGIN 
DECLARE @TONGTIEN INT
select @TONGTIEN = sum(giangay + gia_qua_dem)  from xe_da_tt where matt = 'tk'
RETURN @TONGTIEN
END
-- TRUY VẤN DEMO 
SELECT DBO.THU_TAI_KHOAN('B10', '2016-07-16') AS SỐ_TIỀN_THU_QUA_TK

-- 9 Xem những thiết bị hiện có của từng nhà xe
create function Thiet_bi_hien_co()
returns table as
return select Vitri,trangthietbi.matb,soluong,donvi,tenTB,Nhacc,gia, soluong * gia as tổng_giá_trị 
from trangthietbi inner join ctthietbi on trangthietbi.matb = ctthietbi.matb
-- TRUY VẤN
select * from Thiet_bi_hien_co()
-- 10 Tổng thu cả năm của mỗi nhà xe
create function TONG_THU_CA_NAM(@nam int, @vitri nvarchar(25))
returns int as
begin
declare @tien int
select @tien = sum(giangay + gia_qua_dem)  from xe_da_tt where year(giora) = @nam and vitri = @vitri
return @tien
end
-- truy vấn
select dbo.tong_thu_ca_nam(2017,'B10') as Tổng_thu_cả_năm


-------------------------------------------------------------------------------------
---------------------------------TẠOPROCEDURE----------------------------------------



--1 TẠO PROCSDUCE THÊM THÔNG TIN XE VÀO GỒM BIỂN SỐ, MÃ VÉ, GIỜ VÀO, VỊ TRÍ, TRẠNG THÁI CHƯA LẤY
CREATE PROC THEM_TT_XE_VAO(@BIENSO NVARCHAR(25),@MAVE NVARCHAR(25),@MALOAIXE NVARCHAR(25),@VITRI NVARCHAR(25))
	AS 
	BEGIN
	insert into dbo.xevaora (Bienso,mave,maloaixe,giovao,vitri,trangthai) values 
    (@BIENSO,@MAVE,@MALOAIXE,CURRENT_TIMESTAMP,@VITRI,0);
	END
-- THỰC THI--------
EXECUTE THEM_TT_XE_VAO '14-M7-12345','B1100','XM','B1'
-- 2 TẠO PROCS THÊM THÔNG TIN XE RA NẾU VÉ XE VÀ BIỂN SỐ ĐÃ THỎA MÃN 
CREATE PROC THEM_TT_XE_RA(@MATT NVARCHAR(25),@BIENSO NVARCHAR(25),@MAVE NVARCHAR(25))
AS
BEGIN
update xevaora set giora = CURRENT_TIMESTAMP, trangthai = '1' ,matt = @MATT
where bienso = @BIENSO and mave = @MAVE
END
-- THỰC THI----------
EXECUTE THEM_TT_XE_RA 'TM','14-M7-12345','B1100'

-- 3 THANH TOÁN CHO XE RA, ĐẦU RA LÀ THÔNG TIN VÀ TIỀN 
CREATE PROC THANH_TOAN_XE(@BIENSO NVARCHAR(25),@MAVE NVARCHAR(25),@MATT NVARCHAR(25))
AS 
BEGIN 
   select bienso,xevaora.mave,xevaora.maloaixe,giovao,giora,vitri, DATEDIFF(DD, giovao, giora) AS SoNgay,giangay,DATEDIFF(DD, giovao, giora)* giaquadem as Gia_Qua_dem,trangthai, banggia.matt from xevaora inner join Banggia on xevaora.maloaixe = banggia.maloaixe 
   where xevaora.matt = banggia.matt and mave = @MAVE and bienso = @BIENSO and xevaora.matt = @MATT
END
EXECUTE THANH_TOAN_XE '22B-T20-0081','BK1004','TM'
-- 4 SỐ NHỮNG XE ĐÃ GỬI XE QUÁ 7 NGÀY
CREATE PROC XE_GUI_NHIEU
AS
BEGIN
    select bienso,Mave,Maloaixe,giovao,giora,Vitri,Trangthai,matt from xevaora
    where  DATEDIFF(DD, giovao, getdate()) > 7 and trangthai = '0'
END
-- THỰC THI------------
execute xe_gui_nhieu
--5 TỔNG SỐ TIỀN ĐỀN BÙ CỦA CHO KHÁCH
CREATE PROC TIEN_DEN_BU 

AS 
BEGIN
   DECLARE @TIEN INT
   SELECT @TIEN =  sum(denbu) from suco
   RETURN @TIEN;
END

--THỰC THI------
DECLARE @I INT
EXEC  @I = TIEN_DEN_BU
PRINT @I
 --6 CHECK THÔNG TIN XE MẤT VÉ
 CREATE proc THONG_TIN_MAT_VE
 AS
 BEGIN
     select *
	 from xematve inner join xevaora on xematve.bienso = xevaora.bienso 
 END
 --THỰC THI--
 exec THONG_TIN_MAT_VE
 -- 7 THÔNG TIN LƯƠNG CỦA NHÂN VIÊN TRONG NHÀ GỬI XE
 CREATE PROC LUONG_NHAN_VIEN
 AS
 BEGIN
    select Manv,Hoten,vitri,Nhanvien.macv,mucluong from Nhanvien inner join CONGVIEC on Nhanvien.Macv = congviec.MaCV
 END
 -- THỰC THI--
 EXEC LUONG_NHAN_VIEN
 -- 8 SỐ VÉ ĐĂNG KÍ THANH TOÁN QUA NGÂN HÀNG
 CREATE PROC SO_VE_DK_TK
 AS 
 BEGIN 
    DECLARE @SOVE INT
	SELECT @SOVE = COUNT(MAVE) FROM VETK
	RETURN @SOVE
 END
 -- THỰC THI---
 DECLARE @SLDK INT
 EXEC @SLDK = SO_VE_DK_TK
 PRINT N'SỐ LƯỢNG SINH VIÊN ĐĂNG KÍ VÉ THANH TOÁN QUA TÀI KHOẢN LÀ'
 PRINT  @SLDK
 -- 9 SỐ LƯỢNG NHÂN VIÊN GỬI XE TRONG TRƯỜNG 
 CREATE PROC SL_XE_NV
 AS
  BEGIN
   DECLARE @SL INT
   SELECT @SL = COUNT(MAVE) FROM VENV
   RETURN @SL
  END
--THỰC THI--
DECLARE @SLNV INT
EXEC @SLNV = SL_XE_NV
PRINT @SLNV
--10 THU NHẬP CẢ NĂM CỦA NHÀ XE
CREATE PROC THU_NHAP_NAM(@NAM INT, @VITRI NVARCHAR(25))
AS
 BEGIN
   DECLARE @tien int
   select @tien = sum(giangay + gia_qua_dem)  from xe_da_tt where year(giora) = @nam and vitri = @vitri
   return @tien
 END
 --THỰC THI--
DECLARE @THUNAM INT
EXEC @THUNAM = THU_NHAP_NAM 2016, 'B1'
PRINT @THUNAM
