--1
--a
select * from dealer cross join client;
--b
select dealer.id dealer_id, dealer.name as dealer_name, client.name as client_name, client.city, client.priority as grade, sell.id as sell_number, sell.date, sell.amount
from client inner join dealer on client.dealer_id = dealer.id
            inner join sell on sell.client_id = client.id;
--c
select * from dealer inner join client on dealer.location = client.city;
--d
select sell.id, sell.amount, client.name, client.city from sell inner join client on client.id = sell.client_id
where sell.amount >=100 and sell.amount <=500;
--e
select dealer.id as dealer_id, dealer.name as dealer_name from dealer inner join client c on dealer.id = c.dealer_id
group by dealer.id, dealer.name
having count(c.dealer_id)>0;

select distinct on(dealer.name) * from dealer full outer join client on dealer.id = client.dealer_id;

--select * from dealer d left join client c on d.id=c.dealer_id left join sell on sell.client_id = c.id;
--f

--select * from dealer join client on dealer.id = client.dealer_id;

select c.name as client_name, c.city as city, dealer.name as dealer_name, charge as commission
from dealer join client c on dealer.id = c.dealer_id;
--g
select client.name, client.city, dealer.name, dealer.charge from client inner join dealer on client.dealer_id = dealer.id
where charge > 0.12;
--h
select client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.charge
from client left join sell on client.id = sell.client_id
            left join dealer on sell.dealer_id = dealer.id;
--i
/*select client.name, client.priority, dealer.name, dealer.id, sell.id, sell.amount
from client inner join dealer on client.dealer_id = dealer.id
            inner join sell on client.id = sell.client_id
group by client.name, client.priority, dealer.name, dealer.id, sell.id, sell.amount, sell.date
having count(client.dealer_id)>0 and (count(sell.date)>0 or (sell.amount>2000 and priority is not null) or sell.date is null);
*/
select client.name, client.priority, dealer.name,  sell.id, sell.amount
from dealer inner join client on dealer.id = client.dealer_id
            inner join sell on client.id = sell.client_id
where sell.amount>=2000 and client.priority is not null;

/*select client.dealer_id from client
group by client.dealer_id
having count(client.dealer_id)>1;*/

-- select client.dealer_id from client inner join dealer on client.dealer_id = dealer.id
--             inner join sell on client.id = sell.client_id
-- group by client.dealer_id
-- having count(client.dealer_id)>1;
--
-- select client.id
-- from client inner join dealer on client.dealer_id = dealer.id
--             inner join sell on client.id = sell.client_id
-- group by client.id
-- having count(client.dealer_id)>1;
--2
--a
drop view view1;

create view view1 as select sell.date, client.name, count(DISTINCT client_id), avg(amount), sum(amount)
from sell inner join client on sell.client_id = client.id
group by date, client.name;

select * from view1;
--b
drop view view2;

create view view2 as select sell.date, count(DISTINCT sell.id), sum(amount)
from sell
group by sell.date
order by sum(amount) desc
limit 5;

select * from view2;
--c
drop view view3;

create view view3 as select dealer.name, count(sell.dealer_id), avg(sell.amount), sum(sell.amount)
from sell inner join dealer on sell.dealer_id = dealer.id
group by dealer.name;

select * from view3;
--d
drop view view4;
create view view4 as select dealer.name, sum(sell.amount)*dealer.charge, dealer.location
from sell inner join dealer on sell.dealer_id = dealer.id
group by dealer.name, dealer.location, dealer.charge;

select * from view4;
--e
drop view viewww;
create view viewww as select count(sell.id), avg(sell.amount), sum(sell.amount), dealer.location
from sell inner join dealer on sell.dealer_id = dealer.id
group by dealer.location;

select * from viewww;


--f
drop view view5;
create view view5 as select count(sell.id), avg(sell.amount), sum(c.priority - sell.amount)
from sell inner join client c on sell.client_id = c.id
group by c.city;

select * from view5;
--e
drop view view6;
create view view6 as select client.name, client.priority, s.amount, d.location
from client inner join dealer d on d.id = client.dealer_id inner join sell s on client.id = s.client_id
where client.priority > s.amount;
select * from view6;

select * from client;
select * from dealer;