Lyric Smith
Descriptive Statistics: using given flight data
10-10-15

#Install Tools
library(moments)
library(dplyr)
library(DBI)
library(plotrix)

#Load db 
if(exists("flightsdb")){
  soure("connectDB.R")
}

#run descreptive statistics for Month, Year, and Arrival Delay grouped by Month
flights = read.csv("extract//On_Time_On_Time_Performance_2011_1.csv", stringsAsFactor = FALSE)
flight.1.desc = flight.1 %>% 
  select(Year, Month, ArrDelay) %>%
  filter(Year == 2011) %>%
  group_by (Month) %>%
  summarise (
    count = n(),
    sum = sum(ArrDelay, na.rm=TRUE),
    min = min(ArrDelay, na.rm=TRUE),
    max = max(ArrDelay, na.rm=TRUE),
    mean = mean(ArrDelay, na.rm=TRUE),
    median = median(ArrDelay, na.rm=TRUE),
    range = max-min,
    sd = sd(ArrDelay, na.rm=TRUE),
    var = var(ArrDelay, na.rm=TRUE),
    se = std.error(ArrDelay, na.rm=TRUE),
    kurt = kurtosis(ArrDelay, na.rm=TRUE),
    skew = skewness(ArrDelay, na.rm=TRUE))

#na.rm removes all NA values from data making it so that the calculations can acutally be taken

con <- dbConnect(RPostgreSQL::PostgreSQL(),
                 dbname = 'flightsdb',
                 host = 'localhost',
                 port = 5432,
                 user = 'lsmith18')

flights.db = src_postgres (dbname = "flightdb", host = "localhost", port = 5432, user="lsmith18")

View(flights.descriptive)

flights <- tbl(flightsdb,"connections")
flights %>% filter(Year == 2011)

# Based off the descriptive statistics shown the mean for the months of November and December have a higher 
chance of arrival delays proving that the months are ones in which you would rather not travel. However on 
average there is not much variance within the arrival delays of flights many are one time or even under
time most of the time, and there are actually pretty high kirtosis due to the fact that for all the months
the flight times pretty well centered aroun the mean. 