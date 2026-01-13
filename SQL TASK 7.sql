-- TASK 7
-- Average Delivery Delay per Source_Country.


select * from fedex_routes;
select * from fedex_shipments;

select ro.source_city, round(avg(sh.delay_hours),2) as avg_delay_hours
from fedex_shipments sh 
join fedex_routes ro
on sh.route_id = ro.route_id
group by ro.source_city
order by avg_delay_hours Desc;


-- On-Time Delivery % = (Total On-Time Deliveries / Total Deliveries) * 100.

  SELECT 
    ROUND(
        SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS on_time_delivery_percentage
FROM fedex_shipments;

-- Average Delay (in hours) per Route_ID.

SELECT ROUTE_ID,ROUND(avg(DELAY_HOURS),2) AS AVERAGE_DELAY
FROM FEDEX_SHIPMENTS 
GROUP BY ROUTE_ID
ORDER BY AVERAGE_DELAY DESC;


-- Warehouse Utilization % = (Shipments_Handled / Capacity_per_day) * 100.

   SELECT * FROM fedex_warehouses;
   SELECT * FROM fedex_shipments;
   
   SELECT FW.WAREHOUSE_ID,
		  FW.CAPACITY_PER_DAY,
          ROUND(COUNT(FS.SHIPMENT_ID)*100/FW.CAPACITY_PER_DAY,2)
           AS WAREHOUSE_UTILIZATION_PERCENT
   FROM FEDEX_SHIPMENTS FS JOIN FEDEX_WAREHOUSES FW
   ON FS.WAREHOUSE_ID = FW.WAREHOUSE_ID
   GROUP BY FW.WAREHOUSE_ID,FW.CAPACITY_PER_DAY
   ORDER BY WAREHOUSE_UTILIZATION_PERCENT DESC;
   
   