#read in analytic table

analytic <- read.csv(file="D:/Dropbox/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#make Model 1

LogModel1 <- glm(ASTHMA4 ~ DRKMONTHLY + DRKWEEKLY, data=analytic, family = "binomial") 
summary(LogModel1)

library (devtools)
library (broom)

Tidy_LogModel1 <- tidy(LogModel1)
Tidy_LogModel1

#Add calculations

Tidy_LogModel1$OR <- exp(Tidy_LogModel1$estimate)
Tidy_LogModel1$LL <- exp(Tidy_LogModel1$estimate - (1.96 * Tidy_LogModel1$std.error))
Tidy_LogModel1$UL <- exp(Tidy_LogModel1$estimate + (1.96 * Tidy_LogModel1$std.error))
Tidy_LogModel1

write.csv(Tidy_LogModel1, file = "LogisticRegressionModel1.csv")

#make Model 2

LogModel2 <- glm(ASTHMA4 ~ DRKMONTHLY + DRKWEEKLY + MALE + AGE2 + AGE3 + AGE4 + AGE5 + AGE6, data=analytic, family = "binomial") 
summary(LogModel2) 

#Add calculations

Tidy_LogModel2 <- tidy(LogModel2)
Tidy_LogModel2$OR <- exp(Tidy_LogModel2$estimate)
Tidy_LogModel2$LL <- exp(Tidy_LogModel2$estimate - (1.96 * Tidy_LogModel2$std.error))
Tidy_LogModel2$UL <- exp(Tidy_LogModel2$estimate + (1.96 * Tidy_LogModel2$std.error))
write.csv(Tidy_LogModel2, file = "LogisticRegressionModel2.csv")





