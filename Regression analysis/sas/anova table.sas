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



/* 

The output in SAS includes an ANOVA table.  The regression sums of squares are called the model
sums of squares in SAS.  


For simple linear regression, the model F statistic is the same as the F statistic testing 
if the Beta corresponding to X (here Lotsize) is 0.

In general, the model F statistic tests if all the predictors are 0.  Since we only have one predictor,
for now these tests are equivalent.

Note, we have that  t = 10.29 and F = 105.88=10.29^2



*/

proc reg data=toluca;
 model WorkHrs = LotSize ;
 run;
quit;


/* We can also use proc glm which gives a slightly different output but the code is identical.
The output here includes both the F test and the t-test for lotsize.  And again, the F test for
lotsize is the	same as the F test for the model since lotsize is the only predictor in the model.

*/


proc glm data=toluca;
 model WorkHrs = LotSize ;
 run;
quit;
