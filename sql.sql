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

delete from fedex_shipments
where Order_ID in(
select Order_ID 
from(
select Order_ID,
row_number() over(partition by shipment_id order by pickup_date) as rn
from fedex_shipments)t
where t.rn > 1);



select*from fedex_shipments
where Delay_Hours is null;

select*from fedex_orders;
describe fedex_orders;
select*from fedex_shipments;
describe fedex_shipments;

SELECT
    Shipment_ID,
    DATE_FORMAT(Pickup_Date, '%Y-%m-%d %H:%i:%s') AS Pickup_Date,
    DATE_FORMAT(Delivery_Date, '%Y-%m-%d %H:%i:%s') AS Delivery_Date
FROM fedex_shipments;

SELECT
    Shipment_ID,
    Pickup_Date,
    Delivery_Date
FROM fedex_shipments
WHERE Delivery_Date < Pickup_Date;




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

