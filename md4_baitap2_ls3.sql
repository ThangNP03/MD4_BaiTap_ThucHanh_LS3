create database md4_baitap2_ls3;
use md4_baitap2_ls3;
create table customer(
	cId int primary key auto_increment,
    cName varchar(25),
    cAge tinyint  
);
insert into customer (cName,cAge) values 
("Thắng", 20),
("Phúc Thắng ", 50),
("Minh Quan", 10),
("Ngoc Oanh",20),
("Hong Ha ", 50);


create table orders(
	oId int primary key auto_increment,
    cId int ,
    foreign key (cId) references customer(cId),
    oDate date ,
    oTotalPrice float 
);
insert into orders values 
(null , 1 , "2006/3/26", null),
(null , 2 , "2006/3/23", null),
(null , 1 , "2006/3/16", null);



create table product (
	pId int primary key auto_increment,
    pName varchar (200),
    pPrice int  
);
insert into product(pName,pPrice) values 
("Máy giặt", 3),
("Tủ lạnh", 5),
("Điều hòa ", 7),
("Quạt", 1),
("Bếp điện", 2); 
create table oderdetal (
	oId int ,
    foreign key (oId) references orders(oId),
    pId int ,
    foreign key (pId) references product(pId),
    odQTY int 
);
insert into oderdetal values 
(1,1,3),(1,3,7),(1,4,2), (2,1,1),(3,1,8),(2,5,4),(2,3,3);

-- •	Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select orders.oId, orders.oDate, orders.oTotalPrice from orders;
-- •	Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách 
select c.*, pr.* 
from
	customer c join orders o on c.cId = o.oId
    join oderdetal od  on o.oId = od.oId
    join product pr on od.oId = pr.pId;
-- •	Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào    
select c.cName from customer c where c.cId not in (select distinct orders.oId from orders) ;

-- •	Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select o.oId, o.oDate, sum(od.odQTY * p.pPrice) as total
from orders o join oderdetal od on o.oId = od.oId
join product p on od.oId = p.pId group by o.oId;