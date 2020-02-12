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



/* Part of the output includes r^squared.  To get r we can simply take the square root and use the 
sign from the estimate b1.*/

proc reg data=toluca;
 model WorkHrs = LotSize ;
 run;
quit;

/* To get the correlation r, we can use proc corr */

proc corr data=toluca;
var WorkHrs  LotSize ; run;






/* Below is a made up dataset we will use to demonstarte a few things.*/


data toluca_madeup;
  input LotSize WorkHrs;
cards;
   80  99
   30  121
   50  221
   90  376
   70  361
   60  224
  120  546
   80  352
  100  53
   50  157
   40  160
   70  252
   90  89
   20  113
  110  35
  100  20
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



proc reg data=toluca_madeup;
 model WorkHrs = LotSize ;
 run;
quit;

/* Notice the p-value for the t test is now 0.2193.  This is testing Beta1=0.

When we run proc corr, we will get the p-value for the test rho=0. */

proc corr data=toluca_madeup;
var WorkHrs  LotSize ; run;

/* Note, this p-value is also  0.2193. 	*/



/* We can standradize our variables by using proc standard.  In the proc statement line, we list the
value of the mean and standard deviation we want to transform our variables to.
We use "out=filename" to create the name of a file that will contain these transformed variables.
We then list the variables we want to transform after the var command.*/


proc standard data = toluca_madeup mean=0 std=1 out=zscores;
	var WorkHrs  LotSize;
run;

proc print data = toluca_madeup;
run;


proc print data = zscores;
run;


/* The variables have been standardized.  We can see this by using proc means*/

proc means data=zscores;
var WorkHrs  LotSize;
run;


/* When both X and Y have the same standard deviation, then b1=r.   r is the standardized 
version of the slope*/




proc reg data=zscores;
 model WorkHrs = LotSize ;
 run;
quit;

/* r^squared = 0.0648, thus r = sqrt(0.0648) = 0.2545584 which is the value of b1 (with rounding)
We can get r directly also.*/

proc corr data=zscores;
var WorkHrs  LotSize ; run;
