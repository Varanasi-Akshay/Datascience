#read in analytic table

analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#ANOVAS for Table 1

#example ANOVA

AlcANOVA <- lm(formula = SLEPTIM2 ~ ALCGRP, data = analytic)
summary(AlcANOVA)

#make macro

library(gtools)

ANOVATest <- defmacro(VarName, TblName, expr={
TblName<- lm(formula = SLEPTIM2 ~ VarName, data = analytic);
summary(TblName)})

#call macro

ANOVATest (ALCGRP, AlcANOVA)
ANOVATest (X_AGE_G, AgeANOVA)
ANOVATest (X_HISPANC, HispANOVA)
ANOVATest (RACEGRP, RaceANOVA)
ANOVATest (MARGRP, MarANOVA)
ANOVATest (EDGROUP, EdANOVA)
ANOVATest (INCOME3, IncANOVA)
ANOVATest (BMICAT, BMIANOVA)
ANOVATest (SMOKGRP, SmokANOVA)
ANOVATest (EXERANY3, ExerANOVA)
ANOVATest (HLTHPLN2, HlthPlnANOVA)
ANOVATest (GENHLTH2, GenHlthANOVA)


