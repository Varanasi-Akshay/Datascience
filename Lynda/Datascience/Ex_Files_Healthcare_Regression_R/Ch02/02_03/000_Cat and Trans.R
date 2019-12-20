#copy to new dataset

BRFSS_sleep <- analytic

#summary statistics

summary(BRFSS_sleep$SLEPTIM2)

#look at histogram

hist(BRFSS_sleep$SLEPTIM2, 
	main = "Histogram of SLEPTIM2",
	xlab = "Class SLEPTIM2",
	ylab = "Frequency",
	xlim=c(0,15), 
	ylim=c(0,20000),
	border = "red",
	col= "yellow",
	las = 1,
	breaks = 24)

#categorize at median

BRFSS_sleep$SLEEPCAT <- 9
BRFSS_sleep$SLEEPCAT[BRFSS_sleep$SLEPTIM2 >7] <- 1
BRFSS_sleep$SLEEPCAT[BRFSS_sleep$SLEPTIM2 <=7] <- 2

table(BRFSS_sleep$SLEEPCAT, BRFSS_sleep$SLEPTIM2)

#log transformation

BRFSS_sleep$LOGSLEEP <- log(BRFSS_sleep$SLEPTIM2)

summary(BRFSS_sleep$LOGSLEEP)

hist(BRFSS_sleep$LOGSLEEP, 
	main = "Histogram of LOGSLEEP",
	xlab = "Class LOGSLEEP",
	ylab = "Frequency",
	xlim=c(0,4), 
	ylim=c(0,35000),
	border = "red",
	col= "yellow",
	las = 1,
	breaks = 5)

