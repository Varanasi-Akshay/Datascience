#load foreign package

library(foreign)

#read in data to R

BRFSS_a <- read.xport("C:/Users/Monka Wahi/Analytics/Data/LLCP2014.xpt")

#example of an index

BRFSS_vasc<- BRFSS_a

#transform variables

BRFSS_vasc$HA <- 0
BRFSS_vasc$HA[BRFSS_vasc$CVDINFR4 == 1] <- 1
table(BRFSS_vasc$HA, BRFSS_vasc$CVDINFR4)

BRFSS_vasc$CHD <- 0
BRFSS_vasc$CHD[BRFSS_vasc$CVDCRHD4== 1] <- 1
table(BRFSS_vasc$CHD, BRFSS_vasc$CVDCRHD4)

BRFSS_vasc$STROKE <- 0
BRFSS_vasc$STROKE [BRFSS_vasc$CVDSTRK3== 1] <- 1
table(BRFSS_vasc$STROKE, BRFSS_vasc$CVDSTRK3)

#make index

BRFSS_vasc$VASCINDEX <- NA
BRFSS_vasc$VASCINDEX <- BRFSS_vasc$HA + BRFSS_vasc$CHD + BRFSS_vasc$STROKE
table(BRFSS_vasc$VASCINDEX)

#Look at distribution

summary(BRFSS_vasc$VASCINDEX)

hist(BRFSS_vasc$VASCINDEX, 
	main = "Histogram of VASCINDEX",
	xlab = "Class VASCINDEX",
	ylab = "Frequency",
	xlim=c(0,4), 
	ylim=c(0,500000),
	border = "red",
	col= "yellow",
	las = 1,
	breaks = 4)



