#read in analytic table

#analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

mean(analytic$SLEPTIM2)
sd(analytic$SLEPTIM2)

#load package plyr

library(plyr)

#example

ddply(analytic,~ALCGRP,summarise,mean=mean(SLEPTIM2),sd=sd(SLEPTIM2))

#USING MACROS

library(gtools)

SumTbl <- defmacro(OutputTable, GroupVar, CSVTable,
expr={
OutputTable <- ddply(analytic,~GroupVar,summarise,mean=mean(SLEPTIM2),sd=sd(SLEPTIM2));
write.csv(OutputTable, file = paste0(CSVTable, ".csv"))
})

SumTbl (AlcGrpSum, analytic$ALCGRP, "Alc")
SumTbl (AgeGrpSum, analytic$X_AGE_G, "Age")
SumTbl (SexSum, analytic$SEX, "Sex")
SumTbl (HispSum, analytic$X_HISPANC, "Hisp")
SumTbl (RaceSum, analytic$RACEGRP, "Race")
SumTbl (MaritalSum, analytic$MARGRP, "Mar")
SumTbl (EdSum, analytic$EDGROUP, "Ed")
SumTbl (IncSum, analytic$INCOME3, "Inc")
SumTbl (BMISum, analytic$BMICAT, "BMI")
SumTbl (SmokeSum, analytic$SMOKGRP, "Smok")
SumTbl (ExerSum, analytic$EXERANY3, "Exer")
SumTbl (HlthPlanSum, analytic$HLTHPLN2, "HlthPln")
SumTbl (GenHlthSum, analytic$GENHLTH2, "GenHlth")




