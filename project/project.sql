create table brand(
    id serial primary key,
    name varchar(20) not null
);

create table model(
    id serial primary key,
    brand_id integer references brand(id),
    name varchar(20) not null
);

create table body_style(
    id serial primary key,
    model_id integer references model(id),
    name varchar(20) not null
);

create table color_type(
    id serial primary key,
    type varchar(20) not null
);

create table engine_type(
    id serial primary key,
    tact varchar(20) not null,
    work_volume_cubic_cm integer not null,
    number_of_valves integer not null,
    cooling_system varchar(20) not null
);

create table transmission_type(
    id serial primary key,
    type varchar(25) not null
);

create table vehicle(
    VIN serial primary key,
    type_id integer references body_style(id),
    color_option integer references color_type(id),
    engine_option integer references engine_type(id),
    transmisson_option integer references transmission_type(id)
);

create table vehicle_part(
    id serial primary key,
    part varchar(20) not null
);

create table vendor(
    id serial primary key,
    part_id integer references vehicle_part(id),
    certain_model integer references body_style(id)
);

create table part_factory(
    id serial primary key,
    part_id integer references vehicle_part(id),
    certain_model integer references body_style(id)
);

create table final_assemble_factory(
    id serial primary key,
    state varchar(20) not null,
    city varchar(10) not null,
    street varchar(10) not null,
    street_number integer not null
);

create table final_assemble(
    id serial primary key,
    factory_id integer references final_assemble_factory(id),
    part_1 integer references vendor(id),
    part_2 integer references part_factory(id),
    assemble_date timestamp not null
);

create table customer(
    id serial primary key,
    name varchar(20) not null,
    state varchar(20) not null,
    city varchar(10) not null,
    street varchar(10) not null,
    street_number integer not null,
    phone_number varchar(14),
    gender varchar(6) not null,
    income text
);

create table dealer(
    id serial primary key,
    name varchar(20) not null,
    phone_number varchar(14),
    email varchar(30)
);

create table warehouse(
    id serial primary key,
    dealer_id integer references dealer(id),
    state varchar(20) not null,
    city varchar(10) not null,
    street varchar(10) not null,
    street_number integer not null
);

create table buy(
    id serial primary key,
    model_id integer references body_style(id),
    warehouse_id integer references warehouse(id),
    time_of_purchase timestamp not null
);

create table for_sale(
    warehouse_id integer references warehouse(id),
    model_id integer primary key references body_style(id),
    delivery_time timestamp not null,
    pick_up_time timestamp
);

create table preserve(
    warehouse_id integer references warehouse(id),
    model_id integer primary key references body_style(id)
);

create table order_1(
    id serial primary key,
    customer_id integer references customer(id),
    order_time timestamp not null,
    total_price numeric default 0
);

create table order_item(
    id serial primary key,
    vehicle_id integer references for_sale(model_id) not null,
    quantity integer default 0,
    price numeric,
    order_id integer references order_1(id) not null
);