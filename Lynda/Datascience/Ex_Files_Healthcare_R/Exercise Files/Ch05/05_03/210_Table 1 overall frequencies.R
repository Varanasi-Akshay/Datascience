#read in analytic table

analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#Start by making frequencies per category

AsthmaFreq <- table(analytic$ASTHMA4)
AsthmaFreq
write.csv(AsthmaFreq, file = "AsthmaFreq.csv")

AlcFreq <- table(analytic$ALCGRP)
AlcFreq 
write.csv(AlcFreq , file = "AlcFreq.csv")

#USING MACROS

#install package gtools
#then call up library

library(gtools)

#use defmacro to define the macro

FreqTbl <-defmacro(OutputTable, InputVar, CSVTable, 
expr={
OutputTable <- table(InputVar);
write.csv(OutputTable, file = paste0(CSVTable, ".csv"))
})

FreqTbl (AlcFreq, analytic$ALCGRP, "Alc")
FreqTbl (AgeFreq, analytic$X_AGE_G, "Age")
FreqTbl (SexFreq, analytic$SEX, "Sex")
FreqTbl (HispFreq, analytic$X_HISPANC, "Hisp")
FreqTbl (RaceFreq, analytic$RACEGRP, "Race")
FreqTbl (MaritalFreq, analytic$MARGRP, "Mar")
FreqTbl (EdFreq, analytic$EDGROUP, "Ed")
FreqTbl (IncFreq, analytic$INCOME3, "Inc")
FreqTbl (BMIFreq, analytic$BMICAT, "BMI")
FreqTbl (SmokeFreq, analytic$SMOKGRP, "Smok")
FreqTbl (ExerFreq, analytic$EXERANY3, "Exer")
FreqTbl (HlthPlanFreq, analytic$HLTHPLN2, "HlthPln")
FreqTbl (GenHlthFreq, analytic$GENHLTH2, "GenHlth")
















