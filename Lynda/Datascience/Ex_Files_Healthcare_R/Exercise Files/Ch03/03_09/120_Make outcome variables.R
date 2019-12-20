#Make a copy of the dataset
BRFSS_h <- BRFSS_g

#Make and test sleep variable

BRFSS_h$SLEPTIM2 <- NA
BRFSS_h$SLEPTIM2[!is.na(BRFSS_h$SLEPTIM1) & BRFSS_h$SLEPTIM1 !=77
	& BRFSS_h$SLEPTIM1 !=99] <- BRFSS_h$SLEPTIM1

table(BRFSS_h$SLEPTIM1, BRFSS_h$SLEPTIM2)

#Make and test asthma variable

BRFSS_h$ASTHMA4 <- 9
BRFSS_h$ASTHMA4[BRFSS_h$ASTHMA3 == 1] <- 1
BRFSS_h$ASTHMA4[BRFSS_h$ASTHMA3 == 2] <- 0

table(BRFSS_h$ASTHMA3, BRFSS_h$ASTHMA4)
 