create sequence ads_seq start with 1 increment by 50;
create sequence category_seq start with 1 increment by 50;
create sequence chats_seq start with 1 increment by 50;
create sequence comments_seq start with 1 increment by 50;
create sequence favorites_seq start with 1 increment by 50;
create sequence images_seq start with 1 increment by 50;
create sequence messages_seq start with 1 increment by 50;
create sequence users_seq start with 1 increment by 50;

create table ads (
    is_active boolean not null,
    views integer not null,
    category_id bigint,
    id bigint not null,
    price bigint not null,
    users_id bigint,
    created varchar(255),
    description varchar(255),
    title varchar(255),
    primary key (id)
);

create table category (
    id bigint not null,
    name varchar(255),
    path varchar(255),
    primary key (id)
);

create table chats (
    ad_id bigint,
    id bigint not null,
    owner_id bigint,
    receiver_id bigint,
    primary key (id)
);

create table comments (
    rating integer not null,
    convicted_id bigint,
    id bigint not null,
    owner_id bigint,
    created varchar(255),
    text varchar(255),
    primary key (id)
);

create table favorites (
    ad_id bigint,
    id bigint not null,
    user_id bigint,
    primary key (id)
);

create table images (
    ad_id bigint,
    id bigint not null,
    image_bytes bytea,
    primary key (id)
);

create table messages (
    chat_id bigint,
    id bigint not null,
    user_id bigint,
    content varchar(255),
    data varchar(255),
    primary key (id)
);

create table users (
rating_all integer not null,
    rating_num integer not null,
    id bigint not null,
    address varchar(255),
    email varchar(255),
    name varchar(255),
    password varchar(255),
    phone varchar(255),
    username varchar(255),
    avatar bytea,
    primary key (id)
);

alter table if exists ads add constraint ads_category_fk foreign key (category_id) references category;
alter table if exists ads add constraint ads foreign key (users_id) references users;
alter table if exists chats add constraint chats_ads_fk foreign key (ad_id) references ads;
alter table if exists chats add constraint chats_owner_fk foreign key (owner_id) references users;
alter table if exists chats add constraint chats_receiver_fk foreign key (receiver_id) references users;
alter table if exists comments add constraint comments_convicted_fk foreign key (convicted_id) references users;
alter table if exists comments add constraint comments_owner_fk foreign key (owner_id) references users;
alter table if exists favorites add constraint favorites_ads_fk foreign key (ad_id) references ads;
alter table if exists favorites add constraint favorites_users_fk foreign key (user_id) references users;
alter table if exists images add constraint images_ads_fk foreign key (ad_id) references ads;
alter table if exists messages add constraint messages_chats_fk foreign key (chat_id) references chats;
alter table if exists messages add constraint messages_user_fk foreign key (user_id) references users;