#Create rank

order.sleeptime <- order(-BRFSS_sleep$SLEPTIM2)

BRFSS_sleep2 <- BRFSS_sleep[order.sleeptime,]

BRFSS_sleep2$SLEPRANK <- rank(BRFSS_sleep2$SLEPTIM2)

head(BRFSS_sleep2[,c("SLEPRANK","SLEPTIM2")], n=25)

tail(BRFSS_sleep2[,c("SLEPRANK","SLEPTIM2")], n=25)

