-- LAB 8
-- task 1.1
CREATE FUNCTION inc(val integer) RETURNS integer AS
    $$
    BEGIN
        RETURN val + 1;
        END;
    $$
    LANGUAGE PLPGSQL;


drop function inc;

select inc(1);

-- task 1.2
create or replace function inc(val integer, val1 integer) returns integer as
    $$
    begin
        return val + val1;
    end;
    $$
language plpgsql;

select inc(1, 2);

-- task 1.3
create or replace function inc(val integer) returns boolean as
    $$
    begin
        if val % 2 = 0
            then return true;
        else
            return false;
        end if;
    end;
    $$
language plpgsql;

select inc(4);

-- task 1.5
create or replace function hi_lo(
val integer,
val1 integer,
out hi integer,
out lo integer) as
    $$
    begin
        hi = greatest(val, val1);
        lo = least(val, val1);
    end;
    $$
language plpgsql;

select hi_lo(3,2);

-- task 1.4
create or replace function inc5(password varchar) returns varchar as
    $$
    begin
        if length(password) >= 10
            then return 'ACCEPT';
        else
            return 'ERROR';
        end if;
    end;
    $$
language plpgsql;

drop function inc5;

select inc2('12adasda363463');



create table person(
    id integer primary key,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexp integer,
    discount integer
);

-- task 2.2
UPDATE person
SET name = 'Johny'
WHERE ID = 123;
insert into person(id, salary) values(123, 10000);

CREATE OR REPLACE FUNCTION tr1()
  RETURNS TRIGGER

  AS
$$
BEGIN
     NEW.age = extract(year from age(old.date_of_birth));
     select now();
     RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


CREATE TRIGGER trig1
  BEFORE UPDATE
  ON person
  FOR EACH ROW
  EXECUTE PROCEDURE tr1();


-- task 2.3
CREATE OR REPLACE FUNCTION tr2()
  RETURNS TRIGGER

  AS
$$
BEGIN
     NEW.salary = old.salary * 0.12 + old.salary;
     RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;


CREATE TRIGGER trig2
  BEFORE UPDATE
  ON person
  FOR EACH ROW
  EXECUTE PROCEDURE tr2();

-- task 2.1
alter table person add last_date timestamp NULL;

CREATE OR REPLACE FUNCTION tr3()
  RETURNS TRIGGER

  AS
$$
BEGIN
    NEW.salary = old.salary * 0.12 + old.salary;
    new.last_date = current_timestamp;
    return new;
END;
$$
LANGUAGE PLPGSQL;


CREATE TRIGGER trig3
  after UPDATE
  ON person
  FOR EACH ROW
  EXECUTE PROCEDURE tr3();

select last_date
    from person;

UPDATE person
SET name = 'Johny'
WHERE ID = 123;


-- task 2.4
CREATE OR REPLACE FUNCTION tr4()
  RETURNS TRIGGER

  AS
$$
BEGIN
     RAISE EXCEPTION 'Deletion is prohibited';
END;
$$
LANGUAGE PLPGSQL;

drop trigger if exists trig4 on person;

CREATE TRIGGER trig4
  before DELETE
  ON person
  FOR EACH ROW
  EXECUTE PROCEDURE tr4();


-- task 2.5
CREATE OR REPLACE FUNCTION tr5()
  RETURNS TRIGGER

  AS
$$
BEGIN
     perform inc5(new.name);
     perform hi_lo(500000, new.salary);
     return new;
END;
$$
LANGUAGE PLPGSQL;

drop trigger if exists trig5 on person;

CREATE TRIGGER trig5
  after update
  ON person
  FOR EACH ROW
  EXECUTE PROCEDURE tr5();

-- task 3
-- A function is used to calculate result using given inputs.
-- A procedure is used to perform certain task in order.
-- A function can be called by a procedure.
-- A procedure cannot be called by a function.
-- DML statements cannot be executed within a function.
-- DML statements can be executed within a procedure.
-- A select statement can have a function call.
-- A select statement can't have a procedure call

-- task 4
create or replace procedure p1() as
    $$
    begin
        UPDATE person
        SET
            salary = salary * power(1.1, workexp / 2),
            discount = 10 + workexp / 5;
    end;
    $$
language plpgsql;


create or replace procedure p2() as
    $$
    begin
        UPDATE person
        SET
            salary = (salary + salary * 0.15 * mini(1, age / 40)) * (1 + 0.15 * mini(1, workexp/9)),
            discount = 20 * mini(1, workexp/9);
    end;
    $$
language plpgsql;

call p1();
call p2();

CREATE OR REPLACE FUNCTION mini(a numeric, b numeric)  RETURNS numeric AS $$
    BEGIN
        if a > b then return b;
        else return a;
        end if;
    END;
    $$ LANGUAGE plpgsql;

-- task 5
WITH RECURSIVE recommenders(recommender) as (
  SELECT recommendedby FROM members WHERE memid between 12 and 22
  UNION ALL
  SELECT mems.recommendedby
  FROM recommenders recs
  INNER JOIN members AS mems ON mems.memid = recs.recommender
)
SELECT mems. memid, recs.recommender
FROM recommenders AS recs
INNER JOIN members AS mems ON recs.recommender = mems.memid
ORDER By memid asc, recs.recommender desc;


create table members(
    memid integer primary key,
    recommendedby integer,
    foreign key(recommendedby) references members(memid)
);