--NGHIỆP VỤ GỬI XE VÀO VÀ LẤY XE RA
-- 1 thêm thông tin xe đã gửi vào
insert into dbo.xevaora (Bienso,mave,maloaixe,giovao,vitri,trangthai) values 
('55-P6-0094','Bk1999','XM','2020-06-10 10:00:00','D9','0');
-- 2 Khi xe về check biển số có trùng với vé k 
select * from xevaora where bienso = '25-K8-9999' and trangthai = '0'
-- 3 Câu lệnh đi kèm, thêm giờ ra cho xe, đổi trạng thái thành đã lấy 
update xevaora set giora = '2020-6-11 20:00:00', trangthai = '1' ,matt = 'TM' 
where bienso = '55-P6-0094' and mave = 'BK1999' 
-- 4 kiểm tra thời gian gửi và thu tiền
select bienso,xevaora.mave,xevaora.maloaixe,giovao,giora,vitri, DATEDIFF(DD, giovao, giora) AS SoNgay,giangay,DATEDIFF(DD, giovao, giora)* giaquadem as Gia_Qua_dem,trangthai, banggia.matt from xevaora inner join Banggia on xevaora.maloaixe = banggia.maloaixe 
where xevaora.matt = banggia.matt and mave = 'Bk1999' and bienso = '55-P6-0094' and xevaora.matt = 'tm'
-----------------------------------------------------------------------------------------------------------------------

-- 5 Số xe chưa lấy của mỗi nha xe 
select xevaora.vitri,maloaixe, (count(xevaora.bienso)) as so_xe_chua_lay from xevaora 
where  trangthai = '0' group by xevaora.vitri,maloaixe order by vitri
-- 6 Tính tổng tiền trong ngày của mỗi nhà xe ( bao gồm cả tiền mặt và qua TK) thu được 
select vitri,sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu  from xe_da_tt 
where CONVERT(date, giora) =  '2020-06-02'  group by vitri
-- 7 Tính tổng số mỗi loại xe  đã lấy ra trong ngày của mỗi nhà xe
select vitri,maloaixe,count(bienso) so_xe_da_lay from xevaora 
where trangthai ='1' and CONVERT(date, giora) =  '2020-06-11' group by vitri,maloaixe 
-- 8 tính tổng số tiền mà một xe đã gửi
select  sum(giangay + gia_qua_dem) as so_tien_xe_da_gui from xe_da_tt where bienso = '33-P6-0095'
-- 9 Tính số xe hiện đang gửi  tại các nhà xe
select vitri,maloaixe,count(bienso) as Số_xe_đang_gửi from xevaora where trangthai = '0' group by vitri,maloaixe
-- 10 tính số chỗ trống của nhà xe
DECLARE @i INT;
set @i = (select soxemax from vitri where vitri = 'D9');
select @i - count(bienso) as Số_chỗ_trống  from xevaora where vitri = 'D9' and trangthai = '0'
-- 11 xem tên nhân viên đã thanh toán xe 
select * from xevaora inner join Nhanvien on xevaora.vitri = nhanvien.vitri where bienso = '33-D6-0096' and Macv = 'TX01'
--12 xem thiết bị hiện có của từng nhà xe
select Vitri,trangthietbi.matb,soluong,donvi,tenTB,Nhacc,gia, soluong * gia as tổng_giá_trị 
from trangthietbi inner join ctthietbi on trangthietbi.matb = ctthietbi.matb
--13 số những xe quá 7 ngày chưa lấy của mỗi nhà xe
select vitri,maloaixe,count(bienso) from xevaora
where  DATEDIFF(DD, giovao, getdate()) > 7 and trangthai = '0' group by vitri,maloaixe
--14 những xe quá 7 ngày chưa lấy
select * from xevaora
where  DATEDIFF(DD, giovao, getdate()) > 7 and trangthai = '0'


select bienso,xevaora.mave,xevaora.maloaixe,giovao,giora,vitri, DATEDIFF(DD, giovao, giora) AS SoNgay,giangay,DATEDIFF(DD, giovao, giora)* giaquadem as Gia_Qua_dem,trangthai, xevaora.matt from xevaora inner join Banggia on xevaora.Maloaixe = Banggia.Maloaixe
where xevaora.matt = banggia.matt and xevaora.matt = 'tk'
create view XE_DA_TT as select bienso,xevaora.mave,xevaora.maloaixe,giovao,giora,vitri, DATEDIFF(DD, giovao, giora) AS SoNgay,giangay,DATEDIFF(DD, giovao, giora)* giaquadem as Gia_Qua_dem,trangthai, xevaora.matt from xevaora inner join Banggia on xevaora.Maloaixe = Banggia.Maloaixe
where xevaora.matt = banggia.matt and xevaora.matt in('tm','tk')
-- 15 số tiền mặt đã thu của mỗi nhà xe trong ngày
select vitri, sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu_TM  from xe_da_tt where matt = 'tm' and CONVERT(date, giora) =  '2020-06-11'
  group by vitri
-- 16 số tiền thanh toán qua tài khoản của mỗi nhà xe
select vitri, sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu_Tk  from xe_da_tt where matt = 'tk'
  group by vitri
  -- 17 tính tổng số tiền mặt và số tiền qua tài khoản trong tháng của mỗi nhà xe
  select vitri, sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu_TM  from xe_da_tt where CONVERT(date, giora) between '2020/06/01' AND '2020/06/30'
  group by vitri
  -- 18 tính tổng số tiền cả năm của mỗi nhà xe
 select vitri, sum(giangay + gia_qua_dem) as Tong_tien_trong_ngay_da_thu  from xe_da_tt where CONVERT(date, giora) between '2020/01/01' AND '2020/12/31'
  group by vitri
  -- 19 tính tổng số xe đã gửi vào trong ngày,tháng của mỗi nhà xe
  select vitri,maloaixe,count(bienso) so_xe_gui_vao from xevaora 
where trangthai ='0' and CONVERT(date, giovao) =  '2020-06-11' group by vitri,maloaixe
  -- 20 check thông tin mất vé 
  select * from xematve inner join xevaora on xematve.bienso = xevaora.bienso 
  -- 21 số xe nhân viên gửi vào mỗi nhà xe là
  select vitri,count(bienso) Số_NV_Gửi from xevaora where matt is null and mave like 'NV%' group by vitri
  -- 22 tổng số tiền đền bù cho khách do các sự cố
  select sum(denbu) Số_Tiền_Đền_Bù from suco
  --23 Tiền lương của nhân viên
  select Manv,Hoten,vitri,Nhanvien.macv,mucluong from Nhanvien inner join CONGVIEC on Nhanvien.Macv = congviec.MaCV
