#read in analytic table

analytic <- read.csv(file="D:/Dropbox/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

summary(Model2)

#Start with Model 2 with the not significant covariates removed

Model3 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6, data=analytic) 
summary(Model3) 

#add smoker

Model4 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER, data=analytic) 
summary(Model4) 

#smoker is significant
#add Hispanic

Model5 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC, data=analytic) 
summary(Model5) 

#Hispanic significant
#add race

Model6 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE, data=analytic) 
summary(Model6) 

#Race vars significant
#marital status

Model7 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR, data=analytic) 
summary(Model7)

#Marital significant
#Gen health

Model8 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH, data=analytic) 
summary(Model8)

#Gen Hlth significant
#health plan

Model9 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + NOPLAN, data=analytic) 
summary(Model9)

#take out NOPLAN
#try education

Model10 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + LOWED + SOMECOLL, data=analytic) 
summary(Model10)

#take out LOWED

Model11 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL, data=analytic) 
summary(Model11)

#add income

Model12 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC1 + INC2 + INC3 + INC4 + INC5 + INC6 + INC7, data=analytic) 
summary(Model12)

#remove insignificant income variables

Model13 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7, data=analytic) 
summary(Model13)

#add BMI

Model14 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + UNDWT + OVWT + OBESE, data=analytic) 
summary(Model14)

#take out UNDWT

Model15 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE, data=analytic) 
summary(Model15)

#add exercise

Model16 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + NOEXER, data=analytic) 
summary(Model16)

#take out noexer
#add back male

Model17 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + MALE, data=analytic) 
summary(Model17)

#take out male
#add back AGE2 and AGE3

Model18 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE2 + AGE3, data=analytic) 
summary(Model18)

#remove AGE2

Model19 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3, data=analytic) 
summary(Model19)

#add back UNDWT

Model20 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + UNDWT, data=analytic) 
summary(Model20)

#remove UNDWT
#add back LOWED

Model21 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED, data=analytic) 
summary(Model21)

#Model21 is working final model

#add back NOEXER

Model22 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + NOEXER, data=analytic) 
summary(Model22)

#screws up LOWED
#remove NOEXER
#add back NOPLAN

Model23 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + NOPLAN, data=analytic) 
summary(Model23)

#remove NOPLAN
#add back AGE2

Model24 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + AGE2, data=analytic) 
summary(Model24)

#remove AGE2
#add back INC1

Model25 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + INC1, data=analytic) 
summary(Model25)

#remove INC1
#add back INC3

Model26 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + INC3, data=analytic) 
summary(Model26)

#remove INC3
#add back INC4

Model27 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + INC4, data=analytic) 
summary(Model27)

#remove INC4
#add back INC5

Model28 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + INC5, data=analytic) 
summary(Model28)

#remove INC5
#add back INC6

Model29 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + INC6, data=analytic) 
summary(Model29)

#remove INC6
#add back MALE

Model30 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + AGE3 + LOWED + MALE, data=analytic) 
summary(Model30)

Model31 = lm(SLEPTIM2 ~ DRKWEEKLY + AGE3 + AGE4 + AGE5 + AGE6 
	+ SMOKER + HISPANIC + BLACK + ASIAN + OTHRACE + NEVERMAR + FORMERMAR
	+ FAIRHLTH + POORHLTH + LOWED + SOMECOLL
	+ INC2 + INC7 + OVWT + OBESE + DRKMONTHLY, data=analytic) 
summary(Model31)

###FINAL MODEL

FinalLinearRegressionModel = lm(SLEPTIM2 ~ DRKMONTHLY + DRKWEEKLY + AGE3 + AGE4 + AGE5 + AGE6 
	+ HISPANIC + BLACK + ASIAN + OTHRACE + FORMERMAR + NEVERMAR
	+ LOWED + SOMECOLL + INC2 + INC7 
	+ OVWT + OBESE + SMOKER + FAIRHLTH + POORHLTH, data=analytic) 
summary(FinalLinearRegressionModel)

#output as CSV

library (devtools)
library (broom)

Tidy_FinalModel <- tidy(FinalLinearRegressionModel)
write.csv(Tidy_FinalModel, file = "FinalLinearRegressionModel.csv")

#coefficient plot

library(arm)

#default plot

coefplot(FinalLinearRegressionModel)

#Final model diagnostics

layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(FinalLinearRegressionModel, 
	main = "Final Linear Regression Model")

#Model fit diagnostics

library(gvlma)
gvmodel <- gvlma(FinalLinearRegressionModel) 
summary(gvmodel)










