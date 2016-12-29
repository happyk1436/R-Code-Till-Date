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

str(spotfreight)
summary(spotfreight)


str(regionlookups)
summary(regionlookups)
write.csv(regionlookups)


str(marketzips)
summary(marketzips)
write.csv(marketzips)


str(equipmentcodes)
summary(equipmentcodes)
write.csv(equipmentcodes)



# Preprocessing the data
sum(is.na(spotfreight)) # checks for any rows with NA in the spotfreight data
spotfreight <- na.omit(spotfreight) # removes all the rows with NA in one or more columns
summary(complete.cases(spotfreight))# checks if any of the rows has NAs in any of its columns of the spotfreight data

cat("Total orders count : " , length(spotfreight$ORDER_NBR))
cat("Unique orders count : " , n_distinct(spotfreight$ORDER_NBR))

# There are multiple rows for the same data (like order_number with slight difference in zip, appt, etc...)

# remove duplicate records (ignoring the "CREATED_DATE" field)
spotfreight_unq <- spotfreight[!duplicated(spotfreight[,!(colnames(spotfreight) %in% c("CREATED_DATE"))]), ]

# removes space and - characters from both FIRST_PICK_ZIP & LAST_DELIVERY_ZIP columns
spotfreight$FIRST_PICK_ZIP <- gsub("[ -]", "", spotfreight$FIRST_PICK_ZIP) 
spotfreight$LAST_DELIVERY_ZIP <- gsub("[ -]", "", spotfreight$LAST_DELIVERY_ZIP)

# remove records with alphanumeric zip codes either in FIRST_PICK_ZIP or LAST_DELIVERY_ZIP or both
check.numeric <- function(N){ !length(grep("[^[:digit:]]", as.character(N)))}
spotfreight <- spotfreight[sapply(spotfreight$FIRST_PICK_ZIP, check.numeric) & sapply(spotfreight$LAST_DELIVERY_ZIP, check.numeric),] 

# check & remove records with zero values in ORDER_COST field (the target variable)
summary(spotfreight$ORDER_COST)
