# Renewable Energy Offsetting CO2 Study
**NOTE:** This project is still under development, thank you for understanding
 ## Problem Statement and Background
### Problem
- *How much Carbon Dioxide has been offset by renewable energy adoption within the last decade?*
  - My insperation for this question is becasue I have a passion for making data-driven decisions for a business or a company in order to help make decisions to increase growth and success within the company.
  - I also am extremely interested in the environment, and I believe data is the single most important tool for companies to make smart decisions on how they should approach their environmental decisions.
- I plan on making predictions based on:
  - Renewable energy production globally over the past 10 years
  - Estimate carbon dioxide emissions that were avoided because of subsiituted renewable energy for fossil-fuel based energy production
  - Account for regional variations across the globe as well as lidecycle emissions of renewable and non-renewable energies
### Background
- Dataset sources are:
  - [**Renewable Energy World Wide: 1965~2022 - renewable-share-energy.csv**](https://www.kaggle.com/datasets/belayethossainds/renewable-energy-world-wide-19652022/data?select=01+renewable-share-energy.csv)
  - [**Renewable Energy World Wide: 1965~2022 - modern-renewable-energy-consumption.csv**](https://www.kaggle.com/datasets/belayethossainds/renewable-energy-world-wide-19652022/data?select=02+modern-renewable-energy-consumption.csv)
  - [**Data on CO2 and Greenhouse Gas Emissions by Our World in Data - owid-co2-data.csv**](https://github.com/owid/co2-data)
 
## Data and Exploratory Analysis
- Within the co2 dataset, the most telling variable will be *co2_growth_prct* which consists of a percentage of the annual co2 emission of a country within a specific year. Within the renewable energy datasets, we will be looking mainly at the same, *renewables* consisting of a percentage of energy that was renewable.
- Initial cleaning consists of filtering each dataset to have a decade range (2011 - 2021) as well as making sure each dataset has the same number of countries.  I also went ahead and made a new column that categorizes each country into its continent in order to break emissions down by continent later on. 
