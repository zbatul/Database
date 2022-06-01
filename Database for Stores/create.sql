CREATE SCHEMA solution; -- if necessary

-- create tables for stores offering a set of products
-- table with minimal store information
CREATE TABLE solution.store (
	sid SERIAL PRIMARY KEY,
	sname VARCHAR(30) NOT NULL
);

-- products offered at these stores
CREATE TABLE solution.product (
	pid BIGSERIAL PRIMARY KEY,
	pname VARCHAR(50) NOT NULL,
	ptype VARCHAR(30) NOT NULL, -- products with the same ptype are interchangeable
	manufacturer VARCHAR(50) NOT NULL,
	model VARCHAR(50) NOT NULL
);

-- which products are offered by which stores
-- this represents the many-to-many relationship between store and product
CREATE TABLE solution.offers (
	oid BIGSERIAL PRIMARY KEY,
	store_id INT NOT NULL REFERENCES solution.store,
	prod_id BIGINT NOT NULL REFERENCES solution.product,
	price MONEY NOT NULL,
	UNIQUE(store_id, prod_id)	-- should only have one price at a time for a store offering a product
);
