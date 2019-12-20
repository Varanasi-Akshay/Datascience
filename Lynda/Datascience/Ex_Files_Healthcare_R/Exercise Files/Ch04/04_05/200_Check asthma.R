#read in analytic table

analytic <- read.csv(file="C:/Users/Monka Wahi/Analytics/Data/analytic.csv", header=TRUE, sep=",")

#Look at distribution of categorical outcome asthma

AsthmaFreq <- table(analytic$ASTHMA4)
AsthmaFreq
write.csv(AsthmaFreq, file = "AsthmaFreq.csv")

#what proportion of our dataset has ashtma?
PropAsthma <- 5343/52788
PropAsthma

#Look at categorical outcome asthma by exposure, ALCGRP

AsthmaAlcFreq <- table(analytic$ASTHMA4, analytic$ALCGRP)
AsthmaAlcFreq
write.csv(AsthmaAlcFreq, file = "AsthmaAlcFreq.csv")


