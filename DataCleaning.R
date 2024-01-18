## load required libraries
library(tidyverse)
library(here)


###------------------------------------------------------------------------------
## cleaning the OECD database health care utilisation for diagnostic exams data
###------------------------------------------------------------------------------

# load the whole dataset
data_OECDHealthStat_raw_data = read.csv(here("data", "Diagnostic_exams_data.csv"))



# eyeballing the dataset

glimpse(data_OECDHealthStat_raw_data)
str(data_OECDHealthStat_raw_data)
summary(data_OECDHealthStat_raw_data)

# checking column names
colnames(data_OECDHealthStat_raw_data)


# checking head
head(data_OECDHealthStat_raw_data)

# checking if columns have NA values
colSums(is.na(data_OECDHealthStat_raw_data))


# checking unique variables in each column
unique(data_OECDHealthStat_raw_data$VAR)
unique(data_OECDHealthStat_raw_data$Variable)
unique(data_OECDHealthStat_raw_data$UNIT)
unique(data_OECDHealthStat_raw_data$Measure)
unique(data_OECDHealthStat_raw_data$Country)
unique(data_OECDHealthStat_raw_data$Flags)


#checking the VAR VARIABLE to figure out what each code refers to (please see notes below)

data_dump <- data_OECDHealthStat_raw_data %>% 
  filter(VAR == "DGTSPEHO")


###
# NOTES FOR VAR VARIABLE
# - DGTSCTEX  - Computed Tomography exams, total - units are different (NOMBRENB
# - for number, RTOINPNB - per 1000 population, PERMACNB - per scanner)
#
# - DGTSMREX - Magnetic Resonance Imaging exams, total - units same as above
#
# - DGTSCTHO - Computed Tomography exams, in hospitals
#
# - DGTSCTAM - Computed Tomography exams, in ambulatory care
#
# - DGTSMRHO - Magnetic Resonance Imaging exams, in hospitals
#
# - DGTSMRAM - Magnetic Resonance Imaging exams, in ambulatory care
#
# - DGTSPEEX - Positron Emission Tomography (PET) exams, total
#
# - DGTSPEAM - Positron Emission Tomography (PET) exams, in ambulatory care
#
# - DGTSPEHO - Positron Emission Tomography (PET) exams, in hospitals
#



# selecting the countries we want to set data for
selected_countries = c('Australia', 'United States', 'Lithuania' , 'Austria',
                       'Korea', 'Norway', 'Netherland', 'Denmark',
                       'France', 'Belgium', 'Italy', 'Romania')


# filtering the data according to countries, years & only totals, per scanner values
data_SelectedCountries <- data_OECDHealthStat_raw_data %>% 
  filter((Country %in% selected_countries) & (Year>=2017 & Year<2022) & !(UNIT %in% c("RTOINPNB", 'PERMACNB')))

#########
# making changes to the dataset 
####


# changing country name Korea to South Korea
data_SelectedCountries$Country[data_SelectedCountries$Country == 'Korea'] = "South Korea"

# changing the name of the some columns

colnames(data_SelectedCountries)[1] <- "Scan Type"
colnames(data_SelectedCountries)[2] <- "Total"

# converting Total column into factor and resetting levels

data_SelectedCountries$Total <- fct_collapse(data_SelectedCountries$"Scan Type",
                                           "Total exams" = c("DGTSCTEX","DGTSMREX","DGTSPEEX"),
                                           "Total exams in hospital" = c("DGTSCTHO","DGTSMRHO","DGTSPEHO"),
                                           "Total exams in ambulatory care" = c("DGTSCTAM","DGTSMRAM","DGTSPEAM"))

# converting VAR to factor and resetting the levels
data_SelectedCountries["Scan Type"] <- fct_collapse(data_SelectedCountries$"Scan Type",
                                           "CT EXAMS" = c("DGTSCTEX","DGTSCTHO","DGTSCTAM"),
                                           "MRI EXAMS" = c("DGTSMREX","DGTSMRHO","DGTSMRAM"),
                                           "PET EXAMS" = c("DGTSPEEX","DGTSPEHO","DGTSPEAM"))


is.factor(data_SelectedCountries$"Scan Type")



# dropping unnecessary columns

data_SelectedCountries <- subset(data_SelectedCountries, select = -c(UNIT, Measure, Flag.Codes, Flags))



# saving the data set to a csv file
write.csv(data_SelectedCountries, file = "data/DiagnosticExamsRawData.csv", row.names = FALSE )
