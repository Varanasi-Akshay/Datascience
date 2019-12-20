#copy to new dataset

BRFSS_sleep <- analytic

#summary statistics
#quartiles of SLEPTIM2

SLEEPQuantiles <- quantile(BRFSS_sleep$SLEPTIM2)
SLEEPQuantiles

BRFSS_sleep$SLEPQUART <- 9
BRFSS_sleep$SLEPQUART[BRFSS_sleep$SLEPTIM2 <= 6] <- 1
BRFSS_sleep$SLEPQUART[BRFSS_sleep$SLEPTIM2 >6 & BRFSS_sleep$SLEPTIM2 <=7] <- 2
BRFSS_sleep$SLEPQUART[BRFSS_sleep$SLEPTIM2 >7 & BRFSS_sleep$SLEPTIM2 <=8] <- 3
BRFSS_sleep$SLEPQUART[BRFSS_sleep$SLEPTIM2 >8] <- 4

table(BRFSS_sleep$SLEPQUART, BRFSS_sleep$SLEPTIM2)

