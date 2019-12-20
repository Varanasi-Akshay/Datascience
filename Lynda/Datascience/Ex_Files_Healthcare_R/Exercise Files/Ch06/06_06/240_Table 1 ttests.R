#read in analytic table

analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#ttests for Table 1

t.test(analytic$SLEPTIM2~analytic$ASTHMA4)
t.test(analytic$SLEPTIM2~analytic$SEX)