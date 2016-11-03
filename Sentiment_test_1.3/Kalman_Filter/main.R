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
source("analysis.r")
source("analysis_pos.r")
source("analysis_neg.r")
source("dataframe_manipulator.r")

## DATA LOADING ##
wheat<-read.csv("wheat_index_igc.csv")
df_original<-read.csv("df.csv",sep=';')
# Date conversion #
df_original <- timestamp_to_date(df_original)
wheat$date <- wheat_date(wheat)
#sentiment_threshold <- 0.2

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
analysis2010<-analysis(df,date1,date2,sentiment_threshold)