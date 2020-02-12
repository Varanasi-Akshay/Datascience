* To write out comments, we can use;

/* Or we can use.  This way can contain semicolons.
   */

/* There are 3 windows in SAS: the editor window, the log window, and the output window.
The editor window has been saved as SAS1.  It is where we type our commands.  It is color
coded to let us know when a word is a command (blue), when we are entering data (yellow), etc.
This also allows us to know when we make mistakes, such as when a command is in black and not blue.

The output window displays the results and the log displays what SAS has just done.  The log is where we look
when we need to trouble shoot.  There will be red and green writing where SAS has problems.   For example, I will try
and print the data set toluca.  We haven't created it yet so this will give us an error in the log.
(we will learn about creating datasets and printing them later, this is just an
example of using the log).
*/

proc print data=toluca; 
run;





/*Before we run any descriptive statistics or analysis, we need to create a data file.  
To do this we use commands such as:  */ 

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
It is very important to end each line of command with a “;”.  A line of command can physically be on more than one 
line but they must end with a “;”
 
The first line is naming our data file; “Data  filename”.  Here we named it “toluca”.  When we want to run an analysis,
we will run it on this data file.  The second line uses the “input” command to name our variables.  
Here we have two variables, Lotsize and workhours.

Thus we use the command “input  Lotsize workhours;” to name our variables. The third line, “cards ;”, 
tells SAS we are going to enter the data. We then enter the values of the variables for each observation,  
we don’t use a  “;” after every data line but after we enter the entire data, we end it with a “;” .   
At the end of any procedure, we end it with “run:”.  Note, we still need to highlight what we want 
to run and hit F3 or click the running man to get the code to run.

If we have categorical variables, we use a dollar sign after the variable name. 
For example, if we also had gender in the model, we would write

data toluca;
  input LotSize WorkHrs gender$;
cards;
   80  399 m
   30  121 f
   50  221 m
   90  376 m
   70  361 f
   60  224 f
  120  546 m
;
run;

*/



/*

To run an analysis in SAS, we use proc commands.  For example to do an ANOVA, we use proc anova, 
to do a regression, we use proc regression, or to print the data we use proc print.  

First, we will print the data set that we have created. We start by stating which proc we are using,
"proc print".  Then we state what data set we want to run the proc on, "data=toluca;".

Note, when we created the data set we used "data toluca" with NO "=" sign.
When running a proc on this datafile, we use "data=toluca" with a "=" sign.

For proc print, all we need to include after the proc command line is the run command.
Often, we will use multiple command lines.

The code looks like	*/



proc print 	data=toluca;
run;



/*We will start by making a scatter plot to see if we have a roughly linear relationship.  

We use proc gplot make our plots.  The first statements are telling how we want the plot to look.
There is only 1 x*y plot, so we only have 1 symbol (the symbol1 command).  Sometimes, we will need multiple
symbols, such as if we are plotting workhours by lotsize for both women and men and have two plots on the same graph.  
The v=circle says to make the data points circles and c is color.  There are other options such
as i= join tells SAS to connect the points with a line.

Within proc gplot, we use plot Y*X.  This creates a plot of Y by X.*/

symbol1 v=circle   c = black;
PROC GPLOT DATA=toluca;
PLOT WorkHrs*LotSize;
RUN;





/* 	

To run a regression model and get least square estimates, we can use proc reg.

The model command tells SAS we are going to enter the model equation.  It follows the form
Model Y = X.  

If there are more than 1 predictor variables, we use Model Y = X1 X2


The output includes the least squares estimates.  Note, since X1 is named LotSize, b1 will
be the parameter estimate that corresponds with LotSize
*/

proc reg data=toluca;
 model WorkHrs = LotSize ;
 run;

/*

To plot the regression fit.

We will rerun proc reg but this time we will output a file that contains the predicted value of work hours 
(the fitted value) for each lot size.  Then we will plot them on the same picture as the scatterplot.


The "output" statement in the reg porcedure tells SAS to output a data set, which we name following the "out" command.
Here, we named the output file "results".
In general, we use 

"output out=name we choose".

The p command is where we tell SAS to inluce the predicted values of work hours 
 and we named them "predicted_WorkHrs".
In general it is p = "name we choose".

*/



proc reg data=toluca;
 model WorkHrs = LotSize ;
output 	out=results p=predicted_WorkHrs;
 run;
quit;

/* Just to see what the output file we created looks like, we will print it using proc print*/

proc print data=results; run;


/* Here we plot both the data points, workhours by Lotsize, and the predicted workhours (the fitted values)
by LotSize.  We connect the points for the predicted workhours (the fitted values) to make our regression line, 
thus we use i=join after symbol2.	 The overlay command tells SAS to put both plots in the same frame.

*/

symbol1 v=circle l=32  c = black;
symbol2 i = join v=star l=32  c = black;
PROC GPLOT DATA=results;
PLOT WorkHrs*LotSize predicted_WorkHrs*LotSize/ OVERLAY;
RUN;





 
