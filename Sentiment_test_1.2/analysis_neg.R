analysis_neg <- function(df,date1,date2,sentiment_threshold) {

## MEMORY PRE-ALLOCATION & DATE ##
df_ret <- as.data.frame(matrix(nrow=dim(df)[1]-1,ncol=dim(df)[2]-1,NA))
colnames(df_ret) <- names(df[,2:dim(df)[2]])
analysis_p <- rep(list(NA),4)
names <- names(df)

## RETURNS ##
for (i in 2:dim(df)[2]) {
   df_ret[,i-1] <- diff(df[,i])/df[,i][-length(df[,i])]
}

analysis_p[[1]] <- df[df$neg >= sentiment_threshold | df$neg <= -sentiment_threshold,]
analysis_p[[2]] <- summary(df$neg)
analysis_p[[3]] <- var(df$neg)
analysis_p[[4]] <- skewness(df$neg)

## PLOTS ##
par(mfrow=c(2,1))
   plot(df$date,df$wheat,main="IGC Wheat Price Index",xlab="Observation", ylab=names[6],type="line")
     legend("topright",lty=c(1,1), lwd=c(2.5,2.5),col=c("black","red"),legend= c("Price","LOESS"))
     lines(df$date,predict(loess.as(1:length(df$date), df$wheat, degree = 1, criterion = c("aicc", "gcv")[2], user.span = NULL), 1:length(df$date)),type="line",col="red")
plot(density(df$neg),main="Negative Sentiment Density Distribution")
analysis_p[[5]] <- recordPlot()

par(mfrow=c(1,1))
   plot(df$neg[2:length(df$wheat)],df_ret$wheat,main="Returns and Negative Sentiment Linear Model",xlab="Sentiment", ylab="Returns")
    abline(lm(df_ret$wheat ~ df$neg[2:length(df$wheat)]),col="red")
analysis_p[[6]] <- recordPlot()

return(analysis_p)
}

