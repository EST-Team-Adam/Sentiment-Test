## PACKAGES ##
library(dplyr)
library(fANCOVA)
library(moments)
library(FKF)

## CLEAR ALL ##
rm(list=ls())
gc()
source("df_date.r")
source("kalman_filter.r")
source("dataframe_manipulator.r")

## DATA LOADING ##
wheat<-read.csv("wheat_index_igc.csv")
df_original<-read.csv("df.csv",sep=';')
# Date conversion #
df_original <- timestamp_to_date(df_original)
wheat$date <- wheat_date(wheat)
#sentiment_threshold <- 0.2

# Needed for converting compound sentiment to numeric from factor
df_original$compound <- as.numeric(levels(df_original$compound))[df_original$compound]

## WHOLE DATA SET ANALYSIS ##
date1 <- as.Date("2009-07-03")
date2 <- as.Date("2016-01-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)

# 2010
date1 <- as.Date("2010-07-03")
date2 <- as.Date("2011-03-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)

## KALMAN FILTER ##

y <- df$compound
filtered_sentiment <- kalman_filter(y)
plot(df$date,y)
    lines(df$date,ts(filtered_sentiment[[1]]$att[1, ], start = start(filtered_sentiment[[2]]), frequency = frequency(filtered_sentiment[[2]])), col = "red",type="line")
