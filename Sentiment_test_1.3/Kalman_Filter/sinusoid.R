## KALMAN FILTER SINUSOID ##

library(FKF)
source('kalman_filter.r')

### Equation: y=a*sin(b*t)+c.norm*amp
# variables
n <- 100 # number of data points
t <- seq(0,4*pi,,100)
a <- 3
b <- 2
c.norm <- rnorm(n)
amp <- 2

# generate data and calculate "y"
set.seed(1)
y <- a*sin(b*t)+c.norm*amp # Gaussian/normal error

# plot results
plot(t, y, t="l", ylim=range(y)*c(1,1.2))

y <- y
filtered_sentiment <- kalman_filter(y)
plot(t, y, ylim=range(y)*c(1,1.2), main = 'Noisy sinusoid function with Gaussian generated errors', ylab = 'y', xlab = 'x')
lines(t,ts(filtered_sentiment[[1]]$att[1, ], start = start(filtered_sentiment[[2]]), frequency = frequency(filtered_sentiment[[2]])), col = "red",type="line")
