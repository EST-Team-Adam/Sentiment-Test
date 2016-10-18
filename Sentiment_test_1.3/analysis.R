analysis <- function(df,date1,date2,sentiment_threshold) {

## MEMORY PRE-ALLOCATION & DATE ##
df_ret <- as.data.frame(matrix(nrow=dim(df)[1]-1,ncol=dim(df)[2]-1,NA))
colnames(df_ret) <- names(df[,2:dim(df)[2]])
analysis_p <- rep(list(NA),4)
names <- names(df)

## RETURNS ##
for (i in 2:dim(df)[2]) {
   df_ret[,i-1] <- diff(df[,i])/df[,i][-length(df[,i])]
}

analysis_p[[1]] <- df[df$compound >= sentiment_threshold | df$compound <= -sentiment_threshold,]
analysis_p[[2]] <- summary(df$compound)
analysis_p[[3]] <- var(df$compound)
analysis_p[[4]] <- skewness(df$compound)

## KALMAN FILTER TO SENTIMENT ##
filtered_sentiment <- kalman_filter(df)
filtered_sentiment_pos <- kalman_filter_pos(df)
filtered_sentiment_neg <- kalman_filter_neg(df)

## PLOTS ##
par(mfrow=c(3,1))
   plot(df$date,df$wheat,main="IGC Wheat Price Index",xlab="Observation", ylab=names[6],type="line")
     legend("topright",lty=c(1,1), lwd=c(2.5,2.5),col=c("black","red","blue"),legend= c("Price","LOESS","Filtered Sentiment"))
     lines(df$date,predict(loess.as(1:length(df$date), df$wheat, degree = 1, criterion = c("aicc", "gcv")[2], user.span = NULL), 1:length(df$date)),type="line",col="red")
   plot(density(df$compound),main="Compound Sentiment Density Distribution")
   plot(df$date,ts(filtered_sentiment[[1]]$att[1, ], start = start(filtered_sentiment[[2]]), frequency = frequency(filtered_sentiment[[2]])), col = "black",type="line")
     legend("bottomright",lty=c(1,1), lwd=c(2.5,2.5),col=c("black","blue","red"),legend= c("Compound Sentiment","Positive Sentiment","Negative Sentiment"))
     lines(df$date,ts(filtered_sentiment_pos[[1]]$att[1, ], start = start(filtered_sentiment_pos[[2]]), frequency = frequency(filtered_sentiment_pos[[2]])), col = "blue",type="line")
     lines(df$date,ts(filtered_sentiment_neg[[1]]$att[1, ], start = start(filtered_sentiment_neg[[2]]), frequency = frequency(filtered_sentiment_neg[[2]])), col = "red",type="line")
analysis_p[[5]] <- recordPlot()

par(mfrow=c(1,1))
   plot(df$compound[2:length(df$wheat)],df_ret$wheat,main="Returns and Compound Sentiment Linear Model",xlab="Sentiment", ylab="Returns")
    abline(lm(df_ret$wheat ~ df$compound[2:length(df$wheat)]),col="red")
analysis_p[[6]] <- recordPlot()

return(analysis_p)
}

