#read in analytic table

#analytic <- read.csv(file="C:/Users/Monika/Dropbox/R Stats Book/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#subset dataset with only asthma people

noasthmaonly <- subset(analytic, ASTHMA4 != 1)
table(noasthmaonly $ASTHMA4)
nrow(noasthmaonly)

AsthmaFreq <- table(noasthmaonly$ASTHMA4)
AsthmaFreq
write.csv(AsthmaFreq, file = "Asthma.csv")

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

FreqTbl (AlcGrpFreq, noasthmaonly$ALCGRP, "Alc")
FreqTbl (AgeGrpFreq, noasthmaonly$X_AGE_G, "Age")
FreqTbl (SexFreq, noasthmaonly$SEX, "Sex")
FreqTbl (HispFreq, noasthmaonly$X_HISPANC, "Hisp")
FreqTbl (RaceFreq, noasthmaonly$RACEGRP, "Race")
FreqTbl (MaritalFreq, noasthmaonly$MARGRP, "Mar")
FreqTbl (EdFreq, noasthmaonly$EDGROUP, "Ed")
FreqTbl (IncFreq, noasthmaonly$INCOME3, "Inc")
FreqTbl (BMIFreq, noasthmaonly$BMICAT, "BMI")
FreqTbl (SmokeFreq, noasthmaonly$SMOKGRP, "Smok")
FreqTbl (ExerFreq, noasthmaonly$EXERANY3, "Exer")
FreqTbl (HlthPlanFreq, noasthmaonly$HLTHPLN2, "HlthPln")
FreqTbl (GenHlthFreq, noasthmaonly$GENHLTH2, "GenHlth")

