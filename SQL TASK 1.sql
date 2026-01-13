select*from fedex_orders;
select*from fedex_shipments;

select Order_ID,count(*) as cnt
from fedex_shipments
group by Order_ID
having count(*) > 1;

select Shipment_ID,count(*) as cnt
from fedex_shipments
group by shipment_id
having count(*) > 1;

SET SQL_SAFE_UPDATES = 0;

delete from fedex_shipments
where Shipment_ID in(
select Shipment_ID 
from(
select shipment_id,
row_number() over(partition by shipment_id order by pickup_date) as rn
from fedex_shipments)t
where t.rn > 1);

DELETE FROM fedex_shipments
WHERE Shipment_ID IN (
    SELECT Shipment_ID
    FROM (
        SELECT Shipment_ID,
               ROW_NUMBER() OVER (PARTITION BY Shipment_ID ORDER BY Pickup_Date) AS rn
        FROM fedex_shipments
    ) t
    WHERE t.rn > 1
);


-- Replace NULL Delay_Hours With Average Delay for Its Route_ID

select*from fedex_shipments
where Delay_Hours is null;

select*from fedex_orders;
describe fedex_orders;
select*from fedex_shipments;
describe fedex_shipments;


-- Convert all date columns to datetime
UPDATE fedex_shipments
SET 
    Pickup_Date   = STR_TO_DATE(Pickup_Date, '%Y-%m-%d %H:%i:%s'),
    Delivery_Date = STR_TO_DATE(Delivery_Date, '%Y-%m-%d %H:%i:%s');
    
ALTER TABLE fedex_shipments
MODIFY Pickup_Date DATETIME,
MODIFY Delivery_Date DATETIME;

select *from fedex_orders;

ALTER TABLE fedex_orders
MODIFY Order_Date DATETIME;

describe fedex_orders;


-- Ensure that no Delivery_Date occurs before Pickup_Date

SELECT
    Shipment_ID,
    Pickup_Date,
    Delivery_Date
FROM fedex_shipments
WHERE Delivery_Date < Pickup_Date;


-- Validate referential integrity between Orders, Routes, Warehouses, and Shipments.

SELECT
    s.Shipment_ID,
    s.Order_ID
FROM fedex_shipments s
LEFT JOIN fedex_orders o
       ON s.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;



SELECT
    s.Shipment_ID,
    s.Route_ID
FROM fedex_shipments s
LEFT JOIN fedex_routes r
       ON s.Route_ID = r.Route_ID
WHERE r.Route_ID IS NULL;


SELECT
    s.Shipment_ID,
    s.Warehouse_ID
FROM fedex_shipments s
LEFT JOIN fedex_warehouses w
       ON s.Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;

