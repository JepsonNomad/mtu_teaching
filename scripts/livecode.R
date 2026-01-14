#### Code for 14 Jan
#### Identifying changes in Great Lakes Ice Cover

## Use historical daily ice cover data
## https://www.glerl.noaa.gov/data/ice/#historical

## Livecode lives here:
## https://github.com/JepsonNomad/mtu_teaching/blob/main/scripts/livecode.R
## also @ https://tinyurl.com/GreatLakesIceCover

lake_ice <- read.table("https://www.glerl.noaa.gov/data/ice/glicd/daily/sup.txt")

library(tidyverse)

lake_ice_long <- lake_ice %>%
  mutate(monthday = rownames(.)) %>%
  pivot_longer(-monthday) %>%
  mutate(snowYear = str_sub(name, 2, 5),
         snowYear = as.numeric(snowYear)) %>%
  separate(monthday, into = c("month", "monthDay")) %>%
  mutate(monthNum = match(month, month.abb)) %>%
  mutate(year = ifelse(monthNum > 6, 
                       snowYear - 1,
                       snowYear)) %>%
  mutate(date = lubridate::ymd(paste0(year, "-", month, "-", monthDay))) %>%
  filter(!is.na(date)) 
  
View(lake_ice_long)

lake_ice_long %>%
  filter(date == as.Date("2012-03-11"))
lake_ice_long %>%
  filter(date == as.Date("2014-03-11"))
