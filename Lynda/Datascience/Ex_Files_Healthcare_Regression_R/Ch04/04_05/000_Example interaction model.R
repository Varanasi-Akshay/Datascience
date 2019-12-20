#read in analytic table

analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#Interaction Example
#Add black times age interaction

InteractionModel = lm(SLEPTIM2 ~ DRKMONTHLY + DRKWEEKLY + AGE3 + AGE4 + AGE5 + AGE6 
	+ HISPANIC + BLACK + ASIAN + OTHRACE + FORMERMAR + NEVERMAR
	+ LOWED + SOMECOLL + INC2 + INC7 
	+ OVWT + OBESE + SMOKER + FAIRHLTH + POORHLTH
	+ (BLACK*AGE3) + (BLACK*AGE4) + (BLACK*AGE5) + (BLACK*AGE6), data=analytic) 
summary(InteractionModel)