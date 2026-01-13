-- TASK 4

-- Find the top 3 warehouses with the highest average delay in shipments dispatched.

select*from fedex_warehouses;
select *from fedex_shipments;

select warehouse_id,round(avg(delay_hours),2) as average
from fedex_shipments
group by warehouse_id
order by average desc
limit 3;


-- Calculate total shipments vs delayed shipments for each warehouse.

select warehouse_id,
count(shipment_id) as Total_Shipments,
sum(case when delay_hours > 0 then 1 else 0 end) as Delayed_Shipments,
round(sum(case when Delay_Hours > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
) as Delayed_Percentage
from fedex_shipments
group by warehouse_id
order by Delayed_Percentage desc;


-- Rank all warehouses based on on-time delivery percentage.

select warehouse_id,
       count(shipment_id) as Total_Shipments,
       sum(case when delay_hours = 0 then 1 else 0 end) as ON_Time_Shipments,
       round(sum(case when delay_hours = 0 then 1 else 0 end) *100 / count(*),2)
       as On_Time_Percent
from fedex_shipments
group by warehouse_id
order by On_Time_Percent desc;





