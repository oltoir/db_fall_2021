CREATE DATABASE labka_7;

create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');

--1.

--blob: binary large object -- object is a large collection of uninterpreted binary data
-- (whose interpretation is left to an application outside of the database system)
--clob: character large object -- object is a large collection of character data

--2.

--Privileges - what the user is allowed to do
--Role - is a specific set of rights that can be assigned to a specific user or group of users.
--User is the ID of the login name when connecting to the database.

--2.1
CREATE ROLE accountant;
CREATE ROLE administrator;
CREATE ROLE support;

GRANT SELECT, INSERT ON accounts, transactions TO accountant;
GRANT ALL PRIVILEGES ON accounts, customers, transactions TO administrator;
GRANT UPDATE, INSERT, DELETE ON accounts, customers TO support;
--2.2
CREATE USER joe;
CREATE USER mama;
CREATE USER deez;

GRANT accountant TO joe;
GRANT administrator TO mama;
GRANT support TO deez;
--2.3
CREATE USER nuts;
GRANT ALL PRIVILEGES on accounts, customers, transactions TO nuts WITH GRANT OPTION;
--2.4
REVOKE SELECT ON accounts, customers, transactions FROM nuts;


--3.

--3.1
ALTER TABLE accounts
    ALTER COLUMN currency SET NOT NULL;
ALTER TABLE transactions
    ALTER COLUMN status SET NOT NULL;

--5.

--5.1
CREATE INDEX account_currency ON accounts(customer_id, currency);
--5.2
CREATE INDEX account_balance ON accounts(currency, balance);
