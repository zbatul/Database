-- stores
INSERT INTO solution.store (sname) VALUES
	('Ace Hardware'),
	('Home Depot'),
	('Lowe''s')
	;
	
-- products
INSERT INTO solution.product (pname, ptype, manufacturer, model) VALUES
	('MCS 10B Charcoal Bullet Smoker', 'charcoal smoker', 'Masterbuilt', 'MB25060616'),
	('Double Grid Charcoal Water Smoker in Black', 'charcoal smoker', 'Americana', '5023I4.181'),
	('6 in. W Steel Garden Hoe', 'hoe', 'Ace', '7012859'),
	('54 in. Wood Handle Action Hoe', 'hoe', 'Ames', '2825800'),
	('54-in Wood-Handle Garden Hoe', 'hoe', 'True Temper', '3687000'),
	('Venetian Velvet Decorative Pillow 18x18 Teal Blue', 'throw pillow', 'Seaside Resort', '15711A')
	;
INSERT INTO solution.product (pname, ptype, manufacturer, model) VALUES
	('18x18 L Oatmeal Faux linen Square Indoor Pillow', 'throw pillow',
	'Allen + Roth', 'TH014337001LOW');

-- offerings at each store
INSERT INTO solution.offers (store_id, prod_id, price) VALUES
	(1, 1, 54.99),
	(3, 1, 64.79),
	(2, 2, 62.98),
	(1, 3, 14.99),
	(2, 4, 17.98),
	(3, 5, 12.98),
	(2, 6, 15.99)
	;
	
INSERT INTO solution.offers (store_id, prod_id, price) VALUES
	(3, 7, 14.98);
