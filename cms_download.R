


##### Step 1: Read in CMS nursing home COVID csv file ##### 

setwd("~/Documents/GitHub/covidnursinghome")

library(tidyverse)
library(dplyr)
library(lubridate)
library(tidyr)
library(knitr)

cms = read_csv("nursinghome.csv") 
### csv above has been downloaded from https://data.cms.gov/stories/s/COVID-19-Nursing-Home-Data/bkwz-xpvg/


##### Step 2: Wrangle data #####


## subset by date & arrange ##

cms_subset = 
  cms %>%
  mutate(date_conversion=mdy(`Week Ending`)) %>%
  subset(date_conversion > "2020-05-31" & date_conversion < "2020-12-31") %>%
  arrange(`Provider State`) %>%
  arrange(date_conversion) %>%
  arrange(`Federal Provider Number`) 
  
## filter necessary variables ## 

cms_subset = 
  cms_subset %>% 
  select(date_conversion, `Week Ending`, `Federal Provider Number`, `Provider Name`, `Provider Address`, `Provider City`, `Provider State`, `Provider Zip Code`, `Submitted Data`, `Passed Quality Assurance Check`, `Total Resident COVID-19 Deaths Per 1,000 Residents`, `Staff Total COVID-19 Deaths`, `Residents Total Confirmed COVID-19`, `Staff Total Confirmed COVID-19`, `Number of All Beds`, `Total Number of Occupied Beds`, `Shortage of Nursing Staff`, `Shortage of Clinical Staff`, `Shortage of Aides`, `Shortage of Other Staff`, `Any Current Supply of N95 Masks`, `Any Current Supply of Surgical Masks`, `Any Current Supply of Eye Protection`, `Any Current Supply of Gowns`, `Any Current Supply of Gloves`, `Any Current Supply of Hand Sanitizer`, `One-Week Supply of N95 Masks`, `One-Week Supply of Surgical Masks`, `One-Week Supply of Eye Protection`, `One-Week Supply of Gowns`, `One-Week Supply of Gloves`, `One-Week Supply of Hand Sanitizer`) 

## create PPE shortage variable for each row

cms_subset = cms_subset %>%
  mutate(shortage_ppe = ifelse(`Any Current Supply of N95 Masks` == "Y" | `Any Current Supply of Surgical Masks` == "Y" | `Any Current Supply of Eye Protection` =="Y" | `Any Current Supply of Gowns` == "Y" | `Any Current Supply of Gloves` =="Y" | `Any Current Supply of Hand Sanitizer`=="Y" | `One-Week Supply of N95 Masks`=="Y" | `One-Week Supply of Surgical Masks` =="Y" | `One-Week Supply of Eye Protection`=="Y" | `One-Week Supply of Gowns` =="Y" | `One-Week Supply of Gloves` =="Y" | `One-Week Supply of Hand Sanitizer`=="Y",0,1)) 
 
summary(cms_subset$shortage_ppe)

## create staff shortage variable for each row

cms_subset = cms_subset %>%
  mutate(shortage_staff = ifelse(`Shortage of Nursing Staff`=="Y" | `Shortage of Clinical Staff`=="Y" | `Shortage of Aides`=="Y" | `Shortage of Other Staff`=="Y",0,1)) 
 
summary(cms_subset$shortage_staff)

## create facility size variable (facility_size)

cms_subset = cms_subset %>%
  mutate(facility_size = as.factor(ifelse(`Number of All Beds` >= 100, 2, 1)) )

write.csv(cms_subset,'cms_subset.csv')
  
## SHORTAGES: create shortages table with one row for each facility ##

cms_shortages = cms_subset %>% 
  group_by(`Federal Provider Number`) %>%
  summarise(facility_size, allshortages_ppe =sum(shortage_ppe) , allshortages_staff = sum(shortage_staff), `Provider State`, max_totstaffcases = max(`Staff Total Confirmed COVID-19`))
  
cms_shortages = cms_shortages[complete.cases(cms_shortages), ] ## removes NA rows

cms_shortages = distinct(cms_shortages, .keep_all=TRUE)  ## removes duplicate rows

cms_shortages = cms_shortages %>%
  mutate(anyshortage_staff = as.factor(ifelse(allshortages_staff>0, 1, 0))) %>%
  mutate(anyshortage_ppe = as.factor(ifelse(allshortages_ppe>0, 1, 0)))

write.csv(cms_shortages, 'cms_shortages.csv')

## DEATHS: create deaths table for each state ##


 
  
#### Step 3: Test plots ####

mlr_model = lm(allshortages_staff ~ anyshortage_ppe + facility_size + max_totstaffcases, data = cms_shortages)
summary(mlr_model)

predict(mlr_model, data.frame(anyshortage_ppe = as.factor(1), facility_size = as.factor(2), max_totstaffcases = 20))


log_model = glm(anyshortage_staff ~ anyshortage_ppe + facility_size + max_totstaffcases, family = "binomial", data = cms_shortages)
summary(log_model)

predict(log_model, data.frame(anyshortage_ppe = as.factor(1), facility_size = as.factor(2), max_totstaffcases = 20))


#### Step 4: Save csv and push cleaned data to github ####



