/* First we create a data set that is curvilinear.
based on E{Y} = 2 + 3*X + 2*X^2
*/


data curve; input y x;
cards;
-34.7872661  -5
-22.2886469  -4
-9.4901800   -3
-2.1693518   -2
-0.7365807  -1
-1.1507103 0
 -5.6643624	1
-14.2395147	2
-28.0217443  3
-44.6212851  4
-66.8418882	5
;
run;

/* Now we fit the model with a linear regression and plot the fit over the observations*/

proc reg data=curve;
 model y = x ;
OUTPUT 	out=results p=predicteds;
 run;
quit;

/* Note r-square is .227*/

symbol1 v=circle l=32  c = red;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results;
PLOT y*x predicteds*x/ OVERLAY;
RUN;

/* Now we fit the model with a quadratic regression and plot the fit over the observations*/

/* To have a quadratic term x^2 in the model, we need to create this variable.

*/

data curve2; set curve; x2=x*x; run;


proc reg data=curve2;
 model y = x x2 ;
OUTPUT 	out=results2 p=predicteds2;
 run;
quit;

/*Now the r-squared is .9987*/

symbol1 v=circle l=32  c = red;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results2;
PLOT y*x predicteds2*x/ OVERLAY;
RUN;


/*The general linear F statistic equals SSE(R) - SSE(F)/ df(R) - df(F)/ SSE(F)/df(F)

SSE(F) is the SSE for the full model - using the quadratic term.  Here SSE(F)= 5.90882
df(F) = n-3= 11-3=8.

SSE(R) is the SSE for the reduced model - NOT using the quadratic term.  Here SSE(R)=  3457.20062

df(R) = n-2= 11-2=9

Thus F = ((3457.20062-5.90882)/(9-8))/(5.90882/8) = 4672.732

The t statistic for the t test for Beta2 in the full model is  -68.36 and we have that 
sqrt(4672.732)=68.36.

Thus testing if the reduced model with just the linear term is sufficent is 
the same as the test for Beta2=0 we get when we run the full model.






/* TRANSFORMATIONS */

/* We start with transforming nonlinear data with constant variance and normal errors*/


data trans; input days score;
cards;
.5 42.5
.5 50.6
1 68.5
1 80.7
1.5 89
1.5 99.6
2 105.3
2 111.8
2.5 112.3
2.5 125.7
;
run;


/* We fit the model to the original data and make a scatter plot with the fit imposed on it*/


proc reg data=trans;
 model score =days ;
OUTPUT 	out=results3 p=predicteds3;
 run;
quit;

/* Note now r-squared is .9256*/

symbol1 v=circle l=32  c = red;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results3;
PLOT score*days predicteds3*days/ OVERLAY;
RUN;


/* Now making the transformation on a new dataset called trans2.  */

data trans2; set trans; days2=sqrt(days);
run;


/* We fit the model to the transformed data and make a scatter plot with the fit imposed on it*/

proc reg data=trans2;
 model score =days2 ;
OUTPUT 	out=results4 p=predicteds4 r=residuals4;
 run;
quit;

/* Now r-squared is .9545*/

symbol1 v=circle l=32  c = red h=1;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results4;
PLOT score*days2 predicteds4*days2/ OVERLAY;
RUN;




/* To check fit of the transformed data, we make a residual plot (to verify constant variance as well as double
check linearity. */

proc gplot data=results4; plot residuals4*days2 ; run;


/* To check fit of the transformed data, we make a normal probability plot to verify normality of error terms. 

 This one makes a nicer plot.*/

Proc univariate data=results4 ; qqplot residuals4/NORMAL(MU=EST SIGMA=EST COLOR=RED L=1); run;


/* This one gives tests statistics tests of normaility */

proc univariate data=results4 plot normal	 ;
	var residuals4
; run;







/*WE NOW TRANSFORM NONNORMAL DATA WITH NONCONSTANT VARIANCE*/

data kids; input age plasma;
cards;
    0  13.44  
    0  12.84  
    0  11.91 
    0  20.09  
    0  15.60  
  1.0  10.11  
  1.0  11.38  
  1.0  10.28  
  1.0   8.96   
  1.0   8.59   
  2.0   9.83   
  2.0   9.00   
  2.0   8.65   
  2.0   7.85   
  2.0   8.88   
  3.0   7.94  
  3.0   6.01   
  3.0   5.14   
  3.0   6.90   
  3.0   6.77   
  4.0   4.86   
  4.0   5.10   
  4.0   5.67   
  4.0   5.75   
  4.0   6.23   
  ;
  run;




  
/* We fit the model to the original data.*/


proc reg data=kids;
 model plasma =age ;
OUTPUT 	out=results5 p=predicteds5 r=residuals5;
 run;
quit;

/* Note now r-squared is .7532.  We plot the residuals against X*/

symbol1 v=circle l=32  c = red;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results5;
PLOT residuals5*age ;
RUN;

/* It is clear that there are larger variances at lower levels of age(X) and a curvilinear relationship.  
Next we test normaility.
*/
proc univariate data=results5 plot normal;
	var residuals5
; run;

/* The tests of normality are significant (or close) and we reject that we have normality*/


/* Now making the transformation.  

Here, we are keeping the same dataset but adding the transformed variable to it. 
Note, to make a natural  log transformation, use log(plasma).  
We used log10(plasma) to do a log ten based transformation.*/

data kids; set kids; plasma2=log10(plasma);
run;


/* We fit the model to the transformed data and make a scatter plot with the fit impose on it*/


proc reg data=kids;
 model plasma2 =age ;
OUTPUT 	out=results6 p=predicteds6 r=residuals6;;
 run;
quit;

/* Now r-squared is .8535*/

symbol1 v=circle l=32  c = red;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results6;
PLOT plasma2*age predicteds6*age/ OVERLAY;
RUN;




/* To check fit of the transformed data, we make a residual plot (to verify constant variance as well as
check linearity. */

proc gplot data=results6; plot residuals6*age ; run;

/*Next we test normaility. */

proc univariate data=results6 plot normal	 ;
	var residuals6; run;

/* After the transformation, the tests of normaility are no longer significant.*/
