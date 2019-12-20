#read in analytic table

analytic <- read.csv(file="C:/Users/Monka Wahi/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#Normal probability plot
#make linear model using grouping variable

AlcSleepTimeRegression = lm(SLEPTIM2 ~ ALCGRP, data=analytic) 

AlcSleepTimeRegression 

summary(AlcSleepTimeRegression)

#Make diagnostic plots

layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(AlcSleepTimeRegression, 
	main = "Alcohol by Sleep Duration")

