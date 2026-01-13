-- TASK 5

select * from fedex_delivery_agents;
select * from fedex_shipments;

-- Rank delivery agents (per route) by on-time delivery percentage.


with cte as(
SELECT
        Route_ID,
        Agent_ID,
        COUNT(*) AS total_shipments,
        SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) AS ontime_shipments,
        ROUND(SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) * 100.0 / Count(*), 2) AS ontime_percentage
    FROM fedex_shipments
    GROUP BY Route_ID, Agent_ID
    )
    
    SELECT ROUTE_ID,
           AGENT_ID,
           total_shipments,
           ontime_shipments,
           ontime_percentage,
           RANK() OVER( PARTITION BY Route_ID
                        ORDER BY ontime_percentage DESC) AS Rnk
	FROM CTE;
    
    
    -- Find agents whose on-time % is below 85%.
 
 
    select
         Agent_ID,
         COUNT(*) AS total_shipments,
	     ROUND(SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) * 100.0 / Count(*), 2)
         AS ontime_percentage
   from fedex_shipments
   group by AGENT_ID
   having ontime_percentage <85;
   
   
   -- Compare the average rating and experience (in years) of the top 5 vs bottom 5 agents
-- using subqueries.

select * from fedex_shipments;
select * from fedex_delivery_agents;


SELECT 
     Avg_Rating, 
    ROUND(AVG(da.Experience_Years), 2) AS avg_experience_years
FROM fedex_delivery_agents da
JOIN (
        SELECT Agent_ID
        FROM fedex_shipments
        GROUP BY Agent_ID
        ORDER BY SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) DESC
        LIMIT 5
     ) top_agents
ON da.Agent_ID = top_agents.Agent_ID
