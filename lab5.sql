drop table  warehouses;
create table Warehouses(
    code integer,
    location character varying(255),
    capacity integer
);
drop table Boxes;
create table Boxes(
    code character (4),
    contents character varying(255),
    value real,
    warehouses integer
);
select * from warehouses;
select * from  boxes;
--4
select * from warehouses;
--5
select value from boxes
where value>150;
--6
Select distinct on(contents)*FROM boxes;
--7
SELECT code, warehouses FROM boxes;
--8
select code, warehouses from boxes
where warehouses > 2;
--9
insert into warehouses (code, location, capacity)
values (6, 'New-York', 3);
--
-- update warehouses
-- set code = 6
-- where location = 'New-York';
--10
INSERT INTO boxes (code, contents, value, warehouses)
VALUES ('H5RT', 'Papers', 200, 2);
--11
update boxes
set value = 0.85*value
where value = (select max(value) from boxes
                                 where value < (select max(value) from boxes
                                                                  where value < (select max(value) from boxes)));
-- 12
select * from boxes;
delete from boxes where value<150;
--13
select * from boxes
    where warehouses = (
        (select code from warehouses
            where location = 'New York') /*sub-query*/
        );

select boxes.code, boxes.contents, boxes.value, boxes.warehouses
from boxes inner join warehouses on boxes.warehouses = warehouses.code
where location = 'New York'
group by boxes.code, boxes.contents, boxes.value, boxes.warehouses;


delete from boxes
       where warehouses=(
            (select code from warehouses
                 where location = 'New York') --sub-query
            );
