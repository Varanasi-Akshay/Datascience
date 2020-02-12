/* To calculate the confidence intervals for E{Y} at X=65 and at X=100, we need to add 
these values of X to our dataset, BUT we will leave the corresponding values of Y as missing.*/

/* First, we start with the original data set and do the confidence intervals for E{Y} for
each conditional distribution in the data set*/
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


/* To calculate confidence intervals for E{Y}, we simply use the "clm" comamnd after
a backslash.  The alpha = "" tells SAS what the value of alpha is.  For 90% confidence, alpha is .1.
Note, this only produces confidence intervals for E{Y} at the values of X in the dataset.	
*/


proc reg data=toluca;
 model WorkHrs = LotSize/ clm  alpha = 0.10;
 run;
quit;

/* 
 X=65 and at X=100 are not in the dataset, but these are the values of X
for which we want confidence intervals of E{Y}.	


Therefore, we will add these values to our dataset,
BUT we will leave the corresponding values of Y as missing.  Thus SAS will produce confidence
intervals for E{Y} at these values of X but since the Y's are missing, they do not impact the analysis in any way.



New x values.  The "." indicates a missing value */

data newx; input LotSize WorkHrs;
cards;
65 .
100 .
;
run;

/* To create our new dataset, we combine the above two files;*/ 

data toluca2; set toluca newx; run;

proc print data=toluca2; run;


/* For X_h=65, the confidence interval for E{Y} is (277.4, 311.4). 
This is the 26th observation in the dataset.

For X_h=100, the confidence interval for E{Y} is (394.9, 443.9)	
This is the 27th observation in the dataset.

The command clm tells it to give confidence intervals for E{Y} at all the values of
X in the dataset.


*/



proc reg data=toluca2;
 model WorkHrs = LotSize/ clm  alpha = 0.10;
 run;
quit;





















