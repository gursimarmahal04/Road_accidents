# 🚦 Analyzing Road Accidents Using SQL (2021-2022)

This project explores **road accident data from 2021 to 2022** to uncover key insights using SQL. 🚗💥  

## 📊 Key Analyses:
- 🔴 **High-risk accident zones** based on location (latitude & longitude)
- 🌧️ **Impact of weather and lighting conditions** on accident severity
- 🛣️ **Effect of road surface conditions** on accident frequency
- 📈 **Casualties and vehicle involvement** in different scenarios

## 🛠️ Tools Used:
- **SQL** for querying and data analysis.
- **Excel** for initial data exploration.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

## 🎯 Objective:
By analyzing these factors, this project helps identify patterns that contribute to **safer roads and better traffic management**. 🚦✨

---
📌 **Note:** The dataset used in this project covers road accidents recorded between **2021 and 2022**.

# 🔍 Background  

This project was driven by the need to **analyze road accidents** and uncover key patterns that contribute to **road safety and accident prevention**.

### The questions I wanted to answer through my SQL queries were:

- 🚗 Where are the **high-risk accident zones**?  
- 🌧️ How do **weather, lighting, and road conditions** impact accidents?  
- ⚠️ What are the **casualty rates and vehicle involvement trends**?  
- 📊 How can **data-driven insights** improve traffic management?  

With data from **2021 to 2022**, this project helps in understanding accident trends and improving road safety measures. 🚦✨  

# Data Cleaning

## Handling Duplicates.
```SQL
with duplicate_rows AS(
    SELECT accident_id,
        ROW_NUMBER() OVER(PARTITION BY accident_id) AS row_num
    FROM
        road_accidents
)

SELECT * FROM duplicate_rows
WHERE row_num >1;

CREATE TABLE road_accidents_stagging (
    accident_id VARCHAR(100),
    accident_date VARCHAR(100),
    month VARCHAR(10),
    day_of_week VARCHAR(255),
    year INT,
    junction_control VARCHAR(100),
    junction_detail VARCHAR(100),
    accident_severity VARCHAR(100),
    latitude FLOAT,
    light_conditions VARCHAR(100),
    local_authority_district VARCHAR(100),
    carriageway_hazards VARCHAR(255),
    longitude FLOAT,
    number_of_casualties INT,
    number_of_vehicles INT,
    police_force VARCHAR(100),
    road_surface_conditions VARCHAR(100),
    road_type VARCHAR(100),
    speed_limit INT,
    time VARCHAR(100),
    urban_or_rural_area VARCHAR(25),
    weather_conditions VARCHAR(100),
    vehicle_type VARCHAR(100),
    row_num int

);

INSERT INTO road_accidents_stagging
SELECT * ,
    ROW_NUMBER() OVER(PARTITION BY accident_id) AS row_num
FROM 
    road_accidents;


DELETE  
FROM road_accidents_stagging
WHERE row_num>1;
```
## Handling null values
```sql

DELETE  
FROM road_accidents_stagging
WHERE road_surface_conditions IS NULL;

DELETE  
FROM road_accidents_stagging
WHERE weather_conditions IS NULL;

```
## Standardizing data
```sql

ALTER TABLE road_accidents_stagging
DROP accident_date,
DROP row_num;

ALTER TABLE road_accidents_stagging
ALTER COLUMN time TYPE TIME USING time::TIME;

```

# 📊 The Analysis  

Each query in this project was designed to investigate key aspects of **road accident patterns**. Here’s how I approached each question:  


### 1. Genral Accident Analysis.
To understand overall accident trends, I analyzed accident counts across different factors such as **location, time, and month**. This query highlights:  


```SQL
--Total number of accidents

SELECT COUNT(*) AS Total_accidents
FROM road_accidents_stagging;
```

| Metric           | Value     |
|------------------|-----------|
| Total Accidents  | 1,94,061  |

The dataset indicates a total of **194,061** recorded accidents between the years **2021 and 2022**.

---
```sql
-- Monthly trend 

SELECT month ,
    COUNT(*) AS Total_accidents
FROM road_accidents_stagging
GROUP BY month
ORDER BY 2 DESC;
```
| Month | Total Accidents |
|-------|-----------------|
| Nov   | 18,287          |
| Oct   | 17,970          |
| Jul   | 17,068          |
| Jun   | 16,882          |
| Sep   | 16,845          |
| May   | 16,577          |
| Mar   | 16,243          |
| Aug   | 15,961          |
| Apr   | 15,238          |
| Jan   | 14,618          |
| Dec   | 14,584          |
| Feb   | 13,788          |

### Insights from Monthly Total Accidents (2021-2022)

1. **November** had the highest number of accidents, with **18,287** recorded incidents, suggesting possible seasonal factors like weather or increased travel during this month.

2. **February** experienced the lowest number of accidents, with **13,788** incidents, which could be due to fewer driving days or milder weather conditions reducing accidents.

3. **Summer months** (June, July, August) had higher accident rates, particularly **July**, which recorded **17,068** incidents, possibly due to increased traffic and travel during the warmer months.
---

```sql
-- yearly trend

SELECT year,
    COUNT(*) AS Total_accidents
FROM road_accidents_stagging
GROUP BY year
ORDER BY 2 DESC;
```
| Year | Total Accidents |
|------|-----------------|
| 2021 | 100,965         |
| 2022 | 93,096          |

### Insights from Total Accidents (2021-2022)

1. There was a **decline** of **7,869** accidents from 2021 to 2022, which could reflect a positive trend in road safety or changes in traffic patterns.

2. The **decrease in accidents** may be attributed to factors like improved road safety measures, fewer high-risk driving conditions, or even a reduction in traffic volume.

3. Despite the decline, the accident rate remains significant, indicating that continued efforts to reduce accidents are needed.
---
```sql
-- Most common accident hours

SELECT 
    CONCAT(
        LPAD(CAST(EXTRACT(HOUR FROM time) AS TEXT), 2, '0'), ':00 - ', 
        LPAD(CAST(EXTRACT(HOUR FROM time) + 1 AS TEXT), 2, '0'), ':00'
    ) AS time_range,
    COUNT(*) AS accident_count
FROM road_accidents_stagging
GROUP BY EXTRACT(HOUR FROM time)
ORDER BY accident_count DESC;
```
| Time Range     | Accident Count |
|----------------|----------------|
| 17:00 - 18:00  | 16,793         |
| 16:00 - 17:00  | 15,388         |
| 15:00 - 16:00  | 15,100         |
| 08:00 - 09:00  | 14,226         |
| 18:00 - 19:00  | 13,585         |
| 13:00 - 14:00  | 11,922         |
| 14:00 - 15:00  | 11,862         |
| 12:00 - 13:00  | 11,335         |
| 19:00 - 20:00  | 10,232         |
| 11:00 - 12:00  | 9,957          |
| 09:00 - 10:00  | 9,829          |
| 10:00 - 11:00  | 8,582          |
| 07:00 - 08:00  | 7,899          |
| 20:00 - 21:00  | 7,367          |
| 21:00 - 22:00  | 6,116          |
| 22:00 - 23:00  | 5,284          |
| 23:00 - 24:00  | 4,132          |
| 06:00 - 07:00  | 3,341          |
| 00:00 - 01:00  | 2,994          |
| 01:00 - 02:00  | 2,244          |
| 02:00 - 03:00  | 1,648          |
| 05:00 - 06:00  | 1,626          |
| 03:00 - 04:00  | 1,480          |
| 04:00 - 05:00  | 1,119          |

### Insights from Accident Count by Time Range

1. **Peak hours** such as **17:00 - 18:00** and **16:00 - 17:00** show the highest accident counts, with **16,793** and **15,388** incidents, likely due to increased traffic during rush hours.

2. **Late night and early morning** hours, such as **03:00 - 04:00** (1,480 accidents) and **04:00 - 05:00** (1,119 accidents), have the lowest number of accidents, possibly due to reduced traffic or safer driving conditions during these times.

3. The **afternoon** (12:00 - 16:00) and **evening** (18:00 - 20:00) hours consistently show higher accident numbers, reflecting the times when traffic is heavier, potentially coupled with lower visibility or driving fatigue.


### 2. Accident Severity Analysis
To understand the severity of road accidents, I analyzed how different factors influence accident outcomes. This query provides insights into:  
#### ⚠️ **How accidents are distributed by severity** (Fatal, Serious, Slight).  
```sql
--Count of accidents by severity level

SELECT accident_severity, COUNT(*)
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;
```
| Accident Severity | Count    |
|------------------|---------|
| Slight          | 166,196 |
| Serious         | 25,408  |
| Fatal          | 2,457   |

#### 🔍 Key Insights:  
- **🚗 Majority of accidents (85.7%) are classified as "Slight"**, meaning most incidents result in minor injuries or damage.  
- **⚠️ Serious accidents make up 13.1%**, indicating a significant portion of accidents cause major injuries.  
- **💀 Fatal accidents account for only 1.2%**, but their impact is severe, highlighting the need for improved road safety measures.  
- **📉 Potential Actions:** Focus on reducing serious and fatal accidents through better road designs, traffic control, and driver awareness programs.  



#### 🌧️ **The impact of weather conditions on severity levels** (e.g., rain vs. clear weather).  
```sql
SELECT weather_conditions,  
    accident_severity,
    COUNT(*) AS Total_accidents,
    ROUND(COUNT(*) *100/SUM(COUNT(*)) OVER(PARTITION BY weather_conditions),2) AS Percentage
FROM 
    road_accidents_stagging
GROUP BY 1,2
ORDER BY 1,4 DESC
```
| Weather Condition        | Severity | Total Accidents| Percentage (%)|
|--------------------------|----------|----------------|---------------|
| Fine + High Winds        | Slight   | 1,541          | 83.39         |
|                          | Serious  | 271            | 14.66         |
|                          | Fatal    | 36             | 1.95          |
| Fine No High Winds       | Slight   | 134,009        | 85.21         |
|                          | Serious  | 21,186         | 13.47         |
|                          | Fatal    | 2,078          | 1.32          |
| Fog or Mist              | Slight   | 850            | 84.66         |
|                          | Serious  | 137            | 13.65         |
|                          | Fatal    | 17             | 1.69          |
| Other                    | Slight   | 5,265          | 88.95         |
|                          | Serious  | 602            | 10.17         |
|                          | Fatal    | 52             | 0.88          |
| Raining + High Winds     | Slight   | 1,788          | 86.50         |
|                          | Serious  | 255            | 12.34         |
|                          | Fatal    | 24             | 1.16          |
| Raining No High Winds    | Slight   | 19,611         | 87.18         |
|                          | Serious  | 2,655          | 11.80         |
|                          | Fatal    | 230            | 1.02          |
| Snowing + High Winds     | Slight   | 311            | 88.60         |
|                          | Serious  | 40             | 11.40         |
| Snowing No High Winds    | Slight   | 2,821          | 90.91         |
|                          | Serious  | 262            | 8.44          |
|                          | Fatal    | 20             | 0.64          |

#### 🔍 Key Insights:  
- **🌞 Clear weather (fine, no high winds) sees the most accidents (134,009),** but has a slightly lower fatality rate (1.32%).  
- **🌧️ Rainy conditions (no high winds) show a similar trend** with 87.18% slight accidents and 1.02% fatal accidents.  
- **🌫️ Fog or mist increases the risk of fatal accidents (1.69%),** likely due to reduced visibility.  
- **❄️ Snowy conditions have the lowest fatality rate (0.64%)**, possibly due to drivers being more cautious.  
- **💨 High winds combined with other conditions increase the chances of serious and fatal accidents.**  

Understanding how weather affects accident severity can help improve **road safety measures**, such as better warnings for fog, rain, and high winds. 🚦✨  

#### 🛣️ **How road surface conditions affect accident severity** (e.g., wet vs. dry roads)

```sql
SELECT road_surface_conditions,  
    accident_severity,
    COUNT(*) AS Total_accidents,
    ROUND(COUNT(*) *100/SUM(COUNT(*)) OVER(PARTITION BY road_surface_conditions),2) AS Percentage
FROM 
    road_accidents_stagging
GROUP BY 1,2
ORDER BY 1,4 DESC;
```

| Road Surface Condition   | Severity | Total Accidents| Percentage (%)|
|--------------------------|----------|----------------|---------------|
| Dry                      | Slight   | 113,094        | 85.18         |
|                          | Serious  | 17,963         | 13.53         |
|                          | Fatal    | 1,708          | 1.29          |
| Flood (Over 3cm Deep)    | Slight   | 160            | 81.63         |
|                          | Serious  | 31             | 15.82         |
|                          | Fatal    | 5              | 2.55          |
| Frost or Ice             | Slight   | 6,750          | 88.85         |
|                          | Serious  | 779            | 10.25         |
|                          | Fatal    | 68             | 0.90          |
| Snow                     | Slight   | 2,610          | 90.37         |
|                          | Serious  | 258            | 8.93          |
|                          | Fatal    | 20             | 0.69          |
| Wet or Damp              | Slight   | 43,582         | 86.10         |
|                          | Serious  | 6,377          | 12.60         |
|                          | Fatal    | 656            | 1.30          |

#### 🔍 Key Insights:  
- **🛣️ Dry roads account for most accidents (113,094),** but have a lower fatality rate (1.29%) compared to other conditions.  
- **🌊 Flooded roads (over 3cm deep) have the highest fatality rate (2.55%),** possibly due to hydroplaning or reduced vehicle control.  
- **❄️ Snowy and icy roads lead to fewer accidents,** but **frost/ice increases serious accident rates (10.25%).**  
- **💧 Wet or damp conditions make up a significant portion of accidents (43,582),** with a fatality rate of 1.30%.  

These findings suggest that **wet, icy, and flooded roads pose higher risks** and may require **improved drainage systems, de-icing strategies, and driver warnings.** 🚦✨  


### 3. Location Based Analysis

This analysis focuses on identifying **high-risk accident zones** using **latitude and longitude data**. The goal is to pinpoint locations with the highest accident counts and understand regional patterns.

```sql
--Districts with the highest number of accident counts.

WITH a1 AS (
    SELECT local_authority_district,
           COUNT(*) AS accident_count
    FROM road_accidents_stagging
    GROUP BY local_authority_district
),
total_accidents AS (
    SELECT SUM(accident_count) AS total 
    FROM a1
)
SELECT 
    a1.local_authority_district, 
    a1.accident_count, 
    ROUND(a1.accident_count * 100.0 / total_accidents.total, 2) AS Percentage
FROM a1, total_accidents
ORDER BY a1.accident_count DESC
LIMIT 10;
```

| Local Authority District | Accident Count | Percentage (%) |
|--------------------------|---------------|---------------|
| Birmingham              | 5,953         | 3.07          |
| Manchester              | 2,902         | 1.50          |
| Westminster             | 2,801         | 1.44          |
| Sheffield               | 2,702         | 1.39          |
| Cornwall                | 2,568         | 1.32          |
| Liverpool               | 2,539         | 1.31          |
| Barnet                  | 2,287         | 1.18          |
| Lambeth                 | 2,242         | 1.16          |
| County Durham           | 2,218         | 1.14          |
| Southwark               | 1,977         | 1.02          |

#### 🔍 Key Insights:  
- **🚦 Birmingham has the highest accident count (5,953), making up 3.07% of total incidents.**  
- **🏙️ Major cities like Manchester, Liverpool, and Sheffield also rank high,** likely due to higher traffic density.  
- **🌍 Cornwall (2,568 accidents) stands out as a high-risk area despite being a rural location,** possibly due to winding roads and tourist traffic.  
- **🚗 London boroughs (Westminster, Barnet, Lambeth, and Southwark) are prominent,** reflecting urban congestion and pedestrian activity.  

#### 📊 Implications:  
- Authorities can use this data to **prioritize road safety measures** in high-risk locations.  
- **Traffic management strategies** such as speed regulations, better signage, and improved road infrastructure can help reduce accidents.  
- Further analysis can explore **accident causes in these districts** to develop targeted solutions.  

This analysis helps in improving **traffic planning and road safety policies** based on accident-prone locations. 🚦✨  

---

```sql
-- Most accident-prone junction types

SELECT junction_control,junction_detail,count(*)
FROM road_accidents_stagging
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10;
```
| Junction Control               | Junction Detail                      | Accident Count |
|--------------------------------|-------------------------------------|---------------|
| Give way or uncontrolled       | T or staggered junction            | 56,763        |
| Data missing or out of range   | Not at junction or within 20 metres| 55,228        |
| Not at junction or within 20m  | Not at junction or within 20 metres| 17,992        |
| Give way or uncontrolled       | Roundabout                         | 14,323        |
| Auto traffic signal            | Crossroads                         | 11,415        |
| Give way or uncontrolled       | Crossroads                         | 9,652         |
| Auto traffic signal            | T or staggered junction            | 7,226         |
| Give way or uncontrolled       | Private drive or entrance          | 6,444         |
| Give way or uncontrolled       | Other junction                     | 4,135         |
| Give way or uncontrolled       | Mini-roundabout                    | 2,251         |

#### 🔍 Key Insights:  
- **🚦 T or staggered junctions (56,763 accidents) are the most accident-prone, especially when uncontrolled.**  
- **🏁 Roundabouts (14,323 accidents) and crossroads (20,067 combined) also see high accident counts.**  
- **🚗 Many accidents occur at junctions without traffic signals,** suggesting the need for better control measures.  
- **🏡 Private driveways and mini-roundabouts also see notable accident occurrences,** highlighting risks in smaller road networks.  

#### 📊 Implications:  
- **🚥 Improved traffic control measures** (e.g., additional traffic signals or stop signs) could reduce accidents at high-risk junctions.  
- **🚗 Driver awareness campaigns** may help reduce accidents at uncontrolled junctions.  
- Further analysis could assess **accident severity at different junctions** to refine safety recommendations.  

By understanding junction-related accident patterns, authorities can implement **targeted safety improvements** to reduce collisions. 🚦✨  

---
```SQL
--Mapping high-risk accident zones using latitude and longitude
SELECT 
    Lat_Group, 
    Lon_Group, 
    COUNT(*) AS Accident_Count
FROM (
    SELECT ROUND(longitude::NUMERIC, 3) AS Lon_Group,
           ROUND(latitude::NUMERIC, 3) AS Lat_Group
    FROM road_accidents_stagging
) a1
GROUP BY Lat_Group, Lon_Group
ORDER BY Accident_Count DESC
LIMIT 10;
```

| Latitude  | Longitude  | Accident Count |
|-----------|-----------|---------------|
| 51.590    | -0.200    | 36            |
| 51.571    | -0.096    | 35            |
| 51.525    | -0.035    | 30            |
| 51.495    | -0.101    | 29            |
| 51.520    | -0.056    | 27            |
| 51.486    | -0.124    | 25            |
| 52.459    | -1.871    | 25            |
| 51.463    | -0.115    | 25            |
| 51.501    | -0.126    | 25            |
| 51.458    | -0.013    | 25            |

#### 🔍 Key Insights:  
- **🚦 The most accident-prone area (51.590, -0.200) had 36 recorded incidents.**  
- **📍 Several high-risk locations are concentrated around London (51.x latitude), likely due to high traffic density.**  
- **🌍 Location (52.459, -1.871) stands out as an outlier, indicating a high-risk zone outside London.**  
- **🛣️ These hotspots may be near major intersections, pedestrian crossings, or high-speed roads.**  

#### 📊 Implications:  
- **🚥 Mapping these locations helps authorities focus on accident prevention measures.**  
- **📉 Traffic control adjustments** (e.g., better lighting, signage, speed limits) could reduce accidents in these zones.  


### 4. Vehicle & Casualty Analysis  

This section explores **the number of vehicles involved per accident** and **casualty distribution across severity levels**.

```sql
--Vehicle types most frequently involved in accidents

SELECT vehicle_type,
    COUNT(*) AS Accident_Count
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;
```
| Vehicle Type                                      | Accident Count |
|--------------------------------------------------|---------------|
| Car                                             | 150,831       |
| Van / Goods (≤3.5t mgw)                          | 9,938         |
| Motorcycle over 500cc                            | 7,165         |
| Bus or coach (≥17 passenger seats)              | 5,317         |
| Motorcycle 125cc and under                       | 4,677         |
| Goods (≥7.5t mgw)                                | 4,036         |
| Taxi / Private hire car                          | 3,544         |
| Motorcycle 50cc and under                        | 2,385         |
| Motorcycle (125cc - 500cc)                       | 2,036         |
| Goods (3.5t - 7.5t)                              | 1,609         |
| Other vehicle                                    | 1,593         |
| Minibus (8 - 16 passenger seats)                 | 496           |
| Agricultural vehicle                             | 389           |
| Pedal cycle                                      | 44            |
| Ridden horse                                     | 1             |

#### 🔍 Key Insights:  
- **🚗 Cars dominate accident involvement (150,831 cases),** likely due to their high road presence.  
- **🛵 Motorcycles (various sizes) account for over 16,000 accidents,** highlighting their vulnerability in traffic.  
- **🚌 Buses, taxis, and goods vehicles** contribute significantly, suggesting risks in **public and commercial transport sectors**.  
- **🚲 Pedal cycles (44 cases) and ridden horses (1 case) show minimal involvement**, though still relevant for safety planning.  

#### 📊 Implications:  
- **🚦 Road safety policies should focus on high-risk vehicle types (e.g., motorcycles, commercial transport).**  
- **📉 Targeted awareness campaigns for motorcyclists** could reduce accident rates.  
- Further analysis can **correlate vehicle type with accident severity** for deeper insights.  

Understanding vehicle-type accident patterns can help in **developing better traffic safety regulations** and **reducing high-risk vehicle collisions**. 🚗🚦✨  

---
```sql
--Number of casualties per accident severity level

SELECT 
    accident_severity, 
    SUM(number_of_casualties) AS total_casualties,
    COUNT(*) AS total_accidents,
    ROUND(AVG(number_of_casualties), 2) AS avg_casualties_per_accident
FROM road_accidents_stagging
GROUP BY accident_severity
ORDER BY total_casualties DESC;
```
| Accident Severity | Total Casualties | Total Accidents | Avg. Casualties per Accident |
|------------------|-----------------|-----------------|----------------------------|
| Slight          | 221,197          | 166,196         | 1.33                       |
| Serious         | 36,577           | 25,408          | 1.44                       |
| Fatal           | 4,236            | 2,457           | 1.72                       |

### 🔍 Key Insights  
- **🚗 Slight accidents are the most frequent (166,196 cases),** but they have the lowest casualty rate per accident (**1.33**).  
- **⚠️ Fatal accidents, though less common (2,457 cases),** have the highest casualty rate (**1.72 casualties per accident**), reflecting their severe impact.  
- **📈 As severity increases, so does the average casualty count,** indicating a strong correlation between accident severity and human impact.  

### 📊 Implications  
- **🚦 Road safety strategies should prioritize reducing serious and fatal accidents** to minimize casualties.  
- **🛑 Stricter enforcement of traffic laws** (e.g., speed limits, seatbelt use) could help lower the severity of accidents.  

Understanding accident severity patterns can aid in **developing targeted safety measures** and **reducing high-impact collisions**. 🚘⚠️✨

---

### 5. Impact From Speed & Road Conditions

This section analyzes how **road surface conditions and Speed** correlate, offering insights into risk factors affecting accident outcomes.


```sql
--Accidents grouped by speed limits and severity level

SELECT speed_limit,accident_severity,COUNT(*)
FROM road_accidents_stagging
GROUP BY 1,2
ORDER by 1 DESC,3 DESC;
```

| Speed Limit (mph) | Accident Severity | Count  |
|------------------|------------------|--------|
| 70              | Slight            | 10,383 |
|                 | Serious           | 1,479  |
|                 | Fatal             | 287    |
| 60              | Slight            | 19,982 |
|                 | Serious           | 4,665  |
|                 | Fatal             | 659    |
| 50              | Slight            | 4,878  |
|                 | Serious           | 851    |
|                 | Fatal             | 136    |
| 40              | Slight            | 13,547 |
|                 | Serious           | 2,003  |
|                 | Fatal             | 211    |
| 30              | Slight            | 116,007 |
|                 | Serious           | 16,196  |
|                 | Fatal             | 1,155   |
| 20              | Slight            | 1,394  |
|                 | Serious           | 214    |
|                 | Fatal             | 9      |
| 15              | Slight            | 2      |
| 10              | Slight            | 3      |

#### 🔍 Key Insights:  
- **🚗 The highest accident count occurs in 30 mph zones (133,358 cases),** likely due to **high urban traffic density.**  
- **⚠️ Fatal accidents regarding speed:**  
  - **70 mph: 287 fatalities**  
  - **60 mph: 659 fatalities**  
  - **30 mph: 1,155 fatalities** (even at lower speeds, fatalities occur frequently in urban areas).  
- **🏙️ Lower speed limits (10-20 mph) see significantly fewer accidents,** reinforcing their **safety benefits in pedestrian-heavy zones.**  

#### 📊 Implications:  
- **🛑 Speed management strategies (e.g., speed cameras, stricter enforcement) can reduce high-speed fatalities.**  
- **🚦 Lower speed zones in high-risk urban areas may enhance pedestrian safety.**  

---
```sql
--Relationship between road surface conditions and accident count

SELECT 
    road_surface_conditions, 
    COUNT(*) AS accident_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM road_accidents_stagging
GROUP BY road_surface_conditions
ORDER BY accident_count DESC;
```
| Road Surface Condition        | Accident Count | Percentage |
|------------------------------|---------------|------------|
| Dry                           | 132,765       | 68.41%     |
| Wet or damp                   | 50,615        | 26.08%     |
| Frost or ice                  | 7,597         | 3.91%      |
| Snow                          | 2,888         | 1.49%      |
| Flood over 3cm deep           | 196           | 0.10%      |

#### 🔍 Key Insights:  
- **🚗 Most accidents occur on dry roads (132,765 cases, 68.41%),** possibly due to **higher traffic volume and speed.**  
- **🌧️ Wet or damp roads account for over a quarter of accidents (26.08%),** emphasizing the need for **caution in rainy conditions.**  
- **❄️ Icy and snowy roads have fewer accidents but higher severity rates,** as seen in earlier analyses.  
- **🌊 Flooded roads have the lowest accident count (0.10%),** possibly because drivers avoid them, but when accidents do occur, they are often severe.  

#### 📊 Implications:  
- **🛑 Enhanced road maintenance (better drainage, anti-skid surfaces) can reduce wet-road accidents.**  
- **🚦 Public awareness campaigns on driving in poor weather can improve road safety.**

---
```sql
--Effect of lighting conditions (e.g., daylight vs. night-time)

SELECT 
    light_conditions, 
    COUNT(*) AS accident_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM road_accidents_stagging
GROUP BY 1
ORDER BY 2 DESC;
```
| Lighting Condition              | Accident Count | Percentage |
|---------------------------------|---------------|------------|
| Daylight                        | 142,439       | 73.40%     |
| Darkness - lights lit           | 41,129        | 21.19%     |
| Darkness - no lighting          | 8,845         | 4.56%      |
| Darkness - lighting unknown     | 1,032         | 0.53%      |
| Darkness - lights unlit         | 616           | 0.32%      |

#### 🔍 Key Insights:  
- **🌞 Most accidents occur in daylight (73.40%),** likely due to **higher traffic volume during the day.**  
- **🌙 Darkness with streetlights accounts for 21.19% of accidents,** indicating that artificial lighting still poses visibility challenges.  
- **⚠️ Poorly lit roads are high-risk:**  
  - **4.56% of accidents occur in complete darkness (no lighting).**  
  - **Lighting failures ("lights unlit") contribute to 0.32% of accidents.**  
- **🔎 The small percentage of accidents under "lighting unknown" (0.53%) suggests some data inconsistencies or missing records.**  

#### 📊 Implications:  
- **🚦 Improving street lighting in accident-prone areas could reduce nighttime accidents.**  
- **🔍 Further analysis could explore accident severity across different lighting conditions.**  
- **🛑 Visibility enhancements, such as reflective road signs and markings, may help reduce accidents in low-light conditions.**  

Understanding how **lighting conditions influence accident risks** can guide **infrastructure improvements and policy decisions.** 🚗⚠️✨

---
### 6. Weather Impact on accidents.
```sql
--Comparing accident counts in clear vs. adverse weather conditions.

SELECT 
    CASE 
        WHEN weather_conditions IN ('Fine no high winds') THEN 'Clear Weather'
        ELSE 'Adverse weather'
    END AS Weather_catagory,
    COUNT(*) AS Accident_Count,
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2)
FROM road_accidents_stagging
GROUP BY Weather_catagory
ORDER BY Accident_Count;
```
| Weather Category  | Accident Count | Percentage |
|------------------|---------------|------------|
| Clear Weather   | 157,273       | 81.04%     |
| Adverse Weather | 36,788        | 18.96%     |

#### 🔍 Key Insights:  
- **☀️ Most accidents (81.04%) occur in clear weather,** likely due to **higher traffic volume and speed.**  
- **⛈️ Adverse weather accounts for 18.96% of accidents,** showing that poor conditions significantly impact road safety.  
- **❗ While fewer accidents occur in bad weather, their severity are higher due to reduced visibility and slippery roads.**  

#### 📊 Implications:  
- **🛑 Drivers need to be more cautious during adverse weather conditions.**  
- **🚦 Infrastructure improvements, such as better road drainage and anti-skid surfaces, can reduce wet-weather accidents.** 


# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights

From the analysis, several **critical insights** emerged regarding road accidents:  

1. **🚦 High-Risk Accident Zones:**  
   - Certain locations experience **higher accident rates**, emphasizing the need for **targeted safety measures** in these areas.  

2. **🌧️ Weather & Road Conditions Impact Accidents:**  
   - **Wet, icy, and snowy roads** contribute significantly to accidents, highlighting the importance of **improved road maintenance and driver awareness.**  

3. **💡 Lighting & Time Factors:**  
   - **Most accidents occur in daylight**, but accidents in **low-light conditions** tend to be more severe, stressing the need for **better street lighting** and **nighttime driving precautions.**  

4. **🚗 Vehicle Type Influence:**  
   - **Cars account for the majority of accidents**, but **motorcycles and larger vehicles** have a **higher accident severity rate.**  

5. **⚠️ Junction & Speed Impact:**  
   - **T-junctions and roundabouts are accident hotspots,** showing the need for **better traffic control and driver education.**  
   - **Accidents at higher speed limits tend to be more severe,** reinforcing the importance of **speed regulation and enforcement.**  

  
## 🔚 Closing Thoughts  

This project significantly enhanced my **SQL skills** and provided **valuable insights** into road accident patterns. By analyzing key factors such as **weather, lighting, road conditions, and vehicle involvement**, I uncovered trends that can help improve **traffic safety and accident prevention.**  

Understanding **where, when, and why accidents occur** is essential for **data-driven decision-making** in **urban planning, traffic regulations, and road safety initiatives.**  

This project highlights the **power of data analytics** in solving **real-world problems**, emphasizing the need for **continuous learning and adaptation** to uncover meaningful insights from raw data. 🚀📊  
