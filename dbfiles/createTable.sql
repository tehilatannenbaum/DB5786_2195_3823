-- Customer table
CREATE TABLE Customer (
    customer_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (customer_id)
);

-- RestaurantTable table
CREATE TABLE RestaurantTable (
    table_id INT NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('available','reserved','occupied')),
    PRIMARY KEY (table_id)
);

-- Reservation table
CREATE TABLE Reservation (
    reservation_id INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    number_of_guests INT NOT NULL CHECK (number_of_guests > 0),
    customer_id INT NOT NULL,
    table_id INT NOT NULL,
    PRIMARY KEY (reservation_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (table_id) REFERENCES RestaurantTable(table_id)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT NOT NULL,
    order_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending','preparing','served','cancelled')),
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    table_id INT NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (table_id) REFERENCES RestaurantTable(table_id)
);

-- MenuItem table
CREATE TABLE MenuItem (
    item_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    availability BOOLEAN NOT NULL,
    PRIMARY KEY (item_id)
);

-- OrderItem table
CREATE TABLE OrderItem (
    order_item_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    PRIMARY KEY (order_item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES MenuItem(item_id)
);