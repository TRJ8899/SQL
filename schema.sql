-- Create the Pizza Types table
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- Create the Pizzas table
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50) REFERENCES pizza_types(pizza_type_id),
    size VARCHAR(5) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Create the Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date_id DATE NOT NULL,
    time_id TIME NOT NULL
);

-- Create the Order Details table
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    pizza_id VARCHAR(50) REFERENCES pizzas(pizza_id),
    quantity INT NOT NULL
);