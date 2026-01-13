-- TASK 6

-- For each shipment, display the latest status (Delivered, In Transit, or Returned) along
-- with the latest Delivery_Date.

select * from fedex_shipments;

SELECT shipment_id, Delivery_Status, Delivery_Date
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY shipment_id ORDER BY Delivery_Date DESC) AS rn
    FROM fedex_shipments
) t
WHERE rn = 1;


-- Find the most frequent delay reasons

select Delay_Reason,count(*) as count
from fedex_shipments
group by delay_reason
order by count desc;


-- Identify orders with exceptionally high delay (>120 hours) 
-- to investigate potential bottlenecks.


SELECT Warehouse_ID, Delay_Hours
FROM fedex_shipments
WHERE Delay_Hours > 120
ORDER BY Delay_Hours DESC;


SELECT 
    Warehouse_ID,
    MAX(Delay_Hours) AS max_delay_hours
FROM fedex_shipments
WHERE Delay_Hours > 120
GROUP BY Warehouse_ID
ORDER BY max_delay_hours DESC;




SELECT 
    Warehouse_ID,
    COUNT(*) AS extreme_delay_shipments
FROM fedex_shipments
WHERE Delay_Hours > 120
GROUP BY Warehouse_ID
ORDER BY extreme_delay_shipments DESC;


SELECT 
    Route_ID,
    COUNT(*) AS extreme_delay_shipments
FROM fedex_shipments
WHERE Delay_Hours > 120
GROUP BY Route_ID
ORDER BY extreme_delay_shipments DESC;
