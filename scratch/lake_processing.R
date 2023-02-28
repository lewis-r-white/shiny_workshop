# load packages ----
library(tidyverse)
library(leaflet)

# read in the data ----
lake_monitoring_data <- read_csv("raw_data/FCWO_lakemonitoringdata_2011_2022_daily.csv")

#calculate averages ----
avg_depth_temp <- lake_monitoring_data %>%
  select(Site, Depth, BedTemperature) %>%
  filter(Depth != "NaN") %>%
  drop_na(BedTemperature) %>%
  group_by(Site) %>%
  summarise(avg_depth = round(mean(Depth), 1),
            avg_temp = round(mean(BedTemperature), 1))


# join the averages to original lake monitoring data ----
lake_monitoring_data <- full_join(lake_monitoring_data, avg_depth_temp)

unique_lakes <- lake_monitoring_data %>%
  select(Site, Latitude, Longitude, Elevation, avg_depth, avg_temp) %>%
  distinct()


write_csv(unique_lakes, "shiny-dashboard/data/lake_data_processed.csv")

