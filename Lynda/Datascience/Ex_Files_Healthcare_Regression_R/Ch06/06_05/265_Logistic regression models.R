#read in analytic table

analytic <- read.csv(file="D:/Dropbox/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#read in analytic table

#Model 3 is everything significant in Model2

LogModel3 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE, data=analytic, family = "binomial") 
summary(LogModel3)

#add smoker

LogModel4 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER, data=analytic, family = "binomial") 
summary(LogModel4)

#Keep smoker
#add Hispanic

LogModel5 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER + HISPANIC, data=analytic, family = "binomial") 
summary(LogModel5)

#remove Hispanic
#add races

LogModel6 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ BLACK + ASIAN + OTHRACE, data=analytic, family = "binomial") 
summary(LogModel6)

#keep only OTHRACE

LogModel7 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE, data=analytic, family = "binomial") 
summary(LogModel7)

#add marital

LogModel8 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FORMERMAR, data=analytic, family = "binomial") 
summary(LogModel8)

#keep marital
#add generalhealth

LogModel9 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FORMERMAR + FAIRHLTH + POORHLTH, data=analytic, family = "binomial") 
summary(LogModel9)

#now FORMERMAR not sig
#take out FORMERMAR

LogModel10 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH, data=analytic, family = "binomial") 
summary(LogModel10)

#add health plan

LogModel11 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH + NOPLAN, data=analytic, family = "binomial") 
summary(LogModel11)

#take out health plan
#add education

LogModel12 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ LOWED + SOMECOLL, data=analytic, family = "binomial") 
summary(LogModel12)

#take out education
#add income

LogModel13 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4 + INC5 + INC6 + INC7, data=analytic, family = "binomial") 
summary(LogModel13)

#take out INC5 through INC7

LogModel14 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE + SMOKER 
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4, data=analytic, family = "binomial") 
summary(LogModel14)

#take out SMOKER

LogModel15 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4, data=analytic, family = "binomial") 
summary(LogModel15)

#add obesity

LogModel16 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ UNDWT + OVWT + OBESE, data=analytic, family = "binomial") 
summary(LogModel16)

#remove UNDWT

LogModel17 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OVWT + OBESE, data=analytic, family = "binomial") 
summary(LogModel17)

#remove OVWT

LogModel18 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE, data=analytic, family = "binomial") 
summary(LogModel18)

#add exercise

LogModel19 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER, data=analytic, family = "binomial") 
summary(LogModel19)

#add back DRKMONTHLY

LogModel20 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY, data=analytic, family = "binomial") 
summary(LogModel20)

#MODEL20 is CANDIDATE FINAL MODEL

#try to add back SMOKER

LogModel21 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER, data=analytic, family = "binomial") 
summary(LogModel21)

#almost significant, keep.
#add back HISPANIC

LogModel22 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ HISPANIC, data=analytic, family = "binomial") 
summary(LogModel22)

#remove HISPANIC
#add back BLACK

LogModel23 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ BLACK, data=analytic, family = "binomial") 
summary(LogModel23)

#remove BLACK
#add back ASIAN

LogModel24 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ ASIAN, data=analytic, family = "binomial") 
summary(LogModel24)

#remove ASIAN
#add back LOWED

LogModel25 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED, data=analytic, family = "binomial") 
summary(LogModel25)

#keep LOWED
#add back SOMECOLL

LogModel26 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + SOMECOLL, data=analytic, family = "binomial") 
summary(LogModel26)

#remove SOMECOLL
#add back INC5

LogModel27 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + INC5, data=analytic, family = "binomial") 
summary(LogModel27)

#remove INC5
#add back INC6

LogModel28 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + INC6, data=analytic, family = "binomial") 
summary(LogModel28)

#remove INC6
#add back INC7

LogModel29 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + INC7, data=analytic, family = "binomial") 
summary(LogModel29)

#remove INC7
#add back FORMERMAR

LogModel30 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + FORMERMAR, data=analytic, family = "binomial") 
summary(LogModel30)

#remove FORMERMAR
#add back NOPLAN

LogModel31 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + NOPLAN, data=analytic, family = "binomial") 
summary(LogModel31)

#remove FORMERMAR
#add back UNDWT

LogModel32 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + UNDWT, data=analytic, family = "binomial") 
summary(LogModel32)

#remove UNDWT
#add back OVWT

LogModel33 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT, data=analytic, family = "binomial") 
summary(LogModel33)

#add back AGE2

LogModel34 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2, data=analytic, family = "binomial") 
summary(LogModel34)

#add back AGE3

LogModel35 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE3, data=analytic, family = "binomial") 
summary(LogModel35)

#remove AGE3
#add back AGE4

LogModel36 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE4, data=analytic, family = "binomial") 
summary(LogModel36)

#remove AGE4
#add back AGE5

LogModel37 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5, data=analytic, family = "binomial") 
summary(LogModel37)

#add back AGE6

LogModel38 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + AGE6, data=analytic, family = "binomial") 
summary(LogModel38)


#remove AGE6
#add back HISPANIC

LogModel39 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + HISPANIC, data=analytic, family = "binomial") 
summary(LogModel39)

#remove HISPANIC
#add back SOMECOLL

LogModel40 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + SOMECOLL, data=analytic, family = "binomial") 
summary(LogModel40)

#remove SOMECOLL
#add back UNDWT

LogModel41 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + UNDWT, data=analytic, family = "binomial") 
summary(LogModel41)

#remove UNDWT
#add back health plan

LogModel42 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + NOPLAN, data=analytic, family = "binomial") 
summary(LogModel42)

#remove NOPLAN
#add back INC5

LogModel43 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + INC5, data=analytic, family = "binomial") 
summary(LogModel43)

#remove INC5
#add back INC6

LogModel44 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + INC6, data=analytic, family = "binomial") 
summary(LogModel44)

#remove INC6
#add back INC7

LogModel45 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + INC7, data=analytic, family = "binomial") 
summary(LogModel45)

#remove INC7
#add back BLACK

LogModel46 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + BLACK, data=analytic, family = "binomial") 
summary(LogModel46)

#remove BLACK
#add back ASIAN

LogModel47 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + ASIAN, data=analytic, family = "binomial") 
summary(LogModel47)

#remove ASIAN
#add back FORMERMAR

LogModel48 <- glm(ASTHMA4 ~ DRKWEEKLY + MALE
	+ OTHRACE + NEVERMAR + FAIRHLTH + POORHLTH
	+ INC1 + INC2 + INC3 + INC4
	+ OBESE + NOEXER + DRKMONTHLY + SMOKER
	+ LOWED + OVWT + AGE2 + AGE5 + FORMERMAR, data=analytic, family = "binomial") 
summary(LogModel48)

#FINAL MODEL
#arrange covariates in order of table 1

FinalLogisticRegressionModel <- glm(ASTHMA4 ~ DRKMONTHLY + DRKWEEKLY 
	+ AGE2 + AGE5 + MALE
	+ OTHRACE + NEVERMAR + LOWED 
	+ INC1 + INC2 + INC3 + INC4
	+ OVWT + OBESE + SMOKER 
	+ NOEXER + FAIRHLTH + POORHLTH, data=analytic, family = "binomial") 
summary(FinalLogisticRegressionModel)

#write out CSV of final model

library (devtools)
library (broom)

Tidy_LogModel_a <- tidy(FinalLogisticRegressionModel)
Tidy_LogModel3 <- subset(Tidy_LogModel_a, term != "(Intercept)")

#Add calculations

Tidy_LogModel3$OR <- exp(Tidy_LogModel3$estimate)
Tidy_LogModel3$LL <- exp(Tidy_LogModel3$estimate - (1.96 * Tidy_LogModel3$std.error))
Tidy_LogModel3$UL <- exp(Tidy_LogModel3$estimate + (1.96 * Tidy_LogModel3$std.error))

write.csv(Tidy_LogModel3, file = "LogisticRegressionModel3.csv")

#visualize to help interpretation

library(ggplot2)

ggplot(Tidy_LogModel3, 
	aes(x = term, y = OR, ymin = LL, ymax = UL)) + 
	geom_pointrange(aes(col = factor(term)), 
	position=position_dodge(width=0.30)) + 
 	ylab("Odds ratio & 95% CI") + 
	geom_hline(aes(yintercept = 1)) + 
	scale_color_discrete(name = "Term") + 
	xlab("") + 
	theme(axis.text.x = element_text(angle = 90, hjust = 1))


