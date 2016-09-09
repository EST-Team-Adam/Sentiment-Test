## PACKAGES ##
library(dplyr)
library(fANCOVA)
library(moments)

## CLEAR ALL ##
rm(list=ls())
gc()
source("df_date.r")
source("analysis.r")
source("dataframe_manipulator.r")

## DATA LOADING ##
wheat<-read.csv("wheat_index_igc.csv")
df_original<-read.csv("df.csv",sep=';')
# Date conversion #
df_original <- timestamp_to_date(df_original)
wheat$date <- wheat_date(wheat)
sentiment_threshold <- 0.2

## WHOLE DATA SET ANALYSIS ##
date1 <- as.Date("2009-07-03")
date2 <- as.Date("2016-01-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)
analysis_whole<-analysis(df,date1,date2,sentiment_threshold)


## 2010-2015 COMPARISONS ##
# 2010
date1 <- as.Date("2010-07-03")
date2 <- as.Date("2011-03-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)
analysis2010<-analysis(df,date1,date2,sentiment_threshold)
# 2011
date1 <- as.Date("2011-05-28")
date2 <- as.Date("2011-10-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)
analysis2011<-analysis(df,date1,date2,sentiment_threshold)

# 2012
date1 <- as.Date("2012-06-15")
date2 <- as.Date("2012-10-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)
analysis2012<-analysis(df,date1,date2,sentiment_threshold)
mean(df$compound[-59])
median(df$compound[-59])
var(df$compound[-59])
skewness(df$compound[-59])

# 2015
date1 <- as.Date("2015-01-03")
date2 <- as.Date("2015-06-03")
df2 <- dataframe_aggregator(df_original,date1,date2)
df <- dataframe_assembler(df2,date1,date2, wheat)
analysis2015<-analysis(df,date1,date2,sentiment_threshold)
