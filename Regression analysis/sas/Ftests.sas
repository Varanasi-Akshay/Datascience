
data fat; input triceps thigh midarm bodyfat;
cards;
 19.5  43.1  29.1  11.9
  24.7  49.8  28.2  22.8
  30.7  51.9  37.0  18.7
  29.8  54.3  31.1  20.1
  19.1  42.2  30.9  12.9
  25.6  53.9  23.7  21.7
  31.4  58.5  27.6  27.1
  27.9  52.1  30.6  25.4
  22.1  49.9  23.2  21.3
  25.5  53.5  24.8  19.3
  31.1  56.6  30.0  25.4
  30.4  56.7  28.3  27.2
  18.7  46.5  23.0  11.7
  19.7  44.2  28.6  17.8
  14.6  42.7  21.3  12.8
  29.5  54.4  30.1  23.9
  27.7  55.3  25.7  22.6
  30.2  58.6  24.6  25.4
  22.7  48.2  27.1  14.8
  25.2  51.0  27.5  21.1
;
run;

/* OVERALL F test.  
We will run the model and get the overall F statistic and p-value. */

proc glm data=fat;
model bodyfat=triceps thigh midarm  ;
run;
/* The MSR term is given by the model mean square and the MSE is given by the error mean square.

The overall F statistic is MSR/MSE.  Here the MSR is  132.3282039 and the MSE is 6.1503055.  Thus 
F = 132.3282039/6.1503055 = 968.1753542.  Note this F value is given as the model F.  It is the F test
to see if the model has any effect on the mean response. 

The numerator df are p-1, which here is 3. Note, p is the total number of Betas, which includes the intercept. 
Thus P-1 is the number of predictors.  The denominator df are n-p.  The are 20 subjects, so n-p =20-4=16.
The p-value is < .0001.
*/






/* F test on a single Beta*/

/* T -tests and Type III SS correspond to testing Ho: B3=0*/
/* When we run proc glm or proc reg we get both the F-test and the t-test for one Beta.  Testing Ho: B3=0 
is a marginal test, given that X1 and X2 are already in the model.  Thus it corresponds to type III SS.  
For example, we had that the F statistic for B3 was 1.88 and that the t statistic for B3 was -1.37, 
which is what we get here.


*/




/* F test whether some of the Betas are 0*/

/*To test Ho: ß2 = ß3 = 0, we need SSR(X2,X3|X1) = SSR(X2|X1) + SSR(X3|X1,X2)
These extra sums of squares are found in the type 1 SS.  Recall, type I ss are sequential. 
The extra sum of squares listed for X2 is given that X1 is in the model and the extra sums of squares 
listed for X3 is given that X1 and X2 are in the model.  

 SSR(X2|X1) is then the type I ss for thigh given triceps is in the model, which is 33.1689128, and SSR(X3|X1,X2) 
is the type I SS for midarm given triceps and thigh are in the model, which is 11.5459022. 
Thus SSR(X2,X3|X1) = 33.17 + 11.54 = 44.71.

Note also, SSE(X1,X2,X3) is the error sums of squares which is 98.4.  Thus F is
44.71/2 divided by  98.4/16.  Note, the numerator df
are p-q, where p is the number of Betas in the full model,4, and q is the number of Betas in the reduced model, 2.
Simply put, p-q is the number of Betas being tested.


The df for the denominator are n-p, which is 20-4=16.


The F statistic equals 3.63 and has a p-value of .05

Instead of doing this by hand, we can do a partial F test in proc reg.  We use the "test" command.
After we write out "test", we list our null hypothesis.  
To test if the Beta corersponding to midarm (B3) is 0, we use "test midarm=0;" 
To test if the Betas corersponding to thigh (B2) and midarm	(B3) are both 0, we use
"test thigh=0,midarm=0;	"




First we test if  Beta corersponding to midarm (B3) is 0*/


proc reg data=fat;
model bodyfat=triceps thigh midarm  ;
test midarm=0;
run;

/* Note the results are exactly the same as the t test listed above in 5the output, 
which corresponds with type III SS.

Now, we test if the Betas corersponding to thigh (B2)and midarm (B3)are both 0*/

proc reg data=fat;
model bodyfat=triceps thigh midarm  ;
test thigh=midarm=0 ;
run;

/* Note, our results match what we got when we did the Partial F test by hand.  The F value is 3.64 and the p-value is 
.05*/


/* F test testing whether some betas are values other than 0.

To test if Beta corersponding to midarm (B3) is 5, we can use the test command like before but now use 5 instead of 0.
 Note the estimate of B3 is -2.18606 with a p-value of 0.1896 for testing B3=0.  
Since 5 is farther away than 0 from the estimate, Ho: B3=5, may be significant. */

proc reg data=fat;
model bodyfat=triceps thigh midarm  ;
test midarm=5;
run;


/*And it is with a p-value of .0004.  On the other hand, if we test Ho: B3= -2, the p-value should be about 1.*/

proc reg data=fat;
model bodyfat=triceps thigh midarm  ;
test midarm=-2;
run;

/* and it is .9 */


/* To test if B1=B2, we can simply use
*/
proc reg data=fat;
model bodyfat=triceps thigh midarm  ;
test triceps = thigh;
run;
