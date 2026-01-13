# Logistics & Supply Chain Performance Analytics (SQL Project)
This project analyzes a logistics delivery dataset to evaluate operational efficiency, service reliability, and network performance across warehouses, routes, and delivery agents. The goal was to transform raw transactional data into meaningful KPIs and business insights that help identify bottlenecks, optimize routes, improve warehouse utilization and enhance delivery agent performance.

The entire project is built using SQL, focusing on data cleaning, validation, KPI engineering, and operations analytics.

🛠 Tech Stack

MySQL

SQL (CTEs, joins, window functions, CASE statements, aggregations)

Relational data modeling

Data quality & validation techniques

📂 Dataset Structure

fedex_shipments – shipment-level delivery data

fedex_orders – order information

fedex_routes – route and distance data

fedex_warehouses – warehouse details and daily capacity

fedex_delivery_agents – agent ratings and experience

🔧 Data Cleaning & Preparation

Converted date columns from TEXT to DATETIME format

Removed duplicate shipment and order records

Handled missing delay values using route-level averages

Validated referential integrity between fact and dimension tables

Identified extreme outliers and corrupted records

📊 KPIs & Metrics Built

On-Time Delivery %

Average transit time (hours)

Average delay by route, warehouse, and agent

Warehouse utilization % (daily capacity vs shipments handled)

Route efficiency (Distance / Avg Transit Time)

Extreme delay detection (>120 hours)

📈 Analysis Performed

Ranked warehouses by on-time performance and delay contribution

Ranked delivery agents (per route) by on-time delivery %

Identified routes with majority “In Transit” or “Returned” shipments

Flagged high-risk routes and hub pairs for optimization

Compared top vs bottom performing agents (rating & experience)

Built summarized KPI tables for dashboards

🚀 Business Insights

Identified warehouse overload days contributing to delivery delays

Detected structurally inefficient routes requiring redesign

Highlighted low-performing agents for training and mentoring

Proposed workload balancing based on utilization and delay patterns

Created early-warning indicators for SLA risk

📁 Example SQL Work Included

KPI summary tables

Route and warehouse performance dashboards

Agent ranking and segmentation queries

Bottleneck detection and exception reporting

Data quality and integrity validation scripts
