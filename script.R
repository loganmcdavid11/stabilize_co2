library(tidyverse)
library(ggplot2)
library(broom)

#### DATA ORGANIZATION & CLEANING ####
energy_master_data <- read.csv("owid-energy-data.csv") |>
  filter(year >= 2003)
summary(energy_master_data)

co2_master_data <- read.csv("owid-co2-data.csv") |>
  filter(year >= 2003)
summary(co2_master_data)

# Begin cleaning unnecessary countries
# energy first
unique(energy_master_data$country)

# Countries
energy_countries_list <- c(
  "Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
  "Anguilla", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba",
  "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh",
  "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan",
  "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil",
  "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi",
  "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands",
  "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros",
  "Congo", "Cook Islands", "Costa Rica", "Croatia", "Cuba", "Curacao",
  "Cyprus", "Czechia", "Democratic Republic of Congo", "Denmark", "Djibouti",
  "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador",
  "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia",
  "Faeroe Islands", "Fiji", "Finland", "France", "French Guiana",
  "French Polynesia", "Gabon", "Gambia", "Georgia", "Germany", "Ghana",
  "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam",
  "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras",
  "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq",
  "Ireland", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan",
  "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos",
  "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Lithuania",
  "Luxembourg", "Macao", "Madagascar", "Malawi", "Malaysia", "Maldives",
  "Mali", "Malta", "Martinique", "Mauritania", "Mauritius", "Mayotte",
  "Mexico", "Micronesia (country)", "Moldova", "Monaco", "Mongolia",
  "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia",
  "Nauru", "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua",
  "Niger", "Nigeria", "Niue", "North Korea", "North Macedonia", "Norway",
  "Oman", "Pakistan", "Palau", "Palestine", "Panama", "Papua New Guinea",
  "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico",
  "Qatar", "Romania", "Russia", "Rwanda", "Saint Helena", "Saint Kitts and Nevis",
  "Saint Lucia", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines",
  "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal",
  "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Sint Maarten (Dutch part)",
  "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa",
  "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname",
  "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand",
  "Timor", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey",
  "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine",
  "United Arab Emirates", "United Kingdom", "United States", "Uruguay",
  "Uzbekistan", "Vanuatu", "Vatican", "Venezuela", "Vietnam",
  "Western Sahara", "Yemen", "Zambia", "Zimbabwe"
)

# Regions
energy_regions_list <- c(
  "Africa", "Asia", "Central America", "Central Asia", "Eastern Africa",
  "Eastern Asia", "Eastern Europe", "Europe", "Europe (excl. EU-27)",
  "Europe (excl. EU-28)", "European Union (27)", "European Union (28)",
  "Latin America", "Melanesia", "Micronesia (region)", "Middle Africa",
  "North America", "Northern Africa", "Northern America", "Northern Europe",
  "Oceania", "Polynesia", "South America", "South-Eastern Africa",
  "South-Eastern Asia", "Southern Africa", "Southern Asia", "Southern Europe",
  "Sub-Saharan Africa", "Western Africa", "Western Asia", "Western Europe",
  "World"
)

# Organizations
energy_organizations_list <- c(
  "EU28 (Shift)", "European Union (27)", "OECD (EI)", "OECD (Shift)",
  "OECD - Europe", "OECD - Oceania", "OECD Americas"
)

# Groupings
energy_groupings_list <- c(
  "High-income countries", "Upper-middle-income countries",
  "Lower-middle-income countries", "Low-income countries", "World"
)

# Create the 4 datasets without modifying the master data
energy_countries <- energy_master_data %>%
  filter(country %in% energy_countries_list)

energy_regions <- energy_master_data %>%
  filter(country %in% energy_regions_list)

energy_organizations <- energy_master_data %>%
  filter(country %in% energy_organizations_list)

energy_groupings <- energy_master_data %>%
  filter(country %in% energy_groupings_list)

# Now for co2
unique(co2_master_data$country)

# Countries
co2_countries_list <- c(
  "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Anguilla", "Antigua and Barbuda",
  "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain",
  "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan",
  "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso",
  "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Chad", "Chile", "China",
  "Colombia", "Comoros", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Curacao",
  "Cyprus", "Czechia", "Democratic Republic of Congo", "Denmark", "Djibouti", "Dominica",
  "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea",
  "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Faroe Islands", "Fiji", "Finland", "France",
  "French Polynesia", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Greenland",
  "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong",
  "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy",
  "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait",
  "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein",
  "Lithuania", "Luxembourg", "Macao", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali",
  "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia (country)",
  "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar",
  "Namibia", "Nauru", "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua",
  "Niger", "Nigeria", "Niue", "North Korea", "North Macedonia", "Norway", "Oman", "Pakistan",
  "Palau", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland",
  "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Helena", "Saint Kitts and Nevis",
  "Saint Lucia", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa",
  "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles",
  "Sierra Leone", "Singapore", "Sint Maarten (Dutch part)", "Slovakia", "Slovenia",
  "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka",
  "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania",
  "Thailand", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
  "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates",
  "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican", "Venezuela",
  "Vietnam", "Wallis and Futuna", "Yemen", "Zambia", "Zimbabwe"
)

# Continents and regions
co2_continents_list <- c(
  "Africa", "Asia", "Australia", "Europe", "North America", "Oceania", "South America"
)

# Income groups
co2_income_groups_list <- c(
  "High-income countries", "Low-income countries", "Lower-middle-income countries",
  "Upper-middle-income countries", "OECD (GCP)", "OECD (Jones et al.)", "Non-OECD (GCP)",
  "Least developed countries (Jones et al.)"
)

# Special regions & geopolitical groups
co2_special_groups_list <- c(
  "Africa (GCP)", "Asia (GCP)", "Asia (excl. China and India)", "Central America (GCP)",
  "Europe (GCP)", "Europe (excl. EU-27)", "Europe (excl. EU-28)", "European Union (27)",
  "European Union (28)", "Middle East (GCP)", "North America (GCP)", "North America (excl. USA)",
  "Oceania (GCP)", "South America (GCP)"
)

# International categories & other
co2_international_other_list <- c(
  "International aviation", "International shipping", "International transport",
  "Kuwaiti Oil Fires", "Kuwaiti Oil Fires (GCP)", "World", "Ryukyu Islands", "Ryukyu Islands (GCP)"
)

# Create the 5 datasets without modifying the master data
co2_countries <- co2_master_data %>%
  filter(country %in% co2_countries_list)

co2_continents <- co2_master_data %>%
  filter(country %in% co2_continents_list)

co2_income_groups <- co2_master_data %>%
  filter(country %in% co2_income_groups_list)

co2_special_groups <- co2_master_data %>%
  filter(country %in% co2_special_groups_list)

co2_international_other <- co2_master_data %>%
  filter(country %in% co2_international_other_list)


# Master merged dataset
merged_master_data <- left_join(co2_master_data, energy_master_data, by = c("country", "year"))
head(merged_master_data)

#### LEARNING ABOUT THE DATASET ####

# Note to self: we are going to just look in the energy dataset and looking for consumption

## ENERGY CONSUMPTION FROM RENEWABLE ENERGY ACROSS WORLD ##
energy_2019 <- energy_master_data %>%
  filter(year == 2019) %>%
  select(
    country,
    biofuel_consumption,
    renewables_consumption,
    coal_consumption,
    fossil_fuel_consumption,
    gas_consumption,
    hydro_consumption,
    low_carbon_consumption,
    nuclear_consumption,
    oil_consumption,
    other_renewable_consumption,
    primary_energy_consumption,
    renewables_consumption,
    solar_consumption,
    wind_consumption
  )

# Pivot to long format
# Basically we flip the data from long way to other way
energy_2019_long <- energy_2019 %>%
  pivot_longer(
    cols = -country,
    names_to = "energy_type",
    values_to = "consumption"
  )

# Sum consumption across all countries for each energy type
energy_2019_summary <- energy_2019_long %>%
  group_by(energy_type) %>%
  summarise(total_consumption = sum(consumption, na.rm = TRUE)) %>%
  arrange(desc(total_consumption))

# Plot
ggplot(energy_2019_summary, aes(x = reorder(energy_type, -total_consumption), y = total_consumption)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    title = "Global Energy Consumption by Type (2019)",
    x = "Energy Type",
    y = "Total Consumption (TWh)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


## ENERGY CONSUMPTION FROM RENEWABLE ENERGY ACROSS WORLD ##
# Filter for 2019 and United States only
us_energy_2019 <- energy_master_data %>%
  filter(year == 2019, country == "United States") %>%
  select(
    biofuel_consumption,
    coal_consumption,
    fossil_fuel_consumption,
    renewables_consumption,
    gas_consumption,
    hydro_consumption,
    low_carbon_consumption,
    nuclear_consumption,
    oil_consumption,
    other_renewable_consumption,
    primary_energy_consumption,
    renewables_consumption,
    solar_consumption,
    wind_consumption
  )

# Pivot to long format
us_energy_2019_long <- us_energy_2019 %>%
  pivot_longer(
    cols = everything(),
    names_to = "energy_type",
    values_to = "consumption"
  )

# Plot
ggplot(us_energy_2019_long, aes(x = reorder(energy_type, -consumption), y = consumption)) +
  geom_bar(stat = "identity", fill = "firebrick") +
  labs(
    title = "U.S. Energy Consumption by Type (2019)",
    x = "Energy Type",
    y = "Consumption (TWh)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




# Renewable energy consumption ~ co2 emissions via United States of America  ----

# Variables to use:
#   Energy ds: year, country, renewables_consumption
#   co2 ds: year, country, co2
#         Optional: co2_per_capita, co2_per_gdp

# Filter for United States
usa_data <- merged_master_data |>
  filter(country == "United States") |>
  select(year, renewables_consumption, co2)

# Pivot longer to have variables in one column for grouped bar plot
usa_long <- usa_data |>
  pivot_longer(cols = c(renewables_consumption, co2),
               names_to = "variable",
               values_to = "value")

# Plot grouped bar plot with year on x-axis and value on y-axis
ggplot(usa_long, aes(x = factor(year), y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("renewables_consumption" = "green", "co2" = "black"),
                    labels = c("Renewables Consumption", "CO2 Emissions")) +
  labs(
    title = "Renewable Energy Consumption and CO2 Emissions in USA (2003-2023)",
    x = "Year",
    y = "Value",
    fill = ""
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


correlation <- cor(usa_data$renewables_consumption, usa_data$co2, use = "complete.obs", method = "pearson")

print(paste("Pearson correlation between renewables consumption and CO2 emissions (USA):", round(correlation, 3)))

# Run a linear regression
model <- lm(co2 ~ renewables_consumption, data = usa_data)

# Get a summary of the model
summary(model)

# Get model data with residuals and fitted values
model_data <- augment(model)

# Plot residuals vs fitted values
ggplot(model_data, aes(.fitted, .resid)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(
    title = "Residuals vs Fitted Values",
    x = "Fitted Values (Predicted CO2)",
    y = "Residuals"
  ) +
  theme_minimal()

# QQ Plot for normality of residuals
ggplot(model_data, aes(sample = .resid)) +
  stat_qq(color = "darkgreen", size = 3) +
  stat_qq_line(color = "black") +
  labs(
    title = "QQ Plot of Residuals",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()

# Renewable energy consumption ~ co2 emissions via All Continents ----
# Define target continents
continents <- c("Africa", "Asia", "Australia", "Europe", "North America", "Oceania", "South America")

# Filter and aggregate data for those continents (world total)
world_data <- merged_master_data |>
  filter(country %in% continents) |>
  group_by(year) |>
  summarise(
    renewables_consumption = sum(renewables_consumption, na.rm = TRUE),
    co2 = sum(co2, na.rm = TRUE)
  )

# Pivot longer to have variables in one column for grouped bar plot
world_long <- world_data |>
  pivot_longer(cols = c(renewables_consumption, co2),
               names_to = "variable",
               values_to = "value")

# Plot grouped bar plot with year on x-axis and value on y-axis
ggplot(world_long, aes(x = factor(year), y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("renewables_consumption" = "green", "co2" = "black"),
                    labels = c("Renewables Consumption", "CO2 Emissions")) +
  labs(
    title = "Renewable Energy Consumption and CO2 Emissions (2003–2023, Global View)",
    x = "Year",
    y = "Value",
    fill = ""
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Calculate Pearson correlation
correlation <- cor(world_data$renewables_consumption, world_data$co2, use = "complete.obs", method = "pearson")
print(paste("Pearson correlation between renewables consumption and CO2 emissions (Global):", round(correlation, 3)))

# Run a linear regression
model <- lm(co2 ~ renewables_consumption, data = world_data)

# Get a summary of the model
summary(model)

# Get model data with residuals and fitted values
library(broom)
model_data <- augment(model)

# Residuals vs Fitted plot
ggplot(model_data, aes(.fitted, .resid)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(
    title = "Residuals vs Fitted Values (Global)",
    x = "Fitted Values (Predicted CO2)",
    y = "Residuals"
  ) +
  theme_minimal()

# QQ Plot for normality of residuals
ggplot(model_data, aes(sample = .resid)) +
  stat_qq(color = "darkgreen", size = 3) +
  stat_qq_line(color = "black") +
  labs(
    title = "QQ Plot of Residuals (Global)",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()



# Brainstorming since these do not help my question
# What if we did a counterfactural analysis
# What would CO₂ emissions have been if renewable energy consumption had not increased
#    Then we could compare that to what actually happened 
# NEW GOAL: Estimate the amount of CO₂ that would have been emitted without increased renewable consumption, and compare that to actual emissions.
#    "If renewable energy use had stayed constant, how much higher would CO₂ emissions be?"

# FIRST ATTEMPT AT COUNTERFACTURAL MODEL ----
# Variables for what drives CO2 emissions 
  # Renewable consumptions - renewables_consumption	
  # Fossil fuel consumptions - fossil_fuel_consumptions
  # Total energy demand - electricity_demand
  # GDP - gdp
  # Population - population

# This estimates CO₂ as a function of known drivers, including renewables
model <- lm(co2 ~ fossil_fuel_consumption + gdp.x + population.x + renewables_consumption, data = merged_master_data)
summary(model)
# NOTES ABOUT THIS SUMMARY: Higher renewable consumption is associated with higher co2
#  This means that even as renewable energies increase, carbon emissions increase more. No signs of CO2 emissions slowing down
#  I think this is totally fair, as the world goes on we need more power, but we are still using largely consuming fossil fuels

# Lets look at that but just with the united stated
usa_model <- merged_master_data[merged_master_data$country == "United States", ]
usa_lm <- lm(co2 ~ fossil_fuel_consumption + population.x + renewables_consumption, data = usa_model)
summary(usa_lm)

# Okay so gdp and population do not help the data, but we are still gonna leave it for now.
# I am also highly considering just looking at the united states for now

# Step 1: Make a copy of the original dataset
counterfactual_data <- usa_model

# Step 2: Fix renewables_consumption to the 2003 value
renewable_2003 <- counterfactual_data$renewables_consumption[counterfactual_data$year == 2003]
counterfactual_data$renewables_consumption <- renewable_2003

# Step 3: Predict CO2 under the counterfactual scenario
counterfactual_data$counterfactual_co2 <- predict(usa_lm, newdata = counterfactual_data)

# Step 4: Compare actual vs counterfactual
comparison_df <- data.frame(
  year = usa_model$year,
  actual_co2 = usa_model$co2,
  counterfactual_co2 = counterfactual_data$counterfactual_co2
)

# Step 5: View or plot the comparison
print(comparison_df)

# Optional: plot actual vs counterfactual
library(ggplot2)
ggplot(comparison_df, aes(x = year)) +
  geom_line(aes(y = actual_co2, color = "Actual CO2")) +
  geom_line(aes(y = counterfactual_co2, color = "Counterfactual CO2")) +
  labs(title = "Counterfactual Simulation: U.S. CO₂ Emissions",
       y = "CO₂ Emissions",
       color = "Legend") +
  theme_minimal()

# Even if renewable energy consumption had stayed at 2003 levels, the overall pattern of CO₂ emissions would have been similar, but higher. This suggests:
#   
#   Renewable growth did reduce CO₂ emissions, but it didn’t drastically change the trajectory.
# 
# The main drivers of CO₂ emissions were still fossil fuel consumption and population — which continued to rise and shaped the emissions pattern.
# 
# Renewables helped offset some emissions, but weren’t yet strong enough to reverse or flatten the curve.

# Total CO2 emissions avoided
sum(comparison_df$counterfactual_co2 - comparison_df$actual_co2)

# "The model shows that while U.S. CO₂ emissions would have been higher without
# renewable energy expansion, long-term trends suggest that systemic reductions
# in fossil fuel consumption are needed for deeper decarbonization."



# NOW ITS TIME TO USE MACHINE LEARNING TO MAKE PREDICTIONS

# Predict CO2 emissions based on trends using Gradient Boosting Machines ----
library(forecast)

# MODEL 1
# 1. Create time series object
co2_ts <- ts(usa_model$co2, start = min(usa_model$year), frequency = 1)

# 2. Fit ARIMA model
co2_arima <- auto.arima(co2_ts)

# 3. Forecast 20 years
co2_forecast <- forecast(co2_arima, h = 20)

# 4. Plot
autoplot(co2_forecast) +
  labs(title = "ARIMA Forecast of U.S. CO₂ Emissions",
       y = "CO₂ Emissions",
       x = "Year") +
  theme_minimal()

# MODEL 2
# 1. Build future data frame
future_years <- data.frame(
  year = 2024:2043
)

# 2. Create simple trend models
fossil_model <- lm(fossil_fuel_consumption ~ year, data = usa_model)
population_model <- lm(population.x ~ year, data = usa_model)
renewables_model <- lm(renewables_consumption ~ year, data = usa_model)

# 3. Predict inputs for future years
future_years$fossil_fuel_consumption <- predict(fossil_model, newdata = future_years)
future_years$population.x <- predict(population_model, newdata = future_years)
future_years$renewables_consumption <- predict(renewables_model, newdata = future_years)

# 4. Predict CO2 emissions using your lm model
future_years$predicted_co2 <- predict(usa_lm, newdata = future_years)

# 5. Plot
library(ggplot2)
ggplot(future_years, aes(x = year, y = predicted_co2)) +
  geom_line(color = "darkgreen", size = 1.2) +
  labs(title = "Predicted CO₂ Emissions in the U.S. (2024–2043)",
       y = "CO₂ Emissions",
       x = "Year") +
  theme_minimal()

summary(usa_lm)

# Model 3
# Add actual CO₂
actual_df <- usa_model[, c("year", "co2")]
colnames(actual_df) <- c("year", "co2")
actual_df$type <- "Actual"

# Add predicted future CO₂
future_df <- future_years[, c("year", "predicted_co2")]
colnames(future_df) <- c("year", "co2")
future_df$type <- "Predicted"

# Combine and plot
combined <- rbind(actual_df, future_df)

ggplot(combined, aes(x = year, y = co2, color = type)) +
  geom_line(size = 1.2) +
  labs(title = "U.S. CO₂ Emissions: Actual and Forecasted",
       y = "CO₂ Emissions",
       x = "Year") +
  theme_minimal()

# Now renewable

# 1. Actual renewable energy data
renewables_actual <- usa_model[, c("year", "renewables_consumption")]
colnames(renewables_actual) <- c("year", "renewables")
renewables_actual$type <- "Actual"

# 2. Forecasted renewable energy data
renewables_future <- future_years[, c("year", "renewables_consumption")]
colnames(renewables_future) <- c("year", "renewables")
renewables_future$type <- "Predicted"

# 3. Combine actual + predicted
renewables_combined <- rbind(renewables_actual, renewables_future)

# 4. Plot
library(ggplot2)
ggplot(renewables_combined, aes(x = year, y = renewables, color = type)) +
  geom_line(size = 1.2) +
  labs(title = "U.S. Renewable Energy Consumption: Actual and Forecasted",
       y = "Renewables Consumption (e.g., TWh)",
       x = "Year") +
  theme_minimal()

# NEW QUESTION ----
# How much do renewables need to grow to stabilize CO₂ emissions?
# We want to answer: “If fossil fuel use and population follow their trends, 
#                     how fast must renewables grow to keep CO₂ emissions flat 
#                    (i.e., stay constant at the last observed level)?”

# BASELINE
# Keep original fossil fuel and population predictions
baseline_fossil <- future_years$fossil_fuel_consumption
baseline_population <- future_years$population.x

# Last observed CO2 level (2023)
last_actual_co2 <- tail(usa_model$co2, 1)

# SIMULATE RENEWABLE GROWTH AND COMPUTE EMISSIONS
simulate_renewables_growth <- function(growth_rate) {
  renewables_start <- future_years$renewables_consumption[1]
  n_years <- nrow(future_years)
  
  renewables_projection <- renewables_start * (1 + growth_rate)^(0:(n_years - 1))
  
  prediction_input <- data.frame(
    year = future_years$year,
    fossil_fuel_consumption = baseline_fossil,
    population.x = baseline_population,
    renewables_consumption = renewables_projection
  )
  
  predicted_co2 <- predict(usa_lm, newdata = prediction_input)
  
  data.frame(
    year = future_years$year,
    renewables = renewables_projection,
    predicted_co2 = predicted_co2
  )
}

# SIMULATE RANGE OF GROWTH RATE
growth_rates <- seq(0, 0.10, by = 0.01)  # 0% to 10% per year

results_list <- lapply(growth_rates, simulate_renewables_growth)

names(results_list) <- paste0("Growth_", growth_rates * 100, "%")

# PLOT SCENARIOS
library(ggplot2)
library(dplyr)
library(tidyr)

# Combine all results into one dataframe
all_results <- bind_rows(
  lapply(seq_along(results_list), function(i) {
    df <- results_list[[i]]
    df$GrowthRate <- names(results_list)[i]
    df
  })
)

ggplot(all_results, aes(x = year, y = predicted_co2, color = GrowthRate)) +
  geom_line(size = 1) +
  geom_hline(yintercept = last_actual_co2, linetype = "dashed", color = "black") +
  labs(
    title = "U.S. CO₂ Emissions under Different Renewables Growth Rates (0-10%)",
    subtitle = "Dashed line = last observed CO₂ emissions",
    y = "Predicted CO₂ Emissions",
    x = "Year",
    color = "Renewables Growth Rate"
  ) +
  theme_minimal()

# Extract the final year for each scenario
summary_table <- all_results %>%
  filter(year == max(year)) %>%
  select(GrowthRate, predicted_co2) %>%
  arrange(predicted_co2)

print(summary_table)


# Oh my gosh this is the jackpot
"""
For each renewables growth rate (0%–10% per year), you forecasted U.S. CO₂ emissions in 2043, assuming fossil fuel consumption and population followed baseline trends.

🧾 The Results
Here’s your table reorganized for clarity:

Renewables Growth Rate	Predicted CO₂ in 2043
0%	4100
1%	3938
2%	3743
3%	3510
4%	3233
5%	2904
6%	2513
7%	2050
8%	1503
9%	855
10%	92

🔍 How to interpret this
The higher the annual growth rate of renewables, the lower CO₂ emissions by 2043.
Here are key observations:

✅ 0% renewables growth (no new renewable capacity)

CO₂ stays high: ~4100 units.

✅ 1–3% growth

Emissions decline modestly: down ~15–20% over 20 years.

Still significant fossil fuel emissions.

✅ 5–6% growth

Much larger decline—more than 30–40% lower CO₂.

✅ 9–10% growth

Drastic reduction in CO₂:

9%/year: emissions drop to ~855.

10%/year: emissions nearly eliminated (~92).

✨ What does this say overall?
This model implies:

Modest renewables growth alone (1–3%) slows emissions but does not stabilize them.

A growth rate around 4–5% per year gets you close to a plateau (depending where you define “flat”).

Higher rates (>7%) cause CO₂ to decline significantly—even approaching zero by 2043.

This is exactly the kind of policy-relevant insight you were aiming for:

“To maintain or reduce emissions, the U.S. would need renewables consumption to grow at at least ~5% per year over the next 20 years—assuming fossil fuel consumption does not decline.”

✅ What you can do next
Here are good next steps:

Plot CO₂ vs. renewables growth rate (2043 only).

r
Copy
Edit
library(ggplot2)
ggplot(summary_table, aes(x = as.numeric(gsub("Growth_", "", GrowthRate)), y = predicted_co2)) +
  geom_line() +
  geom_point() +
  labs(
    title = "CO₂ Emissions in 2043 vs. Renewables Growth Rate",
    x = "Annual Renewables Growth Rate (%)",
    y = "Predicted CO₂ Emissions"
  ) +
  theme_minimal()
This shows the steepness of the relationship.

Pick a target CO₂ level (e.g., current level or 50% reduction) and find the growth rate needed to hit it.

Combine this scenario with fossil fuel decline simulations for even more robust scenarios.

✅ Short interpretation you can use in your report:

“Our scenario analysis suggests that renewables growth below ~3% per year would be insufficient to stabilize emissions, while growth rates above ~5% are associated with significant reductions. An approximate annual renewables consumption growth of 5% or higher would be required to keep U.S. CO₂ emissions flat or declining by 2043 if fossil fuel consumption continues growing along historical trends.”

If you’d like, I can help you:

Find the exact growth rate for a specific emissions target.

Combine scenarios with fossil fuel cuts.

Visualize all scenarios in a single figure.

Just let me know!
"""

# Same thing as before, but with the WORLD ----
# Prepare global data
world_model_data <- merged_master_data %>%
  filter(country == "World")
summary(world_model_data)

# Fit the global regression model
world_lm <- lm(
  co2 ~ fossil_fuel_consumption + population.x + renewables_consumption,
  data = world_model_data
)

summary(world_lm)

# GENMERATE FUTURE DATA FRAMES
future_years_world <- data.frame(year = 2024:2043)

# LM to build forecast predictors
fossil_model_world <- lm(fossil_fuel_consumption ~ year, data = world_model_data)
population_model_world <- lm(population.x ~ year, data = world_model_data)
renewables_model_world <- lm(renewables_consumption ~ year, data = world_model_data)

# Predict them
future_years_world$fossil_fuel_consumption <- predict(fossil_model_world, newdata = future_years_world)
future_years_world$population <- predict(population_model_world, newdata = future_years_world)
future_years_world$renewables_consumption <- predict(renewables_model_world, newdata = future_years_world)

# Store baseline fossil and population
baseline_fossil <- future_years_world$fossil_fuel_consumption
baseline_population <- future_years_world$population

# Simulate renewable growth
simulate_renewables_growth_world <- function(growth_rate) {
  renewables_start <- future_years_world$renewables_consumption[1]
  n_years <- nrow(future_years_world)
  
  renewables_projection <- renewables_start * (1 + growth_rate)^(0:(n_years - 1))
  
  prediction_input <- data.frame(
    year = future_years_world$year,
    fossil_fuel_consumption = baseline_fossil,
    population.x = baseline_population,
    renewables_consumption = renewables_projection
  )
  
  predicted_co2 <- predict(world_lm, newdata = prediction_input)
  
  data.frame(
    year = future_years_world$year,
    renewables = renewables_projection,
    predicted_co2 = predicted_co2
  )
}

# Simulated growth rates
# First number in seq shows starting percentage
growth_rates <- seq(0, 0.10, by = 0.01)  # Now starts at 1%
results_list <- lapply(growth_rates, simulate_renewables_growth_world)
names(results_list) <- paste0("Growth_", growth_rates * 100, "%")

library(dplyr)

all_results <- bind_rows(
  lapply(seq_along(results_list), function(i) {
    df <- results_list[[i]]
    df$GrowthRate <- names(results_list)[i]
    df
  })
)


# Summary
summary_table <- all_results %>%
  filter(year == max(year)) %>%
  select(GrowthRate, predicted_co2) %>%
  arrange(predicted_co2)

print(summary_table)


# Visualize
library(ggplot2)

ggplot(all_results, aes(x = year, y = predicted_co2, color = GrowthRate)) +
  geom_line(size = 1) +
  labs(
    title = "Global CO₂ Emissions Under Different Renewables Growth Rates (0–10%)",
    y = "Predicted CO₂ Emissions",
    x = "Year",
    color = "Renewables Growth Rate"
  ) +
  theme_minimal()




