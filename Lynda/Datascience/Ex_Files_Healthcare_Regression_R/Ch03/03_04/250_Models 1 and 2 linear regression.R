#read in analytic table

analytic <- read.csv(file="D:/Dropbox/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#make Model 1

Model1 = lm(SLEPTIM2 ~ DRKMONTHLY + DRKWEEKLY, data=analytic) 

summary(Model1)

library (devtools)
library (broom)

Tidy_Model1 <- tidy(Model1)
write.csv(Tidy_Model1, file = "LinearRegressionModel1.csv")

#make Model 2

Model2 = lm(SLEPTIM2 ~ DRKMONTHLY + DRKWEEKLY + MALE + AGE2 + AGE3 + AGE4 + AGE5 + AGE6, data=analytic) 
summary(Model2) 

Tidy_Model2 <- tidy(Model2)
write.csv(Tidy_Model2, file = "LinearRegressionModel2.csv")





