USE portfolio_for_world_and_indian_census;

-- show all the tables in the database
show tables;


-- show the content of all the tables present in the database

select * from dataset_growth_gender_ratio_literacy;
select * from dataset_indian_population;
select * from world_population;


-- changing column names for exploring the data

ALTER TABLE world_population CHANGE `World Population Percentage`  `world_population_percentage` double;

ALTER TABLE world_population CHANGE `Area (kmÂ²)`  `area` int;

ALTER TABLE world_population CHANGE `Country/Territory`  `country` varchar (100);

ALTER TABLE world_population CHANGE `Growth Rate`  `growth_rate` double;

ALTER TABLE world_population CHANGE `Density (per kmÂ²)`  `pop_density` double;

ALTER TABLE world_population
CHANGE  `2022 Population` `2022_population` int,
CHANGE  `2020 Population`  `2020_population` int,
CHANGE `2015 Population`  `2015_population` int,
CHANGE  `2010 Population`  `2010_population` int,
CHANGE `2000 Population`  `2000_population` int,
CHANGE  `1990 Population`  `1990_population` int,
CHANGE `1980 Population`  `1980_population` int,
CHANGE `1970 Population`  `1970_population` int,
CHANGE `Capital` `capital_city` varchar(100);

-- Note that Indian data is based on year 2011 only and world data is based on year 2022

-- 01 Number of rows into our datasheets;
select count(*) from dataset_growth_gender_ratio_literacy;
select count(*) from dataset_indian_population;
select count(*) from world_population;


-- 02 All data for states Uttarakhand & Rajasthan from indian data and data for india from world data

select ggl.district,ip.state,ip.population,ggl.growth,ggl.sex_ratio,ggl.literacy 
from dataset_growth_gender_ratio_literacy AS ggl 
inner join 
dataset_indian_population as ip 
on ggl.district = ip.District 
where ip.state in ('Uttarakhand', 'Rajasthan');

select * from world_population where country= "India";


-- 03 Find the country, capital city and continent from the table
SELECT country, capital_city, continent
FROM world_population
WHERE continent IS NOT NULL
GROUP BY country, continent
ORDER BY country DESC;


-- 04 Find the number of countries
SELECT DISTINCT COUNT(country)
FROM world_population
WHERE country IS NOT NULL;


-- 05 Find the number of distinct continents
SELECT COUNT(DISTINCT continent) AS continents
FROM world_population;


-- 06 Find the average population of each continent in 2022
SELECT continent, ROUND(AVG(2022_population),2) AS avg_population
FROM world_population
GROUP BY continent
ORDER BY avg_population DESC;


-- 07 Population of India AND world

select sum(population) as Total_Population_as_on_2011 
from dataset_indian_population; 

select sum(2022_population) as Total_Population_as_on_2022 
from world_population; 


-- 08 Find the highest and lowest population among all countries in 2022

SELECT MAX(2022_population) AS max_population_2022,
MIN(2022_population) AS min_population_2022
FROM world_population;


-- 09 Find the countries with the highest and lowest population in 1970
SELECT MAX(1970_population) AS max_population_1970,
MIN(1970_population) AS min_population_1970
FROM world_population
WHERE continent IS NOT NULL;


-- 10 Find the population of North America continent with a capital city called The Valley in the year 2022
SELECT continent, 2022_population
FROM world_population
WHERE continent = "North America"
AND capital_city = "The Valley";


-- 11 Find the 10 most  populated countries in 2015 
SELECT country, 2015_population AS population
FROM world_population
GROUP BY country, 2015_population
ORDER BY 2015_population DESC
LIMIT 10;


-- 12 Find the 10 least populated countries in 2015
SELECT country, 2015_population AS lowest_population
FROM world_population
GROUP BY country,2015_population
ORDER BY lowest_population ASC
LIMIT 10;

-- 13 Avg Growth Of India and world

select avg(Growth)  as Avg_Growth from dataset_growth_gender_ratio_literacy;

select avg(GROWTH_RATE)  as Avg_Growth from world_population;


-- 14 avg growth of ALL states 
select State, avg(Growth) as Avg_Growth 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Growth desc;


-- 15 avg sex ratio of each state:
select State, round(avg(Sex_Ratio), 0) as Avg_Sex_Ratio 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Sex_Ratio desc;


-- 16 avg literacy rate of each state and return all states having avg literacy rate greater than 85
select State, round(avg(Literacy), 0) as Avg_Literacy_rate 
from dataset_growth_gender_ratio_literacy 
group by state 
having round(avg(Literacy), 0) >= 85 
order by Avg_Literacy_rate desc;


-- 17 Top 3 states showing highest growth rate and top three countries having highest growth rate

select state, avg(growth) * 100 as Avg_growth 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_growth desc 
limit 3;

select country, growth_rate 
from world_population 
order by growth_rate desc 
limit 3;


-- 18 5 states showing highest and Lowest sex ratio:

select state, round(avg(Sex_ratio), 2) as Avg_Sex_Ratio 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Sex_Ratio desc 
limit 5;

select state, round(avg(Sex_ratio), 2) as Avg_Sex_Ratio 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Sex_Ratio asc 
limit 5;


-- 19 top and bottom 3 states in literacy state:

select state, round(avg(Literacy), 0) as Avg_Literacy 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Literacy desc 
limit 3;

select state, round(Avg(Literacy), 0) as Avg_Literacy 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Literacy asc 
limit 3;


-- 20 Both Top and Bottom States in single table with top 3 entries as top states and bottom 3 as bottom states in literacy:

select * from 
(select * from (
select state, round(avg(Literacy), 0) as Avg_Literacy 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Literacy desc 
limit 3)
a
union
select * from (
select state, round(avg(Literacy), 0) as Avg_Literacy 
from dataset_growth_gender_ratio_literacy 
group by state 
order by Avg_Literacy 
limit 3)
 b
) c;


-- 21 Find all districts of States where state's name is starting with letter 'a' & 'b' and find all countries with capital where country name is starting with 'a' or 'b';

select district,state 
from dataset_growth_gender_ratio_literacy 
where Lower(State) like "a%" or Lcase(State) like "b%";

select country,capital_city 
from world_population 
where Lower(country) like "a%" or Lcase(country) like "b%";


-- 22 Find the countries whose total population is greater than the average population
SELECT * 
FROM (SELECT country,SUM(2020_population) AS total_population
	           FROM world_population
			   GROUP BY country) population
JOIN (SELECT AVG(total_population) as population
                FROM (SELECT country,SUM(2020_population) AS total_population
				FROM world_population
			    GROUP BY country) c)avg_population
	  ON population.total_population > avg_population.population
      ORDER BY total_population DESC
      LIMIT 10;
      
-- 23 Find the number of countries whose population is less than the highest population in 2022
SELECT COUNT(country)
FROM world_population
 WHERE 2022_population < (SELECT MAX(2022_population)
                        FROM world_population
                     );


-- 24 Find the average population and area of the year 2020
SELECT AVG(2020_population) AS avg_population, AVG(area) AS avg_area
FROM world_population
WHERE continent IS NOT NULL;



-- 25 Finding the most dense populated countries in 2022 means area < avg(Area) and population > avg(population)
SELECT country, 2022_population, area
  FROM world_population
 WHERE 2022_population > (SELECT AVG(2022_population)
                       FROM world_population
                    )
   AND area < (SELECT AVG(area)
                 FROM world_population
);

-- 26 Find the highest and minimum population growth rate
SELECT MAX(growth_rate) AS max_pop_growth,
	   MIN(growth_rate) AS min_pop_growth 
  FROM world_population;
  
--  27 Find the largest and smallest area
SELECT MAX(area) AS max_area,
	   MIN(area) AS min_area 
  FROM world_population;
  
-- 28 Find the country with the smallest area
SELECT country, area
FROM world_population
WHERE area = 1;


-- 29 Create a new field of area sizes. Return the country, continent, country code and area. Order them in descending order.
SELECT country, continent, cca3, area,
    CASE WHEN area > 2000000
            THEN 'large'
	   WHEN area > 40000
            THEN 'medium'
	   ELSE 'small' END
       as area_size_group
FROM world_population;


-- 30 Find the rank and dense rank of countries population in the year 2015 
SELECT
country,
2015_population,
rank() OVER (ORDER BY 2015_population DESC),
dense_rank() OVER (ORDER BY 2015_population DESC)
FROM world_population
LIMIT 100;


-- 31 Total males and females in each states

select d.state, sum(d.males) as total_males, sum(d.females) as total_females 
from (
select c.district, c.state, round(c.population/(c.sex_ratio+1), 0) as Males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) as females 
from (
select d1.district, d1.state, d1.sex_ratio/1000 as sex_ratio, d2.Population 
from dataset_growth_gender_ratio_literacy as d1
join dataset_indian_population as d2 
on d1.District = d2.District 
order by Population desc) c
) d
group by d.state;


-- 32 Total litracy rate of each state

with literacy_rate_of_each_state as (select state, 100*sum(literate_people)/(sum(illiterate_people)+sum(literate_people)) as literacy_rate 
from (
select district, state, round(literacy_ratio*Population, 0) as literate_people, round((1 - literacy_ratio)* population, 0) as illiterate_people 
from (
select d1.district, d1.state, d1.literacy/100 as literacy_ratio, d2.Population 
from dataset_growth_gender_ratio_literacy as d1
join dataset_indian_population as d2 
on d1.District = d2.District
 order by Population desc) c) x
group by state 
order by literacy_rate desc
)
select * from literacy_rate_of_each_state;


-- 33 Total litracy rate of India

select (sum(literate_people)/((sum(literate_people))+(sum(illiterate_people))))*100 as literacy_rate_of_country 
from (
select state, sum(literate_people) as literate_people, sum(illiterate_people) as illiterate_people 
from (
select district, state, round(literacy_ratio*Population, 0) as literate_people, round((1 - literacy_ratio)* population, 0) as illiterate_people 
from (
select d1.district, d1.state, d1.literacy/100 as literacy_ratio, d2.Population 
from dataset_growth_gender_ratio_literacy as d1
join dataset_indian_population as d2 
on d1.District = d2.District 
order by Population desc) c) x
group by state 
order by literate_people desc, illiterate_people desc
)d;


-- 34 total_populatioin of India in previous census 

select Sum(Previous_Census_Population) as Previous_Census_Population, Sum(Current_Census_Population) as Current_Census_Population
from (
select State, Sum(Previous_Census_Population) as Previous_Census_Population, Sum(Current_Census_Population) as Current_Census_Population 
from(
select district, state, round(population/(1+growth),0) as Previous_Census_Population, Population as Current_Census_Population 
from (
select d1.district, d1.state, d1.growth as growth, d2.Population 
from dataset_growth_gender_ratio_literacy as d1
join dataset_indian_population as d2 
on d1.District = d2.District 
order by Population desc) c) x
group by State 
order by Previous_Census_Population desc, Current_Census_Population desc) y;


-- 35 output top 3 district from each state with highest literacy rate.

select District, State, Literacy, rnk 
from (
select District, State, Literacy, rank() over(partition by State order by Literacy desc) rnk 
from dataset_growth_gender_ratio_literacy)x
where rnk in (1, 2, 3) 
order by State;






