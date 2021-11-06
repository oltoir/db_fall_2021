-- 2 a
CREATE VIEW each_date_amount
AS
SELECT
        date, COUNT (DISTINCT client_id),
        AVG (amount), SUM (amount)
        FROM sell
        GROUP BY date
        ORDER BY date;

-- 2 b
CREATE VIEW each_date_sum
AS
SELECT
        date, sum (amount)
        from sell
        group by date
        order by sum (amount) desc limit 5;

-- 2 c
CREATE VIEW dealers_sale AS
SELECT dealer_id, count(dealer_id), AVG(amount), SUM(amount)
from sell
group by dealer_id
ORDER BY dealer_id;

-- 2 d
-- DROP VIEW earnings;
CREATE VIEW earnings AS
SELECT location, sum(total)
FROM (SELECT d.location, SUM(amount) * d.charge as total
      FROM sell
               inner join dealer d on sell.dealer_id = d.id
      group by d.location, d.charge) q
group by location
having location = q.location;

-- 2 e
-- drop view city_dealer;
create view city_dealer as
SELECT location, count(sell.id), sum(amount), avg(amount)
from sell
         inner join dealer on sell.dealer_id = dealer.id
GROUP BY location;

-- 2 f
create view each_city as
SELECT city, count(city), sum(amount), avg(amount)
from client
         inner join sell s on client.id = s.client_id
GROUP BY city;

-- 2 g
CREATE VIEW q AS
SELECT cit
from (SELECT sum(amount) as sales, location as loc
      FROM sell
               INNER JOIN dealer on sell.dealer_id = dealer.id
      group by location) q
         inner join (select city as cit, sum(amount) as expences
                     from client
                              inner join sell on client.id = sell.client_id
                     group by city) w ON expences > sales
    and q.loc = w.cit;