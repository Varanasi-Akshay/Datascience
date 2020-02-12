
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

/* To do a multiple regression, we run the model the same as before, listing all variables in the model statement. */


proc reg data=stays;
model stay=age gender;
run;



/* The MSR term is given by the model mean square and the MSE is given by the error mean square.

The overall F statistic is MSR/MSE.  Here the MSR is 1136.55073	and the MSE is 1.17391.  Thus 
F = 1136.55073/1.17391	=  968.1754.  Note this F value is given as the model F.  It is the F test
to see if the model has any effect on the mean response.  That is, this is testing if ALL the Betas
are 0.  

The numerator df are p-1, which here is 2. Note, p is the total number of Betas, which includes the intercept. 
Thus p-1 is the number of predictors.  The denominator df are n-p.  The are 12 subjects, so n-p=12-3=9.

The p-value is < .0001.





___





/* The t-tests for each Beta are part of the output and	to obtain the CI's of the Betas,
we use the clb command like before. 
*/


proc reg data=stays;
model stay=age gender/ clb alpha = 0.1;
run;








/* CI for Mean responses:
We can also use the clm command to get the confidence intervals
for the mean responses for a specific values of vectors of X.	That is,
for example when the vector of X is 10 1 (the first observation), then
the 90% confidence interval for E{Y} is  (8.6151, 10.9478).
*/


proc reg data=stays;
model stay=age gender/ clm alpha = 0.1;
run;




/* To get predictions for vectors of X use the cli command */

proc reg data=stays;
model stay=age gender/ cli  alpha = 0.1;
run;


