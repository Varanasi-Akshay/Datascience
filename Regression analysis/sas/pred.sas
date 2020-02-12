/* To calculate the prediction intervals for a new Y at X=65 and at X=100, we need to add 
these values of X to our dataset, BUT we will leave the corresponding values of Y as missing*/

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

/* The prediction interval for a new Y at x=100 was (332.2, 506.6)
This is the 27th observation in the dataset.

The command cli tells SAS to give prediction intervals for new Ys at all the values of
X in the dataset.

alpha = "" tells it what the value of alpha is.  For 90% confidence alpha is .1
*/



proc reg data=toluca2;
 model WorkHrs = LotSize/ cli  alpha = 0.10;
 run;
quit;
