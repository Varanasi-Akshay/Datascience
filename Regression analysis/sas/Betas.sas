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


/* Lecture 11 */

/* As part of the output, sas gives the least squares estimates.  To generate confidence intervals for the
Betas, we use the clb command following a "/" in the model sattement.
*/

proc reg data=toluca;
 model WorkHrs = LotSize/clb;
 run;

 /* To generate a 90% confidence interval, we can change the alpha level to .1 by using alpha=.1*/

 proc reg data=toluca;
 model WorkHrs = LotSize/clb alpha=.1;
 run;


/* LECTURE 12*/

 /* The t-tests for Ho: Beta=0 are automatically provided as part of the output.
Note, 
t=b/se(b) =3.57020/0.34697 = 10.2896504
and pvalue <.001.

Note, the degrees of freedom for this test statistic is n-2 = 23.  These are the error degrees
 of freedom.

 The 1 degree of freedom given next to the parameter estimate is NOT the df for the test.

*/
