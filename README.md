# INTRODUCTION
•Census is nothing but a process of collecting, compiling, analyzing, evaluating, publishing and disseminating statistical data regarding the population.

•It is a reflection of truth and facts as they exist in a country about its people, their diversity of habitation, religion, culture, language, education, health and socio-economic status.

•The word ‘Census’ is derived from the Latin word ‘Censere’ meaning ‘to assess or to rate’.

•It covers demographic, social and economic data and are provided as of a particular date. Census is useful for formulation of development policies and plans and demarcating constituencies for elections.

This repository consists of the following :

README.txt (this file)
Dataset : "Dataset_Indian_Population.csv" , "Dataset_growth_sex-ratio_literacy.csv" and "world_Population.csv"
Question set file: Question_Set_For_Census.txt
Query File : portfolio_census_india_world_queries.sql

Step 1 : DATA CLEANING
To keep names of states same in dataset and shapefile, following transformations were performed.

changing the column names for effective data exploration: 
`World Population Percentage` changed to `world_population_percentage`,
`Area (kmÂ²)` changed to `area`,
`Country/Territory` changed to `country`,
`Growth Rate` changed to `growth_rate`,
`Density (per kmÂ²)` changed to `pop_density`.

step 2 : LOADING THE DATA
Datasets is loaded in a SQL workbench.

Step 3 : SUMMARIZING THE DATASET
The questions in the question set file (someFile.txt) have been answered.
