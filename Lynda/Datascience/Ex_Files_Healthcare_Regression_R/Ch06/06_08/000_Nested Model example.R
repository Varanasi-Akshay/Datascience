#read in analytic table

analytic <- read.csv(file="D:/Dropbox/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#example for lecture on ORs

ExampleModel1 <- glm(ASTHMA4 ~ SMOKER + OVWT + OBESE, data=analytic, family = "binomial") 
summary(ExampleModel1)

#example for model fit

ExampleModel2 <- glm(ASTHMA4 ~ SMOKER + OVWT + OBESE + SLEPTIM2, data=analytic, family = "binomial") 
summary(ExampleModel2)

#look at SLEPTIM2

summary(analytic$SLEPTIM2)
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

#let's do tertiles

SleepTertiles <- quantile(analytic$SLEPTIM2, probs = c(0, 0.33, 0.66, 1))

analytic$STertile <- 1
analytic$STertile[analytic$SLEPTIM2 >=7 & analytic$SLEPTIM2 < 8] <- 2
analytic$STertile[analytic$SLEPTIM2 >=8] <- 3
table(analytic$SLEPTIM2, analytic$STertile)

#make indicator variables

analytic$STERT1 <- 0
analytic$STERT1[analytic$STertile == 1] <- 1
table(analytic$STertile, analytic$STERT1)

analytic$STERT2 <- 0
analytic$STERT2[analytic$STertile == 2] <- 1
table(analytic$STertile, analytic$STERT2)

#example of nested models

#Model1 is nested in Model2 - above

#Model1 is nested in Model3

ExampleModel3 <- glm(ASTHMA4 ~ SMOKER + OVWT + OBESE + STERT1 + STERT2, data=analytic, family = "binomial") 
summary(ExampleModel3)

#get the log likelihoods

library(nlme)

logLik(ExampleModel1)
logLik(ExampleModel2)
logLik(ExampleModel3)



