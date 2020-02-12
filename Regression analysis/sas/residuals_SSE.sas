
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

/* TO GET RESIDUALS

To get the residuals, we can run proc reg.  We will output a file named results2 that contains the 
residuals.  Again, to output a file, we use "output out=filename". 

The r command is where we tell SAS to include the residuals and we named them "resids".
In general it is "r = name we choose".

Note, that the SSE is included in the output.  It is the error sum of squares.
Still, as an example we will go through, generate the residuals, calculate the squared residuals,
and then sum the squared residuals to give us the SSE.
*/


proc reg data=toluca;
 model WorkHrs = LotSize;
OUTPUT OUT=results2 p=predicted_WorkHrs r=resids ;
 run;


 /*  Note, the SSE is 54,825


/* The residuals can be seen  by printing the file results2. This will show us
 the residual for each observation.  */


proc print data=results2; run;

/*Now we will create a new data file that contains the sqaured residuals.  By using the set command, we tell SAS
to bring up our old data file.  We can then make additions or changes to it for our new
data file.  We create a new variable "residsquared", which equals the residuals squared.
*/

data results3; set  results2; residsquared=resids*resids; run;
proc print data=results3; run;


/*  we will use the proc means to sum up the squared deviations. 
Proc means is used to get descriptive statistics of variables on dataset.
In the opening command line, we list what statistics of the variables we wish to obtain.  
Here we list the sum.  We could also list options such as the mean or
standard deviation.  

A full list of options that can be produced can be found at the link below. In the var command,
we list which varaibles we want the statistics calculated on.  Here we want the sum of the squared residuals, which
we named  "residsquared".


http://support.sas.com/documentation/cdl/en/proc/61895/HTML/default/a000146734.htm
*/

proc means data	=results3 sum; var  residsquared ; run;

/* 	The sum of the squared deviations equals 54825.46, which is what we got for the SSE from the output.
Note that the mse is also part of the output.  This is the SSE divided by its degrees of freedom.  Here,
we have MSE = SSE/df = 	54825.46/23 =  2383.71562.  The df are n-2 and there are 25 observations, so n =25.


The estimate of standard deviation, the squareroot of the MSE, is also part of the output.
It is called ROOT MSE.
*/
