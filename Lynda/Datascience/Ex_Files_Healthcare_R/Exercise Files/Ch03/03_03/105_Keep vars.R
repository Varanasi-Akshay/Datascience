#define object list of variables to be kept

BRFSSVarList <- c("VETERAN3", 
			"ALCDAY5",
			"SLEPTIM1",
			"ASTHMA3",
			"X_AGE_G",
			"SMOKE100",
			"SMOKDAY2",
			"SEX",
			"X_HISPANC",
			"X_MRACE1",
			"MARITAL",
			"GENHLTH",
			"HLTHPLN1",
			"EDUCA",
			"INCOME2",
			"X_BMI5CAT",
			"EXERANY2")

#subset by varlist

BRFSS_b <- BRFSS_a[BRFSSVarList]

#check columns

colnames(BRFSS_b)

#check rows

nrow(BRFSS_b)



