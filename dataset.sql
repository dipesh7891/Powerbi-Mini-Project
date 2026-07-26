CREATE TABLE category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(10),
    launch_date DATE,
    price NUMERIC(10,2),
    
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES category(category_id)
);

CREATE TABLE stores (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE sales (
    sale_id VARCHAR(20) PRIMARY KEY,
    sale_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INTEGER,
    
    CONSTRAINT fk_sales_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE warranty (
    claim_id VARCHAR(20) PRIMARY KEY,
    claim_date DATE,
    sale_id VARCHAR(20),
    repair_status VARCHAR(50),

    CONSTRAINT fk_warranty_sale
        FOREIGN KEY (sale_id)
        REFERENCES sales(sale_id)
);