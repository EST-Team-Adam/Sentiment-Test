##Kalman Filter##

The aim of the research is to to test Kalman Filter efficiency in sentiment noise removal, giving a quantitative resume of the algorithm and 
a qualitative interpretation to the Gaussian error assumption in a sentiment context.

Kalman Filter has been chosen for this test because it has been widened used in previous research papers regarding sentiment.

An extensive research on the topic can be found in the file file *Kalman_Filter_Sentiment.pdf* .

###R scripts###

The research uses two scripts, which rely on _FKF_ R package:

1) _sinusoid.r_ : the script simulates a *sin* noisy function, where noise is Gaussian. Once 100 observations are simulated, Kalman Filter 
is used to plot the process that generated the observed measurements.

2) _main.r_ : the script builds a dataset containing 9 months of daily VADER extracted sentiment scores across the years 2010-2011 and applies
Kalman Filter in order to plot the unobserved sentiment process generating the noisy sentiment observation.

###Conclusion###
As shown in the research, Kalman Filter gives back a series mirroring the unobserved sentiment process hidden behind the noisy observed 
sentiment measurements. Such series may be used to study sentiment correlation and Granger causality with other price series.
