
CREATE TABLE users (
    user_id       UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    username      VARCHAR(100)       NOT NULL,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100),
    email         VARCHAR(100)       NOT NULL,
    avatar        VARCHAR(255),
    password_hash VARCHAR(255) NOT NULL,
    last_seen_at  TIMESTAMPTZ,
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),

    CONSTRAINT users_username_unique UNIQUE (username),
    CONSTRAINT users_email_unique    UNIQUE (email),
    CONSTRAINT users_username_format CHECK (username ~ '^[A-Za-z0-9_.-]{3,100}$')
);

CREATE TABLE refresh_tokens (
    token_hash BYTEA       PRIMARY KEY,
    user_id    UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    family_id  UUID        NOT NULL,      -- общий id сессии
    expires_at TIMESTAMPTZ NOT NULL,
    revoked_at TIMESTAMPTZ                -- NULL = токен ещё действителен
);

CREATE INDEX refresh_tokens_user_idx   ON refresh_tokens (user_id);
CREATE INDEX refresh_tokens_family_idx ON refresh_tokens (family_id);

CREATE TABLE friendships (
    initiator_id UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    recipient_id UUID        NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    is_accepted  BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    accepted_at  TIMESTAMPTZ,

    PRIMARY KEY (initiator_id, recipient_id),
    CONSTRAINT friendships_no_self CHECK (initiator_id <> recipient_id),
    CONSTRAINT friendships_accepted_at_consistent
        CHECK ((is_accepted AND accepted_at IS NOT NULL) OR (NOT is_accepted AND accepted_at IS NULL))
);

-- Одна пара пользователей = одна запись, независимо от направления
CREATE UNIQUE INDEX friendships_pair_unique
    ON friendships (LEAST(initiator_id, recipient_id), GREATEST(initiator_id, recipient_id));

CREATE INDEX friendships_recipient_accepted_idx
    ON friendships (recipient_id, is_accepted);
