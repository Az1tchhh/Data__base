--1
--a
create function incr(a int)
        returns int as
    $$
        begin
            return a+1;
        end;
    $$ language PLPGSQL;
drop function  incr;
SELECT incr(1);

--b
create function sum(a int, b int)
        returns int as
    $$
        begin
            return a+b;
        end;
    $$ LANGUAGE PLPGSQL;
drop function sum;
select sum(1,1);
--c
drop function is_even;
create function is_even(a int)
        returns bool as
    $$
        begin
            return a%2=0;
        end;
    $$ language PLPGSQL;

select is_even(2);

--d
create function passworn(str text)
        returns  bool as
    $$
        begin
            return (char_length(str)>=5) and ((strpos(str,'123')>0));
        end;
    $$ LANGUAGE PLPGSQL;
drop function passworn;
SELECT passworn('Azamat123');

--e
drop function func;
create function func(s int, out num int, out len int) AS
    $$
        begin
            num = s;
            len= s;
        end;
    $$ language plpgsql;

select func(1234);

--2
--a
drop table  tabl;
create table tabl(s text);
drop table retur;
create table retur(time timestamp(0));

    create function timee()
        returns trigger as
        $$
            begin
                insert into retur(time) values (now());
                return new;
            end;
        $$ LANGUAGE  plpgsql;

create trigger changes
before insert on tabl
for each statement
execute procedure timee();
---
insert into tabl(s) values (' ');
SELECT * FROM retur;
---

--b
create table  table2(birthdate timestamp);
drop table table2;
create table return2(years int);
drop table return2;
--
    create function age()
        returns trigger as
        $$
            begin
                insert into return2(years) values (extract(year from now())-extract(year from new.birthdate));
                return new;
            end;
        $$ LANGUAGE  plpgsql;
--
create trigger trigger2
before insert on table2
for each row
execute procedure age();
--
insert into table2(birthdate) values (now());
select * from return2;
--

--c
drop function  increase;

create table table3(price int);
create table return3(price int);
drop function increase;
    create function increase()
        returns trigger as
    $$
        begin
            new.price = new.price*1.12;
            return new;
        end;
    $$ language plpgsql;

create trigger trig
before insert on  table3
for each row
execute procedure increase();

--
insert into table3(price) values (10);
select * from table3;
--
--3
--a
--P.S table3 doesnt exist in my db
-- just considering by example-schema
begin;
    update table_3
    set salary = salary * 1.1 * (workexperience/2); --+0.1

    update table_3
    set discount = discount * 1.01
    where workexperience>5;

end;
--b
begin;
    update table_3
    set salary = salary*1.15 --+15
    where age>=40;

    update table_3
    set salary = salary*1.15
    where workexperience > 8;

    update table_3
    set discount=discount * 1.2
    where workexperience > 8;
end;