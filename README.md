# Miku-ERD-Schema

## Description 
The purpose of this project is to create an Entity-Relationship Diagram (ERD) for a restaurant, in this case it was Miku a high-end sushi restaurant located in Vancouver. 
To create the ERD, 5 common use cases that Miku could face was made, and from those use cases 17 entities/tables were made for the ERD. 
The ERD was created in MySQL Workbench, and was then forward engineered to create the database schema. 

## Installation 
1. Download and first open mikuerd.mwb on MySQL Workbench
2. In database, go into forward engineer and select a connection server that you have open in stored connection
3. Go into your open server and select schema (you may need to refresh to find the schema name), then select the schema "mikubackup" created from the ERD
4. Open miku-data.sql and run to insert mock data into the schema
5. Open miku-query.sql and run to view potential managerial questions a resturant would face 
