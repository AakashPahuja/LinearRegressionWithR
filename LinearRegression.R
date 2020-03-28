bike <- read.csv('bikeshare.csv')

head(bike)

library(ggplot2)
ggplot(bike,aes(temp,count)) + geom_point(alpha=0.2, aes(color=temp)) + theme_bw()

bike$datetime <- as.POSIXct(bike$datetime)

ggplot(bike,aes(datetime,count)) + geom_point(aes(color=temp),alpha=0.5)  + scale_color_continuous(low='#55D8CE',high='#FF6E2E') +theme_bw()

cor(bike[,c('temp','count')])

ggplot(bike,aes(factor(season),count)) + geom_boxplot(aes(color=factor(season))) +theme_bw()

bike$hour <- sapply(bike$datetime,function(x){format(x,"%H")})

head(bike)

library(dplyr)

pl <- ggplot(filter(bike,workingday==1),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.5)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()

pl <- ggplot(filter(bike,workingday==0),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.8)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()

temp.model <- lm(count~temp,bike)

summary(temp.model)

temp.test <- data.frame(temp=c(25))
predict(temp.model,temp.test)

bike$hour <- sapply(bike$hour,as.numeric)

model <- lm(count ~ . -casual - registered -datetime -atemp,bike )

summary(model)

