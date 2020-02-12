data toluca;
  input obs LotSize WorkHrs;
cards;
   1 80  399
   2 30  121
   3 50  221
   4 90  376
   5 70  361
   6 60  224
  7 120  546
   8 80  352
  9 100  353
  10 50  157
   11 40  160
   12 70  252
   13 90  389
   14 20   113
  15 110  435
  16 100  420
   17 30  212
   18 50  268
   19 90  377
  20 110  421
   21 30  273
   22 90  468
   23 40  244
   24 80  342
   25 70  323
;
run;

/* LECTURE 17*/


/* To start with, we cam make a scatter plot to verify that we have a linear relationship
but this is not the best method

*/

symbol1 v=circle   c = red;
PROC GPLOT DATA=toluca;
PLOT WorkHrs*LotSize;
RUN;


/* To perform the diagnostics, we need to run the model and obtain our residuals and predicted values.
Again, we do this by outputting a new file with the output out="filename" command and including
"p=name of predicted values" and "r=name of residuals".

*/
 
proc reg data=toluca;
 model WorkHrs = LotSize; 
OUTPUT OUT=results p=predicted_WorkHrs r=residuals ;
 run;
quit;

proc print data=results; run;




/* 
Linearity: 
To check assumption of linearity, we plot the predictor variable against the residuals.  
If we have linearity, we should get a random scatter about 0*/


proc gplot data=results; plot residuals*LotSize ; run;


/* We can also plot the fitted values against the residuals too check the assumption of linearity */
proc gplot data=results; plot residuals*predicted_WorkHrs ; run;


/* an example of a curve relationship between X and Y*/
data curve; input x y; 
cards;
 2 5
 1 2
 4 15
 3 10
 5 24
 5 26
 10 101
 8 62
 ;
run;


proc reg data=curve;
 model y=x;OUTPUT OUT=residscurve p=predicted_curve r=residualscurve ;
 run;



 proc gplot data=residscurve; plot residualscurve*x ; run;

quit;







/*
Constant Variance:

We use the same residual plots to check the assumption of constant variance.  If there is constant variance
then again the residuals should form a random scatter around 0.  If the variance increases or decreases as X gets
larger, the residuals will form a funnel shape.  Our original data looked fine.  We wil create a 
new data set that does not have constant variance for an example.*/

data nocon; input  y x;
cards;
1.08 1
2.56  2
3.04   3
2.62  4
5.90  5
2.28  6
1.06 7 
9.74  8
14.22 9
-3.20 10
;
run;





proc reg data=nocon;
 model y=x;OUTPUT OUT=residsnocon p=predicted_nocon r=residualsnocon ;
 run;



 proc gplot data=residsnocon; plot residualsnocon*x ; run;

quit;






/* Checking for outliers.

We can use standardized residuals to help determine if there are any outliers.
A rule of thumb is that standardized residuals with an absolute value of four or more correspond with outliers. 
 To get standardized residuals, we include "Student=name of standardized residuals".


*/

proc reg data=toluca;
 model WorkHrs = LotSize ; 
OUTPUT OUT=results_stan p=predicted_WorkHrs r=residuals Student=standardized_residuals;
 run;
quit;

proc print data=results_stan; run;

proc means data=results_stan; 
var standardized_residuals;
 run; 

/* Residual plot using standardized residuals*/


proc gplot data=results_stan;
plot  standardized_residuals*LotSize;
run;


/* None of the absolute values of the standardized residuals are greater than 4 so we conclude there
are no outliers. */








/* LECTURE 18 

/*Checking for independence of error terms.

To visually inspect for independence, we will create a sequence plot of the residuals over time.
To do so, we need to include a variable in our dataset that indexes the order the values were collected in.*/  


data toluca_seq;
  input obs LotSize WorkHrs;
cards;
   1 80  399
   2 30  121
   3 50  221
   4 90  376
   5 70  361
   6 60  224
  7 120  546
   8 80  352
  9 100  353
  10 50  157
   11 40  160
   12 70  252
   13 90  389
   14 20   113
  15 110  435
  16 100  420
   17 30  212
   18 50  268
   19 90  377
  20 110  421
   21 30  273
   22 90  468
   23 40  244
   24 80  342
   25 70  323
;
run;

proc reg data=toluca_seq;
 model WorkHrs = LotSize; 
OUTPUT OUT=results_seq r=residuals_seq ;
 run;
quit;

/* We then plot the residuals by the obs, which was the variable in our dataset that indexes the order the values were
collected in.*/

proc gplot data=results_seq;
plot  residuals_seq*obs;
run;

/* It is clear there is no time (sequence) effect here*/








/*
Noramility:

Graphical check of normality 

To verify the assumption of normality, we can use proc univariate.  Note, it is the residuals
that are the variable we are interested in (here named residuals_seq).  We want to plot and
test if the residuals are normal.


The command "plot" produces stem and leaf plots, boxplots, and normal probability plots of the residuals.
A better graphical tool uses the qqplot command.  The qqplot command tells SAS to produce the q-q plots.
Specifying MU=EST and SIGMA=EST with the NORMAL primary option 
requests the reference line for which the mean and standard deviation are estimated 
by the sample mean and standard deviation.

Again, we are doing this on the residuals (here named residuals_seq). 

(There is also a lot of other output which we are not interested in now)

*/
Proc univariate data=results_seq plot; 
qqplot residuals_seq/NORMAL(MU=EST SIGMA=EST COLOR=RED L=1); run;




/* 	
Formal test of normality 

To do a formal test of normality, we use the "normal" option within proc univariate, which
produces formal tests of normality.

And note, the variable we are running these tests on is the residuals.

*/


proc univariate data=results_seq  normal;
var residuals_seq;
run;





