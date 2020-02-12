/* To calculate the confidence intervals for E{Y} at X=65 and at X=100, we need to add 
these values of X to our dataset, BUT we will leave teh corresponding values of Y as missing*/

/* Original data set */
data toluca;
  input LotSize WorkHrs;
cards;
   80  399
   30  121
   50  221
   90  376
   70  361
   60  224
  120  546
   80  352
  100  353
   50  157
   40  160
   70  252
   90  389
   20  113
  110  435
  100  420
   30  212
   50  268
   90  377
  110  421
   30  273
   90  468
   40  244
   80  342
   70  323
;
run;

/* new x values - the "." indicates a missing value */

data newx; input LotSize WorkHrs;
cards;
65 .
100 .
;
run;

/* to create our new dataset, we combine the above two files;*/ 

data toluca2; set toluca newx; run;

proc print data=toluca2; run;


/* For X_h=65, the confidence interval for E{Y} is (277.4, 311.4).

For X_h=100, the confidence interval for E{Y} is (394.9, 443.9)	

The command clm tells it to give confidence intervals for E{Y} all teh values of
X in the dataset.

alpha = "" tells it what teh value of alpha is.  For 90% confidence alpha is .1
*/



proc reg data=toluca2;
 model WorkHrs = LotSize/ clm  alpha = 0.10;
 run;
quit;


