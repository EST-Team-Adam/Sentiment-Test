dataframe_aggregator <- function(df_original,date1,date2) {

wheat1 <- wheat[wheat$date >= date1 & wheat$date <= date2,]
df1<-df_original[df_original$date >= date1 & df_original$date <= date2,]
names <- colnames(df1)

df2 <- data.frame(aggregate(df1$neg ~ df1$date, data=df1, FUN=mean ),
                  aggregate(df1$neu ~ df1$date, data=df1, FUN=mean )[,2],
                  aggregate(df1$pos ~ df1$date, data=df1, FUN=mean )[,2],
                  aggregate(df1$compound ~ df1$date, data=df1, FUN=mean )[,2])
colnames(df2) <-  c(names[1] , names[5] , names[6] , names[7] , names[8])                  

return(df2)
}

dataframe_assembler <- function(df2,date1,date2, wheat) {

names <- colnames(df2)
df3 <- data.frame(semi_join(df2,wheat,by=names[1]) , semi_join(wheat,df2,by=names[1])[2]) 
wheat1 <- wheat[wheat$date >= date1 & wheat$date <= date2,]

return(df3)

}