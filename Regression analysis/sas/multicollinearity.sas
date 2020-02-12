data cement; input x1 x2 x3 x4 y;
cards;
7 26 6 60 78.5 
 1 29 15 52 74.3
11 56 8 20 104.3 
11 31 8 47 87.6 
7 52 6 33 95.9
11 55 9 22 109.2
3 71 17 6 102.7
1 31 22 44 72.5
2 54 18 22 93.1
21 47 4 26 115.9
1 40 23 34 83.8
11 66 9 12 113.3
10 68 8 12 109.4
;
run;

/* To generate the correlations of variables in a dataset, we can use proc corr*/
proc corr data=cement;run;
/* We can see the high negative correlation between x1 and x3 as well as between x2 and x4. */
 
/* Along with the overall F test, GLM will give us the type 1 SS, the type 3 SS, and t-tests.  
The t-tests are equivalent to the type 3 SS. */

proc glm data=cement;
model y=x1 x2 x3 x4;
run;

/* Looking at the type 1 sums of squares, both x1 and x2 are significant but not x3 or x4.
None are significant with the type 3.  That is even though the overall F test is significant, none of the type 3 SS or 
t tests are significant.  The type 1 SS are significant for X1 and X2, since they test the variables before taking 
into account x3 and x4.

We now put x3 and x4 in first.*/

proc glm data=cement;
model y=x3 x4 x1 x2;
run;

/* Looking at the type 1 sums of squares, both x3 and x4 are significant but not x1 or x2.
The type 1 SS are significant for x3 and x4, since they test the variables before taking 
into account x1 and x2.
None are significant with the type 3.*/



/* Because of the correlation between x2 and x4, 
neither will be significant given the other variable is in the model.


/* Looking at a model with just x2 */

proc glm data=cement;
model y=x2 ;
run;
/* The p-value for b2 = .0007
The estimate b2 is .79
The se(b2) is .168 
MSE is 82.4
*/


/* Now we also include x1 with x2*/


proc glm data=cement;
model y= x1 x2 ;
run;


/* The p-value for b2 < .0001
The estimate b2 is .66  
The se(b2) is .046.
MSE is 5.790448

So we have more power with x1 also in model, which is because both explain different variation in Y
(the correlation  bewteen x1 and x2 is only .23).
Thus, using both reduces error and note the MSE is now only 5.79 when it was 82.4 with just x2 in the model. 
This in turn reduces the se(b2)which is estimated by MSE(X’X)-1
Also, the estimate b1 is 1.47.
*/




/* Now we will include x4 with x2*/


proc glm data=cement;
model y=x4 x2 ;
run;

/* 
The p-value for b2 =.69
The estimate b2 is .31  
The se(b2) is .75.
MSE is  86.888013


The variation that is explained by x2 has already been explained by having x4 in the model and vice versa.
As a result of  multicolineraity, the standard error se(b2)is much larger.
It was .168 with just x2 in the model.  Thus the p-value is larger and no longer significant.

If we looked at the standard error se(b4) for this model and one with just x4, we would see similiar results.


Note, neither are significant, except for looking at the Type 1 sums of squares for x4.  
The type 1 SS for X4, which shows that the effect of x4 before x2 is in the model, is significant.
But the t test or the type 3 SS shows that with x2 in the model, X4 is not significant.

So, as a result of multicolineraity, neither x2 nor x4 are significant when both are in the model,
even though both are significant when they are the only predictor in the model.


The MSE actually gets larger than when it is just x2 in the model.  Note, the SSE does get smaller when we add
x4, it goes from 906.336344 to 868.880131, but the df also get smaller, going from 11 to 10.  As such,
the MSE goes up when we add x4 to the model with x2 already in it.  As a result of the correlation between
x2 and x4, the drop in the SSE is very small.

*/







/* VIF*/

/* To get the VIF values for each predictor, we need to use proc reg.  


The t-tests that are produced are equivalent to type 3 ss, where each predictor is evaluated given
the others are in the model*/

proc reg data=cement;
model y=x1 x2 x3 x4/   vif;
run;

/* Note that the VIF values are very large.  The typical cutoff is 10.  
To see how the VIF values are calculated, we will run teh regression with x1 as
the response and x2,x3,x4 as the predictors. */

proc reg data=cement;
model x1= x2 x3 x4 ;
run;


/* Here R sqaured is  0.9740.  Thus the VIF for X1 equals 1/(1- 0.9740)=38.46 (slightly different due to rounding).

/* Looking at the VIF values with only X1 and X2 in the model*/

proc reg data=cement;
model y=x1 x2 /   vif;
run;

/* The VIF values with only X1 and X2 are small.  That is because x1 was correlated with x3 and
x2 was correlated with x4.


Note also, the rsquared goes from 0.9824 with all 4 in the model to 0.9787 with just x1 and x2 in the model.
Thus very little variation that was not already explained by x1 and x2 is explained by adding x3 and x4.
