create sequence ads_seq start with 1 increment by 50;
create sequence category_seq start with 1 increment by 50;
create sequence chats_seq start with 1 increment by 50;
create sequence comments_seq start with 1 increment by 50;
create sequence favorites_seq start with 1 increment by 50;
create sequence images_seq start with 1 increment by 50;
create sequence messages_seq start with 1 increment by 50;
create sequence users_seq start with 1 increment by 50;
create sequence tokens_seq start with 1 increment by 50;

create table ads (
    id bigint not null,
    is_active boolean not null,
    views integer not null,
    category_id bigint,
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
    id bigint not null,
    ad_id bigint,
    message_id bigint,
    owner_id bigint,
    receiver_id bigint,
    primary key (id)
);

create table comments (
    id bigint not null,
    rating integer not null,
    convicted_id bigint,
    owner_id bigint,
    created varchar(255),
    text varchar(255),
    primary key (id)
);

create table favorites (
    id bigint not null,
    ad_id bigint,
    user_id bigint,
    primary key (id)
);

create table images (
    id bigint not null,
    ad_id bigint,
    image_bytes bytea,
    primary key (id)
);

create table tokens (
    id bigint not null,
    user_id bigint,
    device_token varchar(255),
    primary key (id)
);

create table messages (
    id bigint not null,
    chat_id bigint,
    user_id bigint,
    content varchar(255),
    data varchar(255),
    primary key (id)
);

create table users (
    id bigint not null,
    rating_all integer not null,
    rating_num integer not null,
    address varchar(255),
    email varchar(255),
    name varchar(255),
    password varchar(255),
    phone varchar(255),
    username varchar(255),
    deviceToken varchar(255),
    avatar bytea,
    primary key (id)
);

alter table if exists ads add constraint ads_category_fk foreign key (category_id) references category;
alter table if exists ads add constraint ads_user_fk foreign key (users_id) references users;
alter table if exists chats add constraint chats_ads_fk foreign key (ad_id) references ads;
alter table if exists chats add constraint chats_message_fk foreign key (message_id) references messages;
alter table if exists chats add constraint chats_owner_fk foreign key (owner_id) references users;
alter table if exists chats add constraint chats_receiver_fk foreign key (receiver_id) references users;
alter table if exists comments add constraint comments_convicted_fk foreign key (convicted_id) references users;
alter table if exists comments add constraint comments_owner_fk foreign key (owner_id) references users;
alter table if exists favorites add constraint favorites_ads_fk foreign key (ad_id) references ads;
alter table if exists favorites add constraint favorites_users_fk foreign key (user_id) references users;
alter table if exists images add constraint images_ads_fk foreign key (ad_id) references ads;
alter table if exists messages add constraint messages_chats_fk foreign key (chat_id) references chats;
alter table if exists messages add constraint messages_user_fk foreign key (user_id) references users;
alter table if exists tokens add constraint tokens_user_fk foreign key (user_id) references users;