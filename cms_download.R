


##### Step 1: Read in CMS nursing home COVID csv file ##### 

library(tidyverse)
library(dplyr)
library(lubridate)

cms = read_csv("nursinghome.csv")


##### Step 2: Wrangle data #####

## date conversion ##

cms = 
  cms %>% 
    mutate(date_conversion=mdy(`Week Ending`)) 


## subset by date & arrange ##

cms_testset = 
  subset(cms, date_conversion > "2020-05-31" & date_conversion < "2020-12-31") %>%
  arrange(`Provider State`) %>%
  arrange(date_conversion) %>%
  arrange(`Federal Provider Number`) 
 
## filter necessary variables ## 

cms_testset = 
  cms_testset %>% 
  select(date_conversion, `Week Ending`, `Federal Provider Number`, `Provider Name`, `Provider Address`, `Provider City`, `Provider State`, `Provider Zip Code`, `Submitted Data`, `Passed Quality Assurance Check`, `Total Resident COVID-19 Deaths Per 1,000 Residents`, `Staff Total COVID-19 Deaths`, `Residents Total Confirmed COVID-19`, `Staff Total Confirmed COVID-19`, `Number of All Beds`, `Total Number of Occupied Beds`, `Shortage of Nursing Staff`, `Shortage of Clinical Staff`, `Shortage of Aides`, `Shortage of Other Staff`, `Any Current Supply of N95 Masks`, `Any Current Supply of Surgical Masks`, `Any Current Supply of Eye Protection`, `Any Current Supply of Gowns`, `Any Current Supply of Gloves`, `Any Current Supply of Hand Sanitizer`, `One-Week Supply of N95 Masks`, `One-Week Supply of Surgical Masks`, `One-Week Supply of Eye Protection`, `One-Week Supply of Gowns`, `One-Week Supply of Gloves`, `One-Week Supply of Hand Sanitizer`) 


## create PPE shortage variable

if (cms$`Shortage of Aides` == 'Y')

## create staff shortage variable (shortage_ppe)



## create facility size variable (facility_size)


  
  

#### Step 3: Test plots ####

mymodel = glm(formula = shortage_staff ~ shortage_ppe + facility_size +  family = "binomial", data = cms_testset)
summary(mymodel)



#### Step 4: Save and push cleaned data to github ####





