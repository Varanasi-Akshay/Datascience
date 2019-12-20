#Add indicator variable for veterans

#Make a copy of the dataset
BRFSS_g <- BRFSS_f

#add the categorical variable set to 9 to the dataset
BRFSS_g$ALCGRP <- 9

#Update according to the data dictionary
BRFSS_g$ALCGRP[BRFSS_g$ALCDAY5 <200 ] <- 3
BRFSS_g$ALCGRP[BRFSS_g$ALCDAY5 >=200 & BRFSS_g$ALCDAY5 <777] <- 2
BRFSS_g$ALCGRP[BRFSS_g$ALCDAY5 == 888] <- 1

#Check variable

table(BRFSS_g$ALCGRP, BRFSS_g$ALCDAY5)

#Add flags

BRFSS_g$DRKMONTHLY <- 0
BRFSS_g$DRKMONTHLY[BRFSS_g$ALCGRP == 2] <- 1

table(BRFSS_g$ALCGRP, BRFSS_g$DRKMONTHLY)

BRFSS_g$DRKWEEKLY <- 0
BRFSS_g$DRKWEEKLY [BRFSS_g$ALCGRP == 1] <- 1

table(BRFSS_g$ALCGRP, BRFSS_g$DRKWEEKLY)