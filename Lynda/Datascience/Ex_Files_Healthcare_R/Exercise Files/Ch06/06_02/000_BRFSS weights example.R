#weights example

WeightVarList <- c("X_STATE", "X_LLCPWT", "ASTHMA3")

BRFSS_weights <- subset(BRFSS_a[WeightVarList])

colnames(BRFSS_weights)
nrow(BRFSS_weights)

#use questionr package

library(questionr)

WeightedAsthma <- wtd.table(BRFSS_weights$ASTHMA3, 
	y=BRFSS_weights$X_STATE, weights = BRFSS_weights$X_LLCPWT, normwt = FALSE, na.rm = TRUE,
  	na.show = FALSE)
write.csv(WeightedAsthma, file = "WeightedAsthma.csv")