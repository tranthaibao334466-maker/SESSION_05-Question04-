SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items; 

-- Hiển thị danh sách (alias) 
SELECT 
c.name AS "Tên khách hàng",
o.order_date AS "Ngày đặt hàng",
o.total_price AS "Tổng tiền đơn hàng"
FROM customers AS c
JOIN orders AS o 
ON c.id = o.customer_id;

-- Tính các thông tin tổng hợp ( aggregate function )

SELECT 
SUM(total_price) AS "Tổng doanh thu",
AVG(total_price) AS "Trung bình giá trị đơn hàng",
MAX(total_price) AS "Giá trị đơn hàng lớn nhất",
COUNT(id) AS "Tổng số đơn hàng"
FROM orders; 


-- Tính tổng doanh thu theo từng thành phố 

SELECT 
c.city "Tên thành phố",
SUM(o.total_price) "Tổng doanh thu"
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id
GROUP BY c.city; 

-- Hiển thị các thành phố có tổng doanh thu lớn hơn 10000

SELECT 
c.city "Tên thành phố",
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id
GROUP BY c.city HAVING SUM(total_price) > 10000;


-- Hiển thị danh sách chi tiết 

SELECT 
i.product_id AS "Mã sản phẩm",
o.order_date AS "Ngày đạt hàng",
i.price AS "Giá sản phẩm",
i.quantity AS "Số lượng",
c.name AS "Tên khách hàng mua sản phẩm"
FROM order_items AS i
JOIN orders AS o ON i.order_id = o.id 
JOIN customers AS c ON o.customer_id = c.id 
ORDER BY i.product_id;

-- Tìm tên khách hàng có tổng doanh thu cao nhất 
SELECT 
c.name AS "Tên khách hàng"
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id 
GROUP BY c.id HAVING SUM(o.total_price) >= ALL(
	SELECT SUM(total_price) FROM orders 
	GROUP BY customer_id
) 



