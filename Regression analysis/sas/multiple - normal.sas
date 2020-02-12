
data stays; input stay age gender;
cards;
10  10 1
14  15 1
20 20 1
26 25 1
30 30 1
35 35 1
31 10 0
36 14 0
42 21 0
46 27 0
51 30 0
57 34 0
;
run;

/* to do a test of normaility, again we use the normal command within proc univariate 
where the variable is the residuals*/

proc reg data=stays;
model stay=age gender/ clm  alpha = 0.1;
output out=resultsmm p=predictedsmm r=residualsmm;
run;



proc univariate data=resultsmm plot normal	 ;
	var residualsmm
; run;
