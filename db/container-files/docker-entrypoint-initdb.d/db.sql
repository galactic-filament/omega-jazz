CREATE TABLE Posts (
    id SERIAL PRIMARY KEY,
    body VARCHAR(32)
);
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255),
    hashed_password VARCHAR(255)
)
