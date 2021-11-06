-- 1 a
SELECT *
FROM dealer
         cross join client;

-- 1 b
SELECT d.name, c.name, c.city, c.priority, s.id as sell_number, s.date, s.amount
FROM dealer as d
         inner join client as c on d.id = c.dealer_id
         inner join sell as s on c.id = s.client_id
ORDER BY d.id;

-- 1 c
SELECT d.name, c.name, city
from dealer as d
         inner join client as c on d.location = c.city;

-- 1 d
SELECT s.id, amount, name, city
FROM sell as s
         inner join client
                    on amount >= 100 AND amount <= 500 and s.client_id = client.id
order by amount;

-- 1 e
SELECT d.id, d.name
FROM client
         right join dealer as d
                    on d.id = client.dealer_id;

-- 1 f
SELECT c.name, city, d.name, charge
FROM client c
         inner join dealer d on c.dealer_id = d.id;

-- 1 g
SELECT c.name, city, d.name, charge
FROM client c
         inner join dealer d on c.dealer_id = d.id and charge > 0.12;

-- 1 h
SELECT c.name, city, s.id, s.date, amount, d.name, charge
FROM client c
         left join dealer d on c.dealer_id = d.id
         left join sell s on c.id = s.client_id;

-- 1 i
SELECT c.name,
       c.city,
       c.priority,
       d.name,
       s.id,
       s.date,
       s.amount
FROM client c
         RIGHT OUTER JOIN dealer d
                          ON d.id = c.dealer_id
         LEFT OUTER JOIN sell s
                         ON s.client_id = c.id
WHERE s.amount >= 2000
  and c.priority is NOT NULL;
