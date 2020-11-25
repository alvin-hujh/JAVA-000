DELIMITER $$
CREATE PROCEDURE add_order_info(IN n INT ,IN userId VARCHAR(64),IN  addressId VARCHAR(64))
BEGIN
	DECLARE		i INT DEFAULT 1;
	WHILE i < n DO
		INSERT INTO order_info ( `bid`, `customer_bid`, `address_bid`, `preferential_bid`, `product_unit_price`, `product_num`, `post_prize`, `pay_price`, `pay_method`, `pay_status`, `order_status`, `post_need`, `logistics_id` )
		VALUES
			(
				REPLACE ( UUID(), '-', '' ),
				CONCAT(userId,LEFT ( rand()* 1000, 3 )),
				CONCAT(addressId, LEFT ( rand()* 1000, 3 )),
				REPLACE ( UUID(), '-', '' ),
				TRUNCATE ( RAND()* 1000, 2 ),
				CEILING( RAND()* 10+100 ),
				TRUNCATE ( RAND()* 1000, 1 ),
				TRUNCATE ( RAND()* 1000, 1 ),
				CEILING( RAND()* 3+1 ),
				CEILING( RAND()* 3+1 ),
				CEILING( RAND()* 3+1 ),
				CEILING( RAND()* 3 ),
				REPLACE ( UUID(), '-', '' )
			);

		SET i = i + 1;

	END WHILE;
END $$