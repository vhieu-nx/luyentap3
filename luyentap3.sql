create database luyentap3;
use luyentap3;
create table tblvattu(
	id int(10), 
    ma_vat_tu varchar(10)  primary key,
    ten_vat_tu varchar(255) not null,
    don_vi_tinh varchar(25),
    gia_tien float
);
create table tbltonkho(
	id int ,
    vat_u_id varchar(10),
    so_luong int not null,
    so_luong_nhap int not null,
    so_luong_xuat int not null
   ,foreign key (vat_u_id) references tblvattu(ma_vat_tu) 
);

create table tblNhaCC(
	id int ,
    ma_nhaCC varchar(10) primary key,
    ten_nhaCC varchar(20) not null,
    dia_chi varchar(255) not null,
    sdt int(10) not null unique
);
create table tbldondathang(
	id int ,
    ma_don varchar(10) primary key,
    ngay_dat date,
    nhacc varchar(10),
    foreign key (nhacc) references tblnhacc(ma_nhacc)
);
create table tblphieunhap(
	id int , 
    ma_PN varchar(10) primary key, 
    ngay_nhap date, 
    donhang varchar(10),
    foreign key (donhang) references tbldondathang(ma_don)
);
create table tblPhieuxuat(
	id int,
    ma_px varchar(10) primary key,
    ngay_xuat date,
    ten_cus varchar(20)
);
create table tbldetaildh(
	id int primary key, 
    ma_don varchar(10), 
   ma_vat_tu varchar(10), 
	so_luong int,
    foreign key (ma_don) references tbldondathang(ma_don),
    foreign key (ma_vat_tu) references tblvattu(ma_vat_tu)
);
create table tbldetailpn(
	id int primary key,
    ma_pn varchar(10),
    ma_vat_tu varchar(10),
    soluong int default 1,
    don_gia float not null,
    note varchar(155),
    foreign key (ma_pn) references tblphieunhap(ma_PN),
    foreign key (ma_vat_tu) references tblvattu(ma_vat_tu)
);
create table tbldetailpx(
	id int primary key,
    ma_px varchar(10),
    ma_vat_tu varchar(10),
    soluong int default 1,
    don_gia float not null,
    note varchar(155),
	foreign key (ma_px) references tblPhieuxuat(ma_Px),
    foreign key (ma_vat_tu) references tblvattu(ma_vat_tu)
);
insert into tblvattu value('1','vt01','ximang','m3',12000),('2','vt02','cat','m3',45000),('3','vt03','soi','m3',80000),('4','vt04','da','m3',24000),('5','vt05','dat','m3',54000);
insert into tbltonkho value('1','vt01',5,4,2),('2','vt02',6,5,5),('3','vt03',10,9,3),('4','vt04',200,53,32),('5','vt04',20,12,6),('6','vt01',12,10,9),('7','vt02',10,2,5),('8','vt02',15,5,4),('9','vt04',8,5,3),('10','vt05',10,12,2);
insert into tblNhaCC value('1','ncc1','phuclong','141 phuc dein',0325023322),('2','ncc2','phuclong','241 phuc den',0325213322),('3','ncc3','mydinh','121 phuc dein',0312023322);
insert into tbldondathang value('1','dh01','2020-12-09','ncc1'),('2','dh02','2021-10-09','ncc2'),('3','dh03','2021-11-08','ncc3');
insert into tblphieunhap value('1','pn01','2021-02-12','dh01'),('2','pn02','2021-03-12','dh02'),('3','pn03','2021-01-12','dh03');
insert into tblphieuxuat value('1','px01','2021-3-25','hieu'),('2','px02','2021-4-1','huy'),('3','px03','2021-5-1','hien');
insert into tbldetaildh value('1','dh01','vt01',2),('2','dh02','vt02',3),('3','dh02','vt03',1),('4','dh02','vt04',2),('5','dh03','vt05',4),('6','dh03','vt01',6);
insert into tbldetailpn value('1','pn01','vt01','2','24000','giao dung ngay'),('2','pn02','vt03','23','242000','giao dung ngay nhe'),('3','pn02','vt01','1223','221142000','agay nhe'),('4','pn02','vt03','213','24212000','giao a'),('5','pn01','vt05','21','2420002','giab'),('6','pn03','vt04','23','242000','a');
insert into tbldetailpx value('1','px01','vt01','2','24000','giao dung ngay'),('2','px02','vt03','23','242000','giao dung ngay nhe'),('3','px02','vt01','1223','221142000','agay nhe'),('4','px02','vt03','213','24212000','giao a'),('5','px01','vt05','21','2420002','giab'),('6','px03','vt04','23','242000','a');

#1.#D??? li???u bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng, m?? v???t t??, 
#s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n.
create view chitietphieunhap as SELECT tblphieunhap.ma_PN,
s.ma_vat_tu,ed.soluong,
								ed.don_gia,
                                  soluong * don_gia 'ThanhTienNhap' FROM ((tblphieunhap
       INNER JOIN tbldetailpn as ed on tblphieunhap.ma_pn = ed.ma_pn)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu);
      select *From chitietphieunhap;

##s??? phi???u nh???p h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
create view chitietphieuvattu as SELECT tblphieunhap.ma_PN,
s.ma_vat_tu,s.ten_vat_tu,ed.soluong,
								ed.don_gia,
								soluong * don_gia 'Thanh_tien_nhap' FROM ((tblphieunhap
       INNER JOIN tbldetailpn as ed on tblphieunhap.ma_pn = ed.ma_pn)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu);
       select *From chitietphieuvattu;
       

#s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
create view chitietphieunhapandphieuvattu as select tblphieunhap.ma_PN,tblphieunhap.ngay_nhap,
                                o.ma_don,
                                s.ma_vat_tu,
                                s.ten_vat_tu,
								ed.soluong,
								ed.don_gia,
								soluong * don_gia'Thanh_tien_nhap' FROM (((tblphieunhap
       iNNER join tbldondathang o on tblphieunhap.donhang = o.ma_don             )            
       INNER JOIN tbldetailpn as ed on tblphieunhap.ma_pn = ed.ma_pn)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu);
      select *From chitietphieunhapandphieuvattu;

#s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng, m?? nh?? cung c???p, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
create view chitietphieunhapphieuvattudonhang as SELECT tblphieunhap.ma_PN,tblphieunhap.ngay_nhap,
                                o.ma_don,
                                nhacc.ma_nhacc,
                                s.ma_vat_tu,
                                s.ten_vat_tu,
								ed.soluong,
								ed.don_gia,
								soluong * don_gia 'Thanh_tien_nhap' FROM ((((tblphieunhap
       iNNER join tbldondathang as o on tblphieunhap.donhang = o.ma_don             )  
       inner join tblnhacc as nhacc on o.nhacc = nhacc.ma_nhacc )
       INNER JOIN tbldetailpn as ed on tblphieunhap.ma_pn = ed.ma_pn)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu);
       select *From chitietphieunhapphieuvattudonhang;
       
##s??? phi???u nh???p h??ng, m?? v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p. V?? ch??? li???t k?? c??c chi ti???t nh???p c?? s??? l?????ng nh???p > 5.
create view chitietphieunhapsoluonglonhon5 as SELECT tblphieunhap.ma_PN,
                                s.ma_vat_tu,
								ed.soluong,
								ed.don_gia,
								soluong * don_gia 'Thanh_tien_nhap' FROM ((tblphieunhap
       INNER JOIN tbldetailpn as ed on tblphieunhap.ma_pn = ed.ma_pn)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu)
       where ed.soluong > 5;
       select *from chitietphieunhapsoluonglonhon5;

#s??? phi???u nh???p h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p. V?? ch??? li???t k?? c??c chi ti???t nh???p v???t t?? c?? ????n v??? t??nh l?? B???.
create view chitietphieunhapvattudonvitinhbo as SELECT tblphieunhap.ma_PN,
                                s.ma_vat_tu,
                                s.ten_vat_tu,
								ed.soluong,
								ed.don_gia,
								soluong * don_gia 'Thanh_tien_nhap' FROM ((tblphieunhap
       INNER JOIN tbldetailpn as ed on tblphieunhap.ma_pn = ed.ma_pn)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu)
       where s.don_vi_tinh ='Bo';
       select *from chitietphieunhapvattudonvitinhbo;
#s??? phi???u xu???t h??ng, m?? v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t, th??nh ti???n xu???t.
create view chitietphieuxuat as SELECT tblphieuxuat.ma_px,
                                s.ma_vat_tu,
								ed.soluong,
								ed.don_gia,
								soluong * don_gia 'Thanh_tien_nhap' FROM ((tblphieuxuat
       INNER JOIN tbldetailpx as ed on tblphieuxuat.ma_px = ed.ma_px)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu);
       select *From chitietphieuxuat;
#s??? phi???u xu???t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.
create view chitietphieuvattu1 as SELECT tblphieuxuat.ma_px,
                                s.ma_vat_tu,
                                s.ten_vat_tu,
								ed.soluong,
								ed.don_gia FROM ((tblphieuxuat
       INNER JOIN tbldetailpx as ed on tblphieuxuat.ma_px = ed.ma_px)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu)
       GROUP BY tblphieuxuat.ma_px,s.ma_vat_tu,ed.soluong,ed.don_gia;
       select * from chitietphieuvattu;
 #s??? phi???u xu???t h??ng, t??n kh??ch h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.
 create view chitietphieuvatuandphieuxuat as SELECT tblphieuxuat.ma_px,
 tblphieuxuat.ten_cus,
                                s.ma_vat_tu,
                                s.ten_vat_tu,
								ed.soluong,
								ed.don_gia
								 FROM ((tblphieuxuat
       INNER JOIN tbldetailpx as ed on tblphieuxuat.ma_px = ed.ma_px)
       INNER JOIN tblvattu as s on ed.ma_vat_tu = s.ma_vat_tu)
       GROUP BY tblphieuxuat.ma_px,tblphieuxuat.ten_cus,s.ma_vat_tu,ed.soluong,ed.don_gia;
select *from chitietphieuvatuandphieuxuat;


