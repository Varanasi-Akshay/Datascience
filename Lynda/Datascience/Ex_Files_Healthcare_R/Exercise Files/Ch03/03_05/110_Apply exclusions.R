#Figure out the number of rows in the original dataset

nrow(BRFSS_b)

#subset the dataset for only veterans

BRFSS_c <- subset(BRFSS_b, VETERAN3==1)

#make sure the variable looks right

BRFSS_c$VETERAN3

#Figure out how many rows are in resulting dataset

nrow(BRFSS_c)

#only keep rows with with valid alcohol/exposure variable

BRFSS_d <- subset(BRFSS_c, ALCDAY5 < 777 | ALCDAY5==888)

#make sure variable looks right

BRFSS_d$ALCDAY5

#count rows in new dataset

nrow(BRFSS_d)

#only keep rows with valid sleep data

BRFSS_e <- subset(BRFSS_d, SLEPTIM1 < 77)

#count rows in the new dataset

nrow(BRFSS_e)

#only keep rows with valid asthma data

BRFSS_f <- subset(BRFSS_e, ASTHMA3 < 7)

#count rows in the new dataset

nrow(BRFSS_f)




