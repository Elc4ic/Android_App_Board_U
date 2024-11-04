-- Drop constraints if they exist
ALTER TABLE IF EXISTS ads
    DROP CONSTRAINT IF EXISTS fk_ads_category,
    DROP CONSTRAINT IF EXISTS fk_ads_user;

ALTER TABLE IF EXISTS avatars
    DROP CONSTRAINT IF EXISTS fk_avatars_user;

ALTER TABLE IF EXISTS chat_members
    DROP CONSTRAINT IF EXISTS fk_chat_members_user,
    DROP CONSTRAINT IF EXISTS fk_chat_members_chat;

ALTER TABLE IF EXISTS chats
    DROP CONSTRAINT IF EXISTS fk_chats_ad,
    DROP CONSTRAINT IF EXISTS fk_chats_last_message;

ALTER TABLE IF EXISTS comments
    DROP CONSTRAINT IF EXISTS fk_comments_convicted,
    DROP CONSTRAINT IF EXISTS fk_comments_creator;

ALTER TABLE IF EXISTS favorites
    DROP CONSTRAINT IF EXISTS fk_favorites_ad,
    DROP CONSTRAINT IF EXISTS fk_favorites_user;

ALTER TABLE IF EXISTS images
    DROP CONSTRAINT IF EXISTS fk_images_ad;

ALTER TABLE IF EXISTS messages
    DROP CONSTRAINT IF EXISTS fk_messages_chat,
    DROP CONSTRAINT IF EXISTS fk_messages_user;

ALTER TABLE IF EXISTS tokens
    DROP CONSTRAINT IF EXISTS fk_tokens_user;

ALTER TABLE IF EXISTS unread_counter
    DROP CONSTRAINT IF EXISTS fk_unread_counter_chat,
    DROP CONSTRAINT IF EXISTS fk_unread_counter_user;

-- Drop tables if they exist
DROP TABLE IF EXISTS ads CASCADE;
DROP TABLE IF EXISTS avatars CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS chat_members CASCADE;
DROP TABLE IF EXISTS chats CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS favorites CASCADE;
DROP TABLE IF EXISTS images CASCADE;
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS tokens CASCADE;
DROP TABLE IF EXISTS unread_counter CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create tables
CREATE TABLE ads (
    is_active BOOLEAN NOT NULL,
    views INTEGER NOT NULL,
    created TIMESTAMP(6),
    price BIGINT NOT NULL,
    category_id UUID,
    id UUID NOT NULL,
    users_id UUID,
    description VARCHAR(255),
    title VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE avatars (
    id UUID NOT NULL,
    user_id UUID UNIQUE,
    image_bytes BYTEA,
    PRIMARY KEY (id)
);

CREATE TABLE category (
    id UUID NOT NULL,
    name VARCHAR(255),
    path VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE chat_members (
    chat_id UUID NOT NULL,
    user_id UUID NOT NULL,
    PRIMARY KEY (chat_id, user_id)
);

CREATE TABLE chats (
    ad_id UUID,
    id UUID NOT NULL,
    last_message_id UUID UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE comments (
    rating INTEGER NOT NULL,
    created TIMESTAMP(6),
    convicted_id UUID,
    creator_id UUID,
    id UUID NOT NULL,
    text VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE favorites (
    ad_id UUID,
    id UUID NOT NULL,
    user_id UUID,
    PRIMARY KEY (id)
);

CREATE TABLE images (
    ad_id UUID,
    id UUID NOT NULL,
    image_bytes BYTEA,
    PRIMARY KEY (id)
);

CREATE TABLE messages (
    data TIMESTAMP(6),
    chat_id UUID,
    id UUID NOT NULL,
    user_id UUID,
    content VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE tokens (
    id UUID NOT NULL,
    user_id UUID UNIQUE,
    device_token VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE unread_counter (
    count INTEGER NOT NULL,
    chat_id UUID,
    id UUID NOT NULL,
    user_id UUID,
    PRIMARY KEY (id)
);

CREATE TABLE users (
    is_online BOOLEAN,
    notify BOOLEAN NOT NULL,
    id UUID NOT NULL,
    address VARCHAR(255),
    email VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255),
    phone VARCHAR(255),
    role VARCHAR(255) CHECK (role IN ('USER', 'MODER', 'ADMIN')),
    username VARCHAR(255),
    PRIMARY KEY (id)
);

-- Add foreign key constraints
ALTER TABLE IF EXISTS ads
    ADD CONSTRAINT fk_ads_category FOREIGN KEY (category_id) REFERENCES category,
    ADD CONSTRAINT fk_ads_user FOREIGN KEY (users_id) REFERENCES users;

ALTER TABLE IF EXISTS avatars
    ADD CONSTRAINT fk_avatars_user FOREIGN KEY (user_id) REFERENCES users;

ALTER TABLE IF EXISTS chat_members
    ADD CONSTRAINT fk_chat_members_user FOREIGN KEY (user_id) REFERENCES users,
    ADD CONSTRAINT fk_chat_members_chat FOREIGN KEY (chat_id) REFERENCES chats;

ALTER TABLE IF EXISTS chats
    ADD CONSTRAINT fk_chats_ad FOREIGN KEY (ad_id) REFERENCES ads,
    ADD CONSTRAINT fk_chats_last_message FOREIGN KEY (last_message_id) REFERENCES messages;

ALTER TABLE IF EXISTS comments
    ADD CONSTRAINT fk_comments_convicted FOREIGN KEY (convicted_id) REFERENCES users,
    ADD CONSTRAINT fk_comments_creator FOREIGN KEY (creator_id) REFERENCES users;

ALTER TABLE IF EXISTS favorites
    ADD CONSTRAINT fk_favorites_ad FOREIGN KEY (ad_id) REFERENCES ads,
    ADD CONSTRAINT fk_favorites_user FOREIGN KEY (user_id) REFERENCES users;

ALTER TABLE IF EXISTS images
    ADD CONSTRAINT fk_images_ad FOREIGN KEY (ad_id) REFERENCES ads;

ALTER TABLE IF EXISTS messages
    ADD CONSTRAINT fk_messages_chat FOREIGN KEY (chat_id) REFERENCES chats,
    ADD CONSTRAINT fk_messages_user FOREIGN KEY (user_id) REFERENCES users;

ALTER TABLE IF EXISTS tokens
    ADD CONSTRAINT fk_tokens_user FOREIGN KEY (user_id) REFERENCES users;

ALTER TABLE IF EXISTS unread_counter
    ADD CONSTRAINT fk_unread_counter_chat FOREIGN KEY (chat_id) REFERENCES chats,
    ADD CONSTRAINT fk_unread_counter_user FOREIGN KEY (user_id) REFERENCES users;