-- Database
CREATE TABLE product (
    id          BIGSERIAL       PRIMARY KEY,
    name        VARCHAR(50)     NOT NULL,
    attributes  TEXT            NOT NULL
);

-- Data
INSERT INTO product(name, attributes) VALUES ('product1', 'soft,waterproof,fuzzy');
INSERT INTO product(name, attributes) VALUES ('product2', 'hard,waterproof,plastic');
INSERT INTO product(name, attributes) VALUES ('product3', 'soft,fuzzy');
