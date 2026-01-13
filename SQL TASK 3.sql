-- TASK3

-- Average transit time (in hours) across all shipments.

SELECT
    AVG(TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date)) AS avg_transit_hours
FROM fedex_shipments;


-- Average delay (in hours) per route.

select 
      route_id,
      avg(delay_hours) as avg_delay_hours
from fedex_shipments
group by Route_ID
order by avg_delay_hours desc;

-- Find routes with >20% of shipments delayed beyond expected transit time.

select route_id,
       sum(case when delay_hours > 0 then 1 else 0 end) * 100/count(*) as delayed_percent
from fedex_shipments
group by route_id
having sum(case when delay_hours > 0 then 1 else 0 end) * 100/count(*) >0.20;


SELECT 
    Route_ID,
    TIMESTAMPDIFF(MINUTE, Pickup_Date, Delivery_Date) / 60.0 AS transit_hours,
    Delay_Hours
FROM fedex_shipments;

SELECT 
    Route_ID,
    COUNT(*) AS total_shipments,
    AVG(TIMESTAMPDIFF(MINUTE, Pickup_Date, Delivery_Date) / 60.0) AS avg_transit_hours,
    AVG(Delay_Hours) AS avg_delay_hours,
    SUM(CASE WHEN Delay_Hours > 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS delay_ratio
FROM fedex_shipments
GROUP BY Route_ID;
