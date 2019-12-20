#load foreign package

library(foreign)

#read in data to R

BRFSS_a <- read.xport("C:/Users/Monka Wahi/Analytics/Data/LLCP2014.xpt")

colnames(BRFSS_a)
