library(tidyverse)

master_data <- read.csv("owid-co2-data.csv")
summary(master_data)
head(master_data)

# Discover unique countries
summary(master_data$country)
unique_countries <- unique(master_data$country)
print(unique_countries)

# Range of years: 2013 - 2023
master_data <- subset(master_data, year >= 2013 & year <= 2023)

# Check the first few rows of the filtered data to confirm
head(master_data)


# Assign continents based on the country
master_data$continent <- NA

master_data$continent[master_data$country %in% c("Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", "Brunei", "Cambodia", "China", "Cyprus", "Georgia", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", "North Korea", "Oman", "Pakistan", "Palestine", "Philippines", "Qatar", "Russia", "Saudi Arabia", "Singapore", "South Korea", "Sri Lanka", "Syria", "Taiwan", "Tajikistan", "Thailand", "Timor-Leste", "Turkey", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Vietnam", "Yemen")] <- "Asia"

master_data$continent[master_data$country %in% c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cabo Verde", "Cameroon", "Central African Republic", "Chad", "Comoros", "Congo (Congo-Brazzaville)", "Democratic Republic of the Congo (Congo-Kinshasa)", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Eswatini (fmr. 'Swaziland')", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Ivory Coast", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "São Tomé and Príncipe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Togo", "Tunisia", "Uganda", "Zambia", "Zimbabwe")] <- "Africa"

master_data$continent[master_data$country %in% c("Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Cyprus", "Czechia (Czech Republic)", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia", "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine", "United Kingdom")] <- "Europe"

master_data$continent[master_data$country %in% c("Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Guyana", "Paraguay", "Peru", "Suriname", "Uruguay", "Venezuela")] <- "South America"

master_data$continent[master_data$country %in% c("Australia", "Fiji", "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "New Zealand", "Palau", "Papua New Guinea", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Vanuatu")] <- "Oceania"

master_data$continent[master_data$country %in% c("Canada", "Mexico", "United States")] <- "North America"

master_data$continent[master_data$country %in% c("Antarctica")] <- "Antarctica"

# Check the updated dataset
head(master_data)

# Create subsets 
asia_data <- subset(master_data, continent == "Asia")
africa_data <- subset(master_data, continent == "Africa")
north_america_data <- subset(master_data, continent == "North America")
south_america_data <- subset(master_data, continent == "South America")
europe_data <- subset(master_data, continent == "Europe")
oceania_data <- subset(master_data, continent == "Oceania")

# Check the first few rows of one of the continent datasets to confirm
head(asia_data)


