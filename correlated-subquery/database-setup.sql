-- Database
CREATE TABLE departments (
    id      SERIAL   PRIMARY KEY,
    name    VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    id          BIGSERIAL       PRIMARY KEY,
    last_name   VARCHAR(250)    NOT NULL,
    first_name  VARCHAR(250)    NOT NULL,
    birth_date  DATE            NOT NULL,
    hire_date   DATE            NOT NULL,
    department  INTEGER         REFERENCES departments(id) NOT NULL,
    salary      MONEY           NOT NULL
);
CREATE INDEX employees_last_name_idx ON employees(last_name);
CREATE INDEX employees_department_idx ON employees(department);

-- Data
INSERT INTO departments(id, name) VALUES (1, 'accounting');
INSERT INTO departments(id, name) VALUES (2, 'sales');
INSERT INTO departments(id, name) VALUES (3, 'engineering');
INSERT INTO departments(id, name) VALUES (4, 'manufacturing');
INSERT INTO departments(id, name) VALUES (5, 'information technology');
INSERT INTO departments(id, name) VALUES (6, 'operations');
