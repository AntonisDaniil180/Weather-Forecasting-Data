DROP DATABASE IF EXISTS margera;
CREATE DATABASE margera;
USE margera;

CREATE TABLE all_data (
    ind INTEGER unique key,
    id bigint PRIMARY KEY,
    weather_state_name VARCHAR(255),
    weather_state_abbr VARCHAR(255),
    wind_direction_compass VARCHAR(255)NOT NULL,
    created_at Datetime,
    applicable_date Date,
    min_temp dec(5,3),
    max_temp dec(5,3),
    the_temp dec(5,3),
    wind_speed dec(7,2),
    wind_direction dec(6,3),
    air_pressure dec(7,2),
    humidity int,
    visibility varchar(255),
    predictability int,
    location varchar(255)); 
 
-- The below was used because I had issues passing my data from csv file i solved it by adding double '\' in the path
-- show variables like "secure_file_priv";
-- show variables like "local_infile";
-- set global local_infile = 1;
    
    LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\all_data.csv' INTO TABLE all_data
    COLUMNS TERMINATED BY ','
    IGNORE 1 LINES;
    SELECT * FROM all_data;
    
    -- writing a query to check solutions of:
    -- List the average the_temp of the last 3 forecasts for each location for every day-- 
    
    with cte as (select *, date(created_at) as x from all_data
    order by x)
    select *,dense_rank() over (partition by location,x order by created_at) from cte
    order by location;
    
    
   
    


   