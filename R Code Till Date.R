setwd("/Users/karnati/Google Drive/Freight Mnagement")

# Reads all Data
spotfreight <- read.csv("/Users/karnati/Google Drive/QuickFreight 3/spotfreightdata.csv",header=T, na.strings = c("","NA"," "))
regionlookups <- read.csv("/Users/karnati/Google Drive/QuickFreight 3/regionlookups.csv",header=T, na.strings = c("","NA"," "))
marketzips <- read.csv("/Users/karnati/Google Drive/QuickFreight 3/marketzips.csv",header=T, na.strings = c("","NA"," "))
equipmentcodes <- read.csv("/Users/karnati/Google Drive/QuickFreight 3/equipmentcodes.csv",header=T, na.strings = c("","NA"," "))
# spotfreight (37699 obs)
# regionlookups (906 obs)
# marketzips  (905 obs)
# equipmentcodes  (292 obs)

library(dplyr)
library(lubridate)
library(plyr)


str(equipmentcodes)
summary(equipmentcodes)

# Preprocessing the data
sum(is.na(spotfreight)) # checks for any rows with NA in the spotfreight data
spotfreight <- na.omit(spotfreight) # removes all the rows with NA in one or more columns
sum(is.na(spotfreight)) # checks for any rows with NA in the spotfreight data = 5620 na's 
spotfreight <- na.omit(spotfreight) # removes all the rows with NA in one or more columns =  34693 records 
summary(complete.cases(spotfreight)) # checks if any of the rows has NAs in any of its columns of the spotfreight data


-92,10 +92,18 arrange(summarise(group_by(spotfreight, CUSTOMER_MILES), orders = n()), desc(-CU
