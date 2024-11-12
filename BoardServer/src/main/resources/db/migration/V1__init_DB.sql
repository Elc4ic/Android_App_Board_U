DROP TABLE IF EXISTS ads CASCADE;
DROP TABLE IF EXISTS avatars CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS chat_members CASCADE;
DROP TABLE IF EXISTS chats CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS fav_ads CASCADE;
DROP TABLE IF EXISTS images CASCADE;
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS tokens CASCADE;
DROP TABLE IF EXISTS unread_counter CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE ads (
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    views INTEGER NOT NULL DEFAULT 0,
    created TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    price BIGINT NOT NULL,
    category_id UUID,
    id UUID NOT NULL PRIMARY KEY,
    users_id UUID,
    description VARCHAR(255),
    title VARCHAR(255)
);

CREATE TABLE avatars (
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID UNIQUE NOT NULL,
    image_bytes BYTEA
);

CREATE TABLE category (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    path VARCHAR(255)
);

CREATE TABLE chat_members (
    chat_id UUID NOT NULL,
    user_id UUID NOT NULL,
    PRIMARY KEY (chat_id, user_id)
);

CREATE TABLE chats (
    ad_id UUID,
    id UUID NOT NULL PRIMARY KEY,
    last_message_id UUID UNIQUE
);

CREATE TABLE comments (
    rating INTEGER NOT NULL,
    created TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    convicted_id UUID,
    creator_id UUID,
    id UUID NOT NULL PRIMARY KEY,
    text VARCHAR(255)
);

CREATE TABLE fav_ads (
    ad_id UUID NOT NULL,
    user_id UUID NOT NULL,
    PRIMARY KEY (ad_id, user_id)
);

CREATE TABLE images (
    ad_id UUID,
    id UUID NOT NULL PRIMARY KEY,
    image_bytes BYTEA
);

CREATE TABLE messages (
    data TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    chat_id UUID,
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID,
    content VARCHAR(255)
);

CREATE TABLE tokens (
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID UNIQUE NOT NULL,
    device_token VARCHAR(255)
);

CREATE TABLE unread_counter (
    count INTEGER NOT NULL DEFAULT 0,
    chat_id UUID,
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID
);

CREATE TABLE users (
    is_online BOOLEAN,
    notify BOOLEAN NOT NULL DEFAULT TRUE,
    id UUID NOT NULL PRIMARY KEY,
    address VARCHAR(255),
    email VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255),
    phone VARCHAR(255),
    role VARCHAR(255) CHECK (role IN ('USER', 'MODER', 'ADMIN')),
    username VARCHAR(255)
);

ALTER TABLE ads ADD CONSTRAINT ads_category_id_fk FOREIGN KEY (category_id) REFERENCES category (id);
ALTER TABLE ads ADD CONSTRAINT ads_users_id_fk FOREIGN KEY (users_id) REFERENCES users (id);
ALTER TABLE avatars ADD CONSTRAINT avatars_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE chat_members ADD CONSTRAINT chat_members_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE chat_members ADD CONSTRAINT chat_members_chat_id_fk FOREIGN KEY (chat_id) REFERENCES chats (id);
ALTER TABLE chats ADD CONSTRAINT chats_ad_id_fk FOREIGN KEY (ad_id) REFERENCES ads (id);
ALTER TABLE chats ADD CONSTRAINT chats_last_message_id_fk FOREIGN KEY (last_message_id) REFERENCES messages (id);
ALTER TABLE comments ADD CONSTRAINT comments_convicted_id_fk FOREIGN KEY (convicted_id) REFERENCES users (id);
ALTER TABLE comments ADD CONSTRAINT comments_creator_id_fk FOREIGN KEY (creator_id) REFERENCES users (id);
ALTER TABLE fav_ads ADD CONSTRAINT fav_ads_ad_id_fk FOREIGN KEY (ad_id) REFERENCES ads (id);
ALTER TABLE fav_ads ADD CONSTRAINT fav_ads_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE images ADD CONSTRAINT images_ad_id_fk FOREIGN KEY (ad_id) REFERENCES ads (id);
ALTER TABLE messages ADD CONSTRAINT messages_chat_id_fk FOREIGN KEY (chat_id) REFERENCES chats (id);
ALTER TABLE messages ADD CONSTRAINT messages_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE tokens ADD CONSTRAINT tokens_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE unread_counter ADD CONSTRAINT unread_counter_chat_id_fk FOREIGN KEY (chat_id) REFERENCES chats (id);
ALTER TABLE unread_counter ADD CONSTRAINT unread_counter_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);