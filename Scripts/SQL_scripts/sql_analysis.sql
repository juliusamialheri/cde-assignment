-- Question. Orders with high total quantity
-- Find all orders where the total quantity (sum of standard_qty, gloss_qty, and poster_qty) is greater than 5000
SELECT id,  
       standard_qty, 
       gloss_qty, 
       poster_qty, 
       (standard_qty + gloss_qty + poster_qty) AS total_qty
FROM orders
WHERE (standard_qty + gloss_qty + poster_qty) > 5000;

-- Question. Accounts in specific regions with high order quantities

SELECT a.id AS account_id,
       a.name AS account_name,
       (o.standard_qty + o.gloss_qty + o.poster_qty) AS total_qty
FROM accounts a
JOIN orders o ON a.id = o.account_id
JOIN region r ON a.region_id = r.id
WHERE (r.name = 'West' OR r.name = 'East')
  AND (o.standard_qty + o.gloss_qty + o.poster_qty) > 4000;

-- Question. Average quantities for orders with high poster_qty

SELECT AVG(standard_qty) AS avg_standard_qty,
       AVG(gloss_qty) AS avg_gloss_qty
FROM orders
WHERE poster_qty > 3000;

