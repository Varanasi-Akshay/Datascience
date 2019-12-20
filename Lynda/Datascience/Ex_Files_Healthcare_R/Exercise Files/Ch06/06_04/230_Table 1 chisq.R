#read in analytic table

analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#load MASS library

library(MASS)

#make table

AlcTbl = table(analytic$ASTHMA4, analytic$ALCGRP) 

#run test
chisq.test(AlcTbl)  

#make macro

library(gtools)

ChiTest <- defmacro(VarName, TblName, expr={
TblName = table(analytic$ASTHMA4, analytic$VarName); 
chisq.test(TblName)})

ChiTest(ALCGRP, AlcTbl)
ChiTest(X_AGE_G, AgeTbl)
ChiTest(SEX, SexTbl)
ChiTest(X_HISPANC, HispTbl)
ChiTest(RACEGRP, RaceTbl)
ChiTest(MARGRP, MarTbl)
ChiTest(EDGROUP, EdTbl)
ChiTest(INCOME3, IncTbl)
ChiTest(BMICAT, BMITbl)
ChiTest(SMOKGRP, SmokTbl)
ChiTest(EXERANY3, ExerTbl)
ChiTest(HLTHPLN2, HlthPlnTbl)
ChiTest(GENHLTH2, GenHlthTbl)







