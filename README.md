## COVID CMS Nursing Home Data Shiny app (Capstone project - Data Science for Public Health)

### Link to live app
 (in progress)

### Description

This app was designed for a class project where the objective was to develop a Shiny app displaying outputs from a predictive model in a topic area of the student's choice. The outcome of interest is the number of reported shortages of any type of staff during the time period, May 31 2020 - December 31 2020. Predictor variables of interest include those that may be related to staff stress that could contribute to shortages, including PPE shortages and size of the facility. 

This app also provides detailed information on the origins of this particular dataset and caveats of using this dataset.

The purpose of this prediction model is to estimate the **extent of nursing home staff shortages** for different types of facilities, varied by inputs that include  **facility-reported PPE shortages,** **size of nursing home facilities (large or small) based on number of occupied beds**, and **burden of staff COVID-19 cases**. 


### Data

Data for this dashboard come from the [CMS COVID-19 Nursing Home Dataset](https://data.cms.gov/stories/s/COVID-19-Nursing-Home-Data/bkwz-xpvg/).

COVID data in long-term care facilities has been a devastating and complex story throughout the pandemic - another source of data for deaths and cases in nursing homes among both residents and staff can be found at the [COVID Tracking Project webpage](https://covidtracking.com/nursing-homes-long-term-care-facilities). This page also has excellent background information on how the datasets differ. For this project, the CMS data was used because it includes richer information about ongoing PPE and staffing shortages that were of interest for this question.  

### R packages 


+ **Interface:**  `flexdashboard`, `shiny`

+ **Data conversion & manipulation:** `dplyr`, `tidyr`








