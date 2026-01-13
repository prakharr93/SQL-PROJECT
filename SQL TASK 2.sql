--- TASK2
-- Calculate delivery delay (in hours) for each shipment using Delivery_Date –Pickup_Date.

SELECT
    Shipment_ID,
    Pickup_Date,
    Delivery_Date,
    TIMESTAMPDIFF(MINUTE, Pickup_Date, Delivery_Date) / 60.0
        AS delivery_delay_hours
FROM fedex_shipments;

select *from fedex_shipments;

-- Top 10 delayed routes based on average delay hours.

select route_id,
       avg(timestampdiff(hour,pickup_date,delivery_date)) as
       avg_delay_hours
from fedex_shipments
group by Route_ID
order by avg_delay_hours desc
Limit 10;

-- Use SQL window functions to rank shipments by delay within each Warehouse_ID.

select shipment_id,warehouse_id,
	   timestampdiff(hour,pickup_date,delivery_date) as
       delay_hours,
       rank() over(partition by Warehouse_ID 
       order by Delay_Hours desc) as rn
from fedex_shipments;


select*from fedex_orders;
select*from fedex_shipments;


-- Identify the average delay per Delivery_Type (Express / Standard) to compare
-- service-level efficiency.

select 
      fo.Delivery_Type,
      round(avg(fs.Delay_Hours),2) as avg_delay_hours
from fedex_shipments fs join fedex_orders fo
on fs.order_id = fo.order_id
group by fo.Delivery_Type;



