## KALMAN FILTER SINUSOID ##

### Equation: y=a*sin(b*t)+c.unif*amp
# variables
n <- 100 # number of data points
t <- seq(0,4*pi,,100)
a <- 3
b <- 2
c.norm <- rnorm(n)
amp <- 2

# generate data and calculate "y"
set.seed(1)
y2 <- a*sin(b*t)+c.norm*amp # Gaussian/normal error

# plot results
plot(t, y2, t="l", ylim=range(y2)*c(1,1.2))
legend("top", legend=c("y2"), col=1:2, lty=1, ncol=2, bty="n")

y <- y2
filtered_sentiment <- kalman_filter(y)
plot(t, y2, ylim=range(y2)*c(1,1.2))
lines(t,ts(filtered_sentiment[[1]]$att[1, ], start = start(filtered_sentiment[[2]]), frequency = frequency(filtered_sentiment[[2]])), col = "red",type="line")
