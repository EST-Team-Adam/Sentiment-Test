# Sentiment-Test
Analysis aim is to deliver initial evidences on sentiment and prices relation.
This folder will be updated as the research goes on.

## Data
Data used are International Grains Council daily Wheat series and the sentiment matrix obtained using main.py script (tested on Python 2.7).

## Version History
- **1.0** : Unlabeled sentiment and 2010-2015 prices comparison. Whole analysis is available in "readme.pdf" file.

#### _1.0_
R script relies on "*dplyr*", "*fANCOVA*" and "*moments*" packages and it's composed by three parts: **main.r**, **df_date.r**, **dataframe_manipulator.r** and **analysis.r**.

Script "**main.r**" is the main script where R loads the original wheat price series ("wheat_index_igc.csv") and the unlabeled sentiment matrix ("df.csv" from main.py). 
Once data are loaded, 5 analyses are run: the first one is relative to the whole 2010-2015 time interval, then 2010, 2011, 2012 and 2015 windows are separately analized.
It's possible for testing purposes to change the analyses time window by changing *date1* and *date2* parameters as it's possible to select the sentiment threshold parameter, registered as sentiment_threshold.

Function "**df_date.r**" is a function that just converts Sentiment matrix item timestamp into a date.

Functions contained into "**dataframe_manipulator.r**", namely "_*dataframe_aggregator*_" and "_*dataframe_assembler*_", aggregate sentiment into daily sentiment observations,
then build a time consistent dataframe of wheat price and sentiment observations.

Function "**analysis.r**" computes wheat index returns and performs an analysis on the time consistent data frame. The analysis is composed of a list of outliers (depending on chosen sentiment threshold, default -0.2 and +0.2),
a compound sentiment R summary, compound sentiment variance and skewness, plots the IGC Wheat Index and a LOESS regression, plots compound sentiment density and delivers a compound sentiment  and wheat index returns scatter-plot.

Analysis results are accessible by typing: 
- *analysis_whole[[k]]* : 2010-2015 window.
- *analysis2010[[k]]* : 2010/07/03 - 2011-03-03 window.
- *analysis2011[[k]]* : 2011/05/28 - 2011-10-03 window.
- *analysis2012[[k]]* : 2012/06/15 - 2012/10/03 window.
- *analysis2015[[k]]* : 2015/01/03 - 2015/06/03 window.

*k* defines performed analysis type and it can take the following values:
- *1* : Outstanding the sentiment threshold.
- *2* : Compound sentiment R summary.
- *3* : Compound sentiment variance.
- *4* : Compound sentiment skewness.
- *5* : IGC daily Wheat Index plot, LOESS regression and compound sentiment density. 
- *6* : IGC daily Wheat Index returns and compound sentiment scatter-plot.