#read in analytic table

analytic <- read.csv(file="C:/Users/Monka Wahi/Analytics/Data/analytic.csv", header=TRUE, sep=",")ic.csv", header=TRUE, sep=",")

#Look at distribution of sleep duration 

#summary statistics

summary(analytic$SLEPTIM2)

#look at histogram and box plot of total file

hist(analytic$SLEPTIM2, 
	main = "Histogram of SLEPTIM2",
	xlab = "Class SLEPTIM2",
	ylab = "Frequency",
	xlim=c(0,15), 
	ylim=c(0,20000),
	border = "red",
	col= "yellow",
	las = 1,
	breaks = 24)

boxplot(analytic$SLEPTIM2, main="Box Plot of SLEPTIM2", 
  	xlab="Total File", ylab="SLEPTIM2")

#See box plots of groups next to each other

boxplot(SLEPTIM2~ALCGRP, data=analytic, main="Box Plot of SLEPTIM2 by ALCGRP", 
  	xlab="ALCGRP", ylab="SLEPTIM2")


