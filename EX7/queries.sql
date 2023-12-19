CREATE TABLE person
(
    login_name   VARCHAR(9) NOT NULL PRIMARY KEY,
    display_name TEXT
);

CREATE TABLE person_audit
(
    login_name   VARCHAR(9) NOT NULL,
    display_name TEXT,
    operation    VARCHAR,
    effective_at TIMESTAMP  NOT NULL DEFAULT NOW(),
    userid       NAME       NOT NULL DEFAULT session_user
);

-- Q1
CREATE FUNCTION log_person() RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO person_audit (login_name, display_name, operation) VALUES (OLD.login_name, OLD.display_name, TG_OP);
        RETURN OLD;
    END IF;
    IF NEW.login_name ~ '\s' OR NEW.display_name ~ '\s' THEN
        RAISE EXCEPTION 'Login name and display name cannot contain space';
    END IF;
    IF NEW.login_name = '' OR NEW.display_name = '' THEN
        RAISE EXCEPTION 'Login name and display name cannot be empty';
    END IF;
    INSERT INTO person_audit (login_name, display_name, operation) VALUES (NEW.login_name, NEW.display_name, TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_person
    BEFORE INSERT OR UPDATE OR DELETE
    ON person
    FOR EACH ROW
EXECUTE PROCEDURE log_person();

INSERT INTO person (login_name, display_name)
VALUES ('johndoe', 'John Doe');
INSERT INTO person (login_name, display_name)
VALUES ('janedoe', '');
INSERT INTO person (login_name, display_name)
VALUES ('johndoe', 'JohnDoe');
UPDATE person
SET display_name = 'John Doe'
WHERE login_name = 'johndoe';
DELETE
FROM person
WHERE login_name = 'johndoe';

-- Q2

ALTER TABLE person
    ADD COLUMN abstract TEXT;
ALTER TABLE person
    ADD COLUMN ts_abstract TSVECTOR;
ALTER TABLE person_audit
    ADD COLUMN abstract TEXT;

CREATE OR REPLACE FUNCTION log_person() RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO person_audit (login_name, display_name, abstract, operation)
        VALUES (OLD.login_name, OLD.display_name, OLD.abstract, TG_OP);
        RETURN OLD;
    END IF;
    IF NEW.login_name ~ '\s' OR NEW.display_name ~ '\s' THEN
        RAISE EXCEPTION 'Login name and display name cannot contain space';
    END IF;
    IF NEW.login_name = '' OR NEW.display_name = '' THEN
        RAISE EXCEPTION 'Login name and display name cannot be empty';
    END IF;
    INSERT INTO person_audit (login_name, display_name, abstract, operation)
    VALUES (NEW.login_name, NEW.display_name, NEW.abstract, TG_OP);
    NEW.ts_abstract := to_tsvector(NEW.abstract);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

INSERT INTO person (login_name, display_name, abstract)
VALUES ('MisaghM', 'ThePerson', 'I am a ab abc a');

-- Q3
CREATE VIEW abridged_person AS
SELECT login_name, display_name, abstract
FROM person;

INSERT INTO abridged_person (login_name, display_name, abstract)
VALUES ('MisaghM', 'ThePerson', 'I am a person');

-- Q4
ALTER TABLE person
    ADD COLUMN balance MONEY DEFAULT 0;

CREATE TABLE transactions
(
    login_name  CHARACTER VARYING(9) NOT NULL,
    post_date   DATE,
    description CHARACTER VARYING,
    debit       MONEY,
    credit      MONEY,
    FOREIGN KEY (login_name) REFERENCES person (login_name)
);

CREATE OR REPLACE FUNCTION check_transaction() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.debit::money::numeric::integer < 0 OR NEW.credit::money::numeric::integer < 0 THEN
        RAISE EXCEPTION 'Debit and credit cannot be negative';
    END IF;
    IF (SELECT balance FROM person WHERE login_name = NEW.login_name) < NEW.debit - NEW.credit THEN
        RAISE EXCEPTION 'Balance cannot be negative';
    END IF;
    UPDATE person
    SET balance = balance + NEW.credit - NEW.debit
    WHERE login_name = NEW.login_name;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_transaction
    BEFORE INSERT OR UPDATE
    ON transactions
    FOR EACH ROW
EXECUTE PROCEDURE check_transaction();

INSERT INTO transactions (login_name, post_date, description, debit, credit)
VALUES ('MisaghM', '2016-01-01', 'First transaction', 0, 100);
INSERT INTO transactions (login_name, post_date, description, debit, credit)
VALUES ('MisaghM', '2016-01-02', 'Second transaction', 200, 0);
INSERT INTO transactions (login_name, post_date, description, debit, credit)
VALUES ('MisaghM', '2016-01-02', 'third transaction', 0, -100);

-- Q5
CREATE OR REPLACE VIEW abridged_person AS
SELECT login_name, display_name, abstract, balance
FROM person;

CREATE OR REPLACE FUNCTION revoke_balance_update() RETURNS TRIGGER AS
$$
BEGIN
    IF OLD.balance <> NEW.balance THEN
        RAISE EXCEPTION 'Balance cannot be updated';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER revoke_balance_update
    BEFORE UPDATE
    ON person
    FOR EACH ROW
EXECUTE PROCEDURE revoke_balance_update();

UPDATE person
SET balance = 200
WHERE login_name = 'MisaghM';

-- Q6
CREATE USER eve;

GRANT SELECT, INSERT, UPDATE ON abridged_person TO eve;
GRANT SELECT, INSERT ON transactions TO eve;

SET SESSION AUTHORIZATION eve;
RESET SESSION AUTHORIZATION;

CREATE OR REPLACE FUNCTION log_person() RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO person_audit (login_name, display_name, abstract, operation)
        VALUES (OLD.login_name, OLD.display_name, OLD.abstract, TG_OP);
        RETURN OLD;
    END IF;
    IF NEW.login_name ~ '\s' OR NEW.display_name ~ '\s' THEN
        RAISE EXCEPTION 'Login name and display name cannot contain space';
    END IF;
    IF NEW.login_name = '' OR NEW.display_name = '' THEN
        RAISE EXCEPTION 'Login name and display name cannot be empty';
    END IF;
    INSERT INTO person_audit (login_name, display_name, abstract, operation)
    VALUES (NEW.login_name, NEW.display_name, NEW.abstract, TG_OP);
    NEW.ts_abstract := to_tsvector(NEW.abstract);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
    SECURITY DEFINER;

INSERT INTO abridged_person (login_name, display_name, abstract)
VALUES ('Pasha', 'Patrick', 'I am not sponge bob');

DELETE
FROM abridged_person
WHERE login_name = 'Pasha';

SELECT *
FROM transactions
WHERE login_name = 'MisaghM';

UPDATE transactions
SET credit = 100
WHERE login_name = 'MisaghM';
