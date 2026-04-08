CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Sample Data
INSERT INTO clinics VALUES 
('c1', 'Wellness Clinic', 'New York', 'NY', 'USA'),
('c2', 'HealthCity', 'New York', 'NY', 'USA'),
('c3', 'CarePoint', 'Buffalo', 'NY', 'USA'),
('c4', 'Sunrise Health', 'Los Angeles', 'CA', 'USA');

INSERT INTO customer VALUES 
('cust1', 'Alice', '9811111111'),
('cust2', 'Bob', '9822222222');

INSERT INTO clinic_sales VALUES 
('s1', 'cust1', 'c1', 5000, '2021-09-15 10:00:00', 'Online'),
('s2', 'cust2', 'c1', 3000, '2021-09-16 11:00:00', 'Walk-in'),
('s3', 'cust1', 'c2', 2000, '2021-09-15 12:00:00', 'Online'),
('s4', 'cust1', 'c1', 1000, '2021-08-10 10:00:00', 'Online'); -- Previous month for testing

INSERT INTO expenses VALUES 
('e1', 'c1', 'Supplies', 2000, '2021-09-01 09:00:00'),
('e2', 'c1', 'Rent', 1500, '2021-09-02 10:00:00'),
('e3', 'c2', 'Supplies', 500, '2021-09-01 09:00:00');