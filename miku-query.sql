use mikubackup;

# Question 4
##### Use Case 1 | Customer Reservation
# view what seats are available for a party of 4
SELECT reservation_id, reservation_date, reservation_time, table_size FROM reservation 
WHERE status = 'available' AND table_size = 4 ORDER BY reservation_time DESC;

# reserving the table seat
UPDATE reservation SET status = 'reserved' WHERE reservation_id = 40;
# if no personal information info is entered for 5 min reservation is cancelled 
UPDATE reservation SET status = 'available' WHERE reservation_id = 40;

# customer enters in personal information
SELECT * FROM reservation;
INSERT customer (first_name, last_name, email, phone, party_size, special_note) 
VALUES ('Augustus', 'Gloop', 'godlike@myspace.ca','101-111,1010', 4, NULL);  

# customer confirms reservation
UPDATE reservation SET fk_customer_id = 15 WHERE reservation_id = 40;

#system updates which table will be reserved 
UPDATE tables SET status = 'reserved', customer_id = 15, reservation_id = 15 WHERE tables_id = 20;
SELECT * FROM tables;

#### Use Case 2 | Customer Orders 
# customer views menu items 
SELECT menu_item_id, item_name, item_price FROM menu_item;

# customer orders 1 ebi fritters, 1 miku roll, 1 miku signature selection, 
# 1 salmon oshi sushi 1 garden roll, 4  white chocholate cheesecake

#server starts order process and gets orders from customers 
INSERT orders (order_date, order_time, fk_customer_id, fk_server_id)
VALUES ('2023-03-27', '21:00', 15, 5);

INSERT menu_order (fk_order_id, fk_menu_item_id, mo_quantity)
VALUES (15,3, 1),
(15,25, 1),
(15,29, 1),
(15,31, 1),
(15,77, 1),
(15,65, 4);

#server confirms order
SELECT m.item_name, mo.mo_quantity as quantity_ordered FROM menu_item m
inner join menu_order mo on m.menu_item_id = mo.fk_menu_item_id
WHERE mo.fk_order_id = 15;

# chefs will see what ingredients will be used 
SELECT m.item_name, i.inventory_name, 
mi.used_ingredient_quantity FROM menu_item m
inner join menu_ingredient mi on m.menu_item_id = mi.fk_menu_item_id 
inner join inventory i on mi.fk_inventory_id = i.inventory_id
WHERE m.menu_item_id = 3 OR m.menu_item_id = 29 OR m.menu_item_id = 31 OR m.menu_item_id = 77
OR m.menu_item_id = 65 ORDER BY m.item_name; 

# subtracting the inventory quantity by the quantity used in the order 
UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 3 AND i.inventory_id = 12
  ) AS subquery
)
WHERE inventory_id = 12;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 3 AND i.inventory_id = 65
  ) AS subquery
)
WHERE inventory_id = 65;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 31 AND i.inventory_id = 57
  ) AS subquery
)
WHERE inventory_id = 57;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 29 AND i.inventory_id = 11
  ) AS subquery
)
WHERE inventory_id = 11;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 29 AND i.inventory_id = 40
  ) AS subquery
)
WHERE inventory_id = 40;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 77 AND i.inventory_id = 42
  ) AS subquery
)
WHERE inventory_id = 42;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - (4*used_ingredient_quantity))
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 65 AND i.inventory_id = 21
  ) AS subquery
)
WHERE inventory_id = 21;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - (4*used_ingredient_quantity))
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 65 AND i.inventory_id = 28
  ) AS subquery
)
WHERE inventory_id = 28;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - (4*used_ingredient_quantity))
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 65 AND i.inventory_id = 60
  ) AS subquery
)
WHERE inventory_id = 60;

#list the inventory after ingredients for this order is used
SELECT inventory_id, inventory_name, inventory_quantity FROM inventory
WHERE inventory_id = 12 OR inventory_id = 65 OR inventory_id = 57 OR inventory_id = 11 OR 
inventory_id = 40 OR inventory_id = 42 OR inventory_id = 21 OR inventory_id = 28 OR 
inventory_id = 60;

#find the chef_id who cooked the menu_items
SELECT mi.item_name, c.chef_id, e.first_name, e.last_name FROM menu_item mi 
INNER JOIN chef c on mi.fk_chef_id = c.chef_id
INNER JOIN  employee e on c.employee_id = e.employee_id 
WHERE mi.menu_item_id = 3 OR mi.menu_item_id = 25 OR mi.menu_item_id = 31 OR mi.menu_item_id = 77
OR mi.menu_item_id = 65 ORDER by c.chef_id;

# food is delivered to the customers 
# if an item had an issue with it e.g. a dog is on the ebi fritters 
# a new order for the same item will be filled and a refund will be processed in use case 3 
INSERT menu_order (fk_order_id, fk_menu_item_id, mo_quantity)
VALUES (15,3, 1);

#ingredients from inventory deducted to create the item
UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 3 AND i.inventory_id = 12
  ) AS subquery
)
WHERE inventory_id = 12;

UPDATE inventory
SET inventory_quantity = (
  SELECT (inventory_quantity - used_ingredient_quantity)
  FROM (
    SELECT i.inventory_quantity, mi.used_ingredient_quantity
    FROM inventory i
    INNER JOIN menu_ingredient mi ON i.inventory_id = mi.fk_inventory_id
    INNER JOIN menu_item m ON mi.fk_menu_item_id = m.menu_item_id
    WHERE m.menu_item_id = 3 AND i.inventory_id = 65
  ) AS subquery
)
WHERE inventory_id = 65;

# dish is sent to customer
# customer finishes dish
# customer gets bill for order and tips 18% and 5% GST
select ROUND(sum(mo_quantity*item_price)*1.18*1.05,2) as total_cost
from orders o inner join menu_order mo 
on o.order_id = mo.fk_order_id inner join menu_item mi
on mo.fk_menu_item_id = mi.menu_item_id
where o.order_id = 15;

#payement goes through 
INSERT INTO order_payment (payment_date, payment_time, amount, payment_method, payment_status, 
fk_order_id, fk_customer_id)
VALUES
('2023-03-27', '22:30:00', 213.11, 'Credit Card', 'Pending', 15, 15);

# view the total bill including tip
SELECT sum(amount) FROM order_payment 
WHERE fk_customer_id = 15;

# refund for issue with dish
# record the dish that was refunded 
INSERT INTO refund (refund_id, order_id, menu_item_id, refund_reason) 
VALUES (3, 15, 3, 'dog on plate');

# new amount without ebi fritters 
select ROUND(sum(mo_quantity*item_price)*1.18*1.05,2) as total_cost
from orders o inner join menu_order mo 
on o.order_id = mo.fk_order_id inner join menu_item mi
on mo.fk_menu_item_id = mi.menu_item_id
where o.order_id = 15 and mi.menu_item_id != 3;

update order_payment set amount = 188.33 where fk_order_id = 15;

## If customer cannot pay for meal and causes a scene 
update order_payment set amount = 0 where fk_order_id = 15;

# put the customer on a banned list 
insert into banned (banned_id, customer_id, reason, banned_date, manager_id)
values (2, 15, 'caused a scene', ' 2023-03-27', 3);

# customer unable to pay and will return another time to pay 
update order_payment set amount = 0, payment_method = NULL, payment_status = 'pending'
where fk_customer_id = 15;

# add note to customer 
update customer set special_note = 'Will return payment by April 10' 
where customer_id = 15;

#### Use Case 3 | Order Inventory 
# Find stock that needs to be ordered 
SELECT inventory_name, inventory_quantity, inventory_status FROM inventory
WHERE inventory_status = "NEED STOCK";

# Find what suppliers supply the stock needed and the price of each unit 
SELECT i.inventory_id, i.inventory_name, i.unit_type, i.inventory_unit_cost, 
s.supplier_id, s.supplier_name FROM inventory i 
inner join supplier_selection ss on i.inventory_id = ss.fk_inventory_id
inner join supplier s on ss.fk_supplier_id = s.supplier_id
WHERE i.inventory_status = "NEED STOCK";

# find how much it'll cost to order 20 of each item that is in need of stock
SELECT i.inventory_id, ROUND(sum(i.inventory_unit_cost*20),2) as order_cost 
FROM inventory i
inner join supplier_selection ss on i.inventory_id = ss.fk_inventory_id
WHERE i.inventory_id = 33 OR i.inventory_id = 36 OR i.inventory_id = 38 OR i.inventory_id = 17
GROUP BY i.inventory_id;

#Purchase from supplier 
INSERT INTO supplier_payment (payment_date, payment_time, amount, payment_method, 
payment_status, supplier_id, inventory_id, quantity_ordered)
VALUES 
    ('2023-03-28', '15:30:00', 1999.80, 'Credit Card', 'Paid', 1, 33,20),
	('2023-03-28', '15:30:00', 1019.80, 'Credit Card', 'Paid', 3, 36,20),
    ('2023-03-28', '15:30:00', 2599.80, 'Credit Card', 'Paid', 6, 38,20),
    ('2023-03-28', '15:30:00', 459.80, 'Credit Card', 'Paid', 8, 17,20);

# shipment arrives, update the inventory stock 
select*from inventory;
UPDATE inventory
SET inventory_quantity = inventory_quantity + 20, inventory_status = 'healthy stock'
WHERE inventory_id = 17;

UPDATE inventory
SET inventory_quantity = inventory_quantity + 20, inventory_status = 'healthy stock'
WHERE inventory_id = 33;

UPDATE inventory
SET inventory_quantity = inventory_quantity + 20, inventory_status = 'healthy stock'
WHERE inventory_id = 36;

UPDATE inventory
SET inventory_quantity = inventory_quantity + 20, inventory_status = 'healthy stock'
WHERE inventory_id = 38;

# view the new stock quantity 
SELECT inventory_id, inventory_name, inventory_quantity, inventory_status FROM inventory
WHERE inventory_id = 17 OR inventory_id = 33 OR inventory_id = 36 OR inventory_id = 38;

# If ingredients shipped are incorrect, say ikura was in fact not ikura but peanuts
UPDATE inventory
SET inventory_quantity = inventory_quantity - 20, inventory_status = 'NEED STOCK'
WHERE inventory_id = 36;

# restaurant will file a complaint 
INSERT INTO supplier_difficulty (supplier_difficulty_id, inventory_id, supplier_id, reason)
VALUES (2,36,3,'Wrong ingredients delivered');

# supplier will correct the issue by shipping the correct order free of charge 
UPDATE supplier_payment set amount = 0, payment_method = NULL, payment_status = 'refund',
quantity_ordered = 20 
WHERE supplier_payment_id = 72;
SELECT * FROM supplier_payment;

#corrected shippment arrives, and inventory is updated 
UPDATE inventory
SET inventory_quantity = inventory_quantity + 20, inventory_status = 'healthy stock'
WHERE inventory_id = 36;

# view the new stock quantity 
SELECT inventory_id, inventory_name, inventory_quantity, inventory_status FROM inventory
WHERE inventory_id = 36;

######## Use Case 4 | Manager assigns shifts 
#Manager searches which shifts are empty 
SELECT s.schedule_id, es.schedule_status,s.date, s.start_time, s.end_time FROM schedule s 
inner join employee_schedule es on s.schedule_id = es.fk_schedule_id
WHERE es.fk_employee_id IS NULL;

#See which employees are available for work 
SELECT e.employee_id, e.first_name, e.last_name, ea.availability FROM employee e
inner join employee_availability ea on e.employee_id = ea.employee_id 
WHERE availability = 'available';

#Manager assigns shift to employee #11 and #12 the 29th and 31th of march 
update employee_schedule set fk_employee_id = 11, schedule_status = 'Filled' WHERE fk_schedule_id = 6;
update employee_schedule set fk_employee_id = 12, schedule_status = 'Filled'  WHERE fk_schedule_id = 9;

#Manager updates availability status of 11, and 12 to assigned
update employee_availability set availability = 'assigned' WHERE employee_id = 11 or employee_id = 12;

########Use Case 5 | Manager updates the menu 
# add bull's testicles to the menu 
INSERT INTO menu_item (item_name, description, item_price, category, is_available, vegetarian, gluten_free, fk_chef_id)
VALUES 
  ('Bullshit', 'Spanish bull testicles cut off after being beat to death by a watermelon, 
  aged finely in giraffe urine for 1 year', 69420.00, 'Secret Menu', 'Yes', 'No', 'No', 5); 
  #im losingggggg my minddddddddddddd 

#need to figure out the ingredients for this dish 
INSERT INTO inventory (inventory_name, unit_type, inventory_quantity, inventory_status, 
inventory_unit_cost, date_purchased)
VALUES 
('Bull Testicles', 'testicle', 0, 'NEED STOCK', 6969.00, NULL),
('Blue Whale Sperm', 'tube', 0, 'NEED STOCK', 10000.00, NULL),
('Mountain Dew', 'can', 0, 'NEED STOCK', 0.50, NULL);

INSERT INTO menu_ingredient (fk_menu_item_id, fk_inventory_id, used_ingredient_quantity)
VALUES 
(103, 71, 2.00),
(103, 72, 5.00),
(103, 73, 50.00);
SELECT * FROM menu_ingredient;

#Find a new supplier to supply these new ingredients 
INSERT INTO supplier (supplier_name, email, phone, contact_first_name, contact_last_name)
VALUES 
('Send Help Please', 'imlosingmymind@needsleep.com', 'zzz-zzzz', 'Andrew', 'Tate');

# manager will buy the ingredients at a later date 

#########################################################################

# Question 5

#1 What the average salary of a chef 
SELECT avg(p.salary) FROM payroll p
inner join employee e on p.payroll_id = e.payroll_id 
inner join chef c on e.employee_id = c.employee_id;

#2 Which chef is able to cook the most menu items 
SELECT e.first_name, e. last_name, c.job_title, count(m.item_name) as can_cook FROM menu_item m 
inner join chef c on m.fk_chef_id = c.chef_id 
inner join employee e on c.employee_id = e.employee_id
GROUP BY e.first_name ORDER BY can_cook DESC LIMIT 1;

#3 which supplier supplies the most ingredients 
SELECT s.supplier_name, count(i.inventory_name) supply_count FROM supplier s 
inner join supplier_selection ss on s.supplier_id = ss.fk_supplier_id 
inner join inventory i on ss.fk_inventory_id = i.inventory_id
GROUP BY s.supplier_name ORDER BY supply_count DESC LIMIT 2;

#4 Show a vegetarian what options are available on the menu
SELECT vegetarian, item_name FROM menu_item m
WHERE vegetarian = "yes"; 

#5 What servers are available to work 
SELECT e.first_name, e.last_name FROM server s
inner join employee e on s.employee_id = e.employee_id
inner JOIN employee_availability ea on e.employee_id = ea.employee_id
WHERE ea.availability = 'available';

#6 What is the the revenue from march 27's service 
SELECT sum(amount) FROM order_payment 
WHERE payment_date = '2023-03-27';

#7 which ingredient is used most for the menu_items 
SELECT i.inventory_name, COUNT(*) AS count
FROM inventory i JOIN menu_ingredient mii
ON i.inventory_id = mii.fk_inventory_id
JOIN menu_item mi
ON mi.menu_item_id = mii.fk_menu_item_id
WHERE mi.vegetarian = 0
GROUP BY i.inventory_id
ORDER BY COUNT(*) DESC
LIMIT 1;

#8 how much did was spent for ingredients from Baker Brothers Co. 
SELECT s.supplier_name, sum(sp.amount) FROM supplier s
inner join supplier_payment sp on s.supplier_id = sp.supplier_id 
WHERE s.supplier_name = 'Baker Brothers Co.'; 

#9 What is the average price for gluten free and vegetarian menu items 
SELECT AVG(mi.item_price) AS average
FROM menu_item mi
WHERE mi.vegetarian = 'yes' AND mi.gluten_free = 'yes';

#10 What menu items were ordered today 
SELECT m.item_name FROM menu_item m
inner join menu_order mo on m.menu_item_id = mo.fk_menu_item_id
inner join orders o on mo.fk_order_id = o.order_id
where order_date = '2023-03-27';

SELECT * FROM supplier_selection;
