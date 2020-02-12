

data weight; input age bloodpr;
cards;
27   73
  21   66
  22   63
  24   75
  25   71
  23   70
  20   65
  20   70
  29   79
  24   72
  25   68
  28   67
  26   79
  38   91
  32   76
  33   69
  31   66
  34   73
  37   78
  38   87
  33   76
  35   79
  30   73
  31   80
  37   68
  39   75
  46   89
  49  101
  40   70
  42   72
  43   80
  46   83
  43   75
  44   71
  46   80
  47   96
  45   92
  49   80
  48   70
  40   90
  42   85
  55   76
  54   71
  57   99
  52   86
  53   79
  56   92
  52   85
  50   71
  59   90
  50   91
  52  100
  58   80
  57  109
;
run;



/* First we run UNweighted regression and get residuals*/

proc reg data=weight;
model bloodpr=age;
output out= results_w r=residuals_w;
run;


proc print data=results_w; run;


/* Next we need the absolute residuals*/

data results_w2; set results_w; absresid=abs(residuals_w); run;
proc print data=results_w2; run;


/* Now we need to regress the absolute residuals on age and get the fitted values corresponding
to each value of age (x).  These fitted values are the estimated standard deviation for each x.*/

proc reg data=results_w2;
model  absresid=age;
output out=results_w3 p=estimateded_sd;
run; 

proc print data=results_w3; run;


/* The weights are then 1/(estimated_sd)^2 */


data results_w4; set results_w3; wts=1/(estimateded_sd*estimateded_sd); run;
proc print data=results_w4; run;



/* To run weighted regression, we will use proc reg and the weight command.  Following
the weight command, we use the name of the variable we are denoting the weights as.  Here that is "wts".


*/
proc reg data=results_w4 ;
weight wts;
  model bloodpr=age; ;
  run;
