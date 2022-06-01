-- List the names of all stores that offer a specific product,
-- as defined by manufacturer and model
SELECT sname
FROM solution.store, solution.product, solution.offers
WHERE sid = store_id AND pid = prod_id
	AND manufacturer = 'Masterbuilt' AND model = 'MB25060616';

-- List the store that offers a specific product for the lowest price (include the price in the result). If there is a tie here, list all options
SELECT sname, price
FROM solution.store, solution.offers
WHERE sid = store_id AND price =
	(SELECT min(price)
	FROM solution.product, solution.offers
	WHERE pid = prod_id AND manufacturer = 'Masterbuilt' AND model = 'MB25060616')
	;

-- List your options for a type of product, as defined above. Include the store, manufacturer, model, and price
SELECT sname, manufacturer, model, price
FROM solution.store, solution.product, solution.offers
WHERE sid = store_id AND pid = prod_id
	AND ptype = 'hoe';

-- Create a temporary table for a shopping list which has one attribute, the product type,
-- with one row for each type of product you want to buy. 
CREATE TEMPORARY TABLE shopping(
	prod_type VARCHAR(30) NOT NULL
);

-- populate the shopping list
INSERT INTO shopping VALUES
	('hoe'),
	('throw pillow');

-- Now find all stores that offer at least one of these product types.
SELECT sname
FROM solution.store
WHERE NOT EXISTS
(SELECT *
 FROM shopping
 WHERE NOT EXISTS
 (SELECT *
  FROM solution.product, solution.offers
  WHERE ptype = prod_type AND prod_id = pid AND sid = store_id
  )
 );
