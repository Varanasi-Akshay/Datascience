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




/* To do the BF test of constant variance, we need to break the data into two groups: 
low lot sizes and high lot sizes */


proc means 	data=toluca mean; 
var lotsize;
run;


/* The mean of the lots sizes is 70.  
The code below creates a new variable called "xlevel" with two levels:low and high.
If the lotsize is greater than 70, the observation is placed in xlevel high.
If the lotsize is less than or equal to 70, the observation is placed in xlevel low.

*/

data toluca3; set toluca; 
if   LotSize gt 70 then xlevel= "high";
else if   LotSize le 70 then xlevel= "low";  
run;

proc print data=toluca3; run;


/* Next we need to get the deviations of the residuals from their group median.  To do so 
we need to get the residuals and then we will calculate the median of the residuals of each group.

First we need the residuals.
*/
proc reg data=toluca3;
 model WorkHrs = LotSize; OUTPUT OUT=results3 r=residuals3 ;
 run;
quit;

proc print data=results3; run;


/* To calculate the medians, we will use proc means again.  In order to get the medians
calculated, we need to put the command "median" in the proc statement.

The CLASS statement names the variable that classifies the data set into groups.  
It is the categorical variable whose levels we are interested in.
Here we use xlevel after the class command because we want the median of
the two levels of xlevel: low and high.

The command "var" gives the continuous variable we are getting descriptive statistics of.  Thus we
use residuals3 after the var command, thus we get the median of the variable residuals3 for all
levels of the variable xlevel.

Suppose we want to compare mean weight of subjects on either an Atkins or KrispyKreme diet, then the class
variable is diet and var variable is weight. That is, we are getting the mean of weight, 
so weight follows the var command, for both diets, so diet follows the class command.

Here, we want the median for both groups of residuals3.	
Thus xlevel follows the class command and residual3 follows the var command


*/

proc means data=results3 median; 
class xlevel; 
var residuals3;  
run;



/* median of group1  -19.8759596
median of group 2  -2.6840404
Now we get the deviations of the residuals from their group median.
We then get the absolute value for each of the devaitions.
*/

data results4; set results3; 
if xlevel="low" then deviation= residuals3 - (- 19.88); 
else if xlevel="high" then deviation= residuals3 - (- 2.68); 
absdeviation = abs(deviation);

run;

proc print data=results4; run;


/*

At this point we can do a t test of the absolue deviations.  We are testing if the mean 
of the absolue deviations of xlevel low is the same as the mean of the absolute deviations
of xlevel high.

To do this, we use proc ttest.  The class tells what group means we are testing and
the var command tells the mean of what variable.  For example, if we were testing the mean 
weight of subjects on Atkins to the mean weight of subjects on a KrispyKreme diet, 
then the class variable is diet and var variable is weight. That is, we are testing if the 
mean weight, so weight follows the var command, is the same for both diets, so diet follows the class command.

Here we are testing if the xlevels have the same mean absolute deviation.

*/

proc ttest 	data=results4; 
class xlevel;
var  absdeviation;
run;


/* We are using the pooled method and the p-value for testing if this assumption
is valid is .2  so we do not reject that we have constant variances.
*/


/* We can also do this as an ANOVA, which allows us to use more than 2 groups if need be.
The model F in this ANOVA is the F statistic for the Brown-Forsythe test, which is the same as the t squared.
We are testing if the mean of the deviations of xlevel=low 
is the same as the mean of the deviations of xlevel=high.

The t statistic is -1.32 and -1.32^2 is 1.74.  Here Model F is 1.73.*/

proc glm data=results4; 
class xlevel;
 model  absdeviation= xlevel;
 run;
quit;






/* Equivalently, we can use the HOVTEST command with the BF option.  The command
goes after the means command where the variable after the means command are the
groups we are comparing.  Here that is xlevel.
Here the residuals are the response and xlevel is the independent variable. 

 The HOVTEST stands for “homogeneity of variances test” and the BF stands for “Brown and Forsythe”. 

So this goes in and gets the absolute deviations and tests if the means of
the absolute deviations are the same for both groups

Note, here we are entering the residuals and using the HOVTEST command.
Before, we entered the absolute deviations and ran a ttest or ANOVA on them, testing if the means were the same
for the different groups. */


proc glm data=results3;
class xlevel;
 model residuals3 = xlevel;
 means xlevel/HOVTEST= bf
;
 run;
quit;

