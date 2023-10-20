-- Create the 'ecommerce' schema
CREATE SCHEMA ecommerce;

-- Set the 'ecommerce' schema as the default schema
SET search_path TO ecommerce;

-- Create the 'products' table within the 'ecommerce' schema
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the 'stock' table within the 'ecommerce' schema
CREATE TABLE stock (
    stock_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    location VARCHAR(255),
    last_updated TIMESTAMPTZ DEFAULT NOW()
);

-- Create the 'orders' table within the 'ecommerce' schema
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    order_date TIMESTAMPTZ DEFAULT NOW(),
    total_amount DECIMAL(10, 2) NOT NULL
);

-- Insert data into the 'products' table
INSERT INTO products (product_name, price, description)
VALUES
    ('Product A', 19.99, 'Description for Product A'),
    ('Product B', 29.99, 'Description for Product B'),
    ('Product C', 39.99, 'Description for Product C');

-- Insert data into the 'stock' table
INSERT INTO stock (product_id, quantity, location)
VALUES
    (1, 100, 'Warehouse A'),
    (2, 50, 'Warehouse B'),
    (3, 75, 'Warehouse C');

-- Insert data into the 'orders' table
INSERT INTO orders (customer_name, total_amount)
VALUES
    ('Customer X', 49.98),
    ('Customer Y', 89.97),
    ('Customer Z', 29.99);