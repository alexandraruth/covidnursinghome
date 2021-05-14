## read in CMS nursing home COVID csv file

library(tidyverse)
library(dplyr)
library(lubridate)

cms = read_csv("nursinghome.csv")


## convert date strings to "Date" variable in R

cms = 
  cms %>% 
    mutate(date_conversion=mdy(`Week Ending`))  # parses date string

## subset just November 1 - December 31


## arrange truncated dataset by date and facility

cms_novdec = 
  subset(cms, date_conversion > "2020-11-01" & date_conversion < "2020-12-31") %>%
  arrange(`Provider State`) %>%
  arrange(`Federal Provider Number`) %>%
  arrange(date_conversion) %>%
  mutate(ppe=0) %>%
  mutate(staff=0) 
  



## create PPE shortage variable


## create deaths variable


## create facility size variable


## plot deaths as function of 
 
  
