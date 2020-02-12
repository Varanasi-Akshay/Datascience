
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



/* To include interaction in GLM between X1 and X2, you inlude the crossproduct term X1*X2 in the model statement.

Note below is pre-centering*/

proc glm data=fat;
model bodyfat=triceps thigh midarm triceps*thigh triceps*midarm  thigh*midarm ;
run;

/* To check the correlations, we actually need to create the interaction terms which are the crossproducts. 
To do this, we will create a new data set.  The command "set datafile" tells SAS to bring up a datafile so we can
make changes to it for our new datafile.  Here we bring up our old data and then create a new datafile with
the crossproducts on it.*/


data fat2; set fat; triceps_thigh = triceps*thigh; 	triceps_midarm = triceps*midarm;  thigh_midarm = thigh*midarm; 
run;

/* Note running the model with the new variables created by the crossproducts produces the exact same results*/

proc glm data=fat2;
model bodyfat=triceps thigh midarm triceps_thigh triceps_midarm  thigh_midarm ;
run;

/* We can use proc corr to check the correlations between the predictors and the interaction terms
as well as among the interaction terms themselves*/


proc corr data=fat2; var  triceps thigh midarm triceps_thigh triceps_midarm  thigh_midarm ; run;
/* The correlation between triceps and triceps_thigh is .989 and the correlation between
triceps_midarm  and thigh_midarm is .998.

Thus we will use proc means to get the means and center our predictors. In the opening command line, we list what
statistics of the variables we wish to obtain.  Here we list mean for mean and std for standard deviation (just
for an example, we don't need the standard deviation).  A full list of options that can be produced can be found at 
the link below.

http://support.sas.com/documentation/cdl/en/proc/61895/HTML/default/a000146734.htm
*/

proc means mean std; var triceps thigh midarm; run;

 /* mean of triceps is 25.305      
         mean of  thigh is  51.17 
        mean of  midarm is 27.6200000

Now we create the centered data*/

data fat3; set fat; 
triceps2=triceps - 25.305; 
thigh2= thigh - 51.17;
midarm2 = midarm-27.62;
triceps2_thigh2 = triceps2*thigh2; 	triceps2_midarm2 = triceps2*midarm2;  thigh2_midarm2 = thigh2*midarm2; 
run;


/* Now we can check the correlations on the centered data.*/

proc corr data=fat3; var  triceps2 thigh2 midarm2 triceps2_thigh2 triceps2_midarm2  thigh2_midarm2 ; run;
/* The correlation between triceps2 and triceps_thigh2 is  -0.47701 and the correlation between
triceps2_midarm2  and thigh2_midarm2 is .891*/

/* Now we can run the model on the centered data.  We can do it two ways.  Either using terms like tricpes2*midarms2 and 
telling SAS to create the crossproducts or using the ones we already created.  It is exactly the same.
*/

proc glm data=fat3;
model bodyfat=triceps2 thigh2 midarm2 triceps2_thigh2 triceps2_midarm2  thigh2_midarm2 ;
run;


/* OR*/

proc glm data=fat3;
model bodyfat=triceps2 thigh2 midarm2 triceps2*thigh2 triceps2*midarm2  thigh2*midarm2 ;
run;

/* The sums of squares that we need to create the extra sums of squares to test if any interaction terms
are needed is
SSR(x1 x2,x1x3,x2x3| x1,x2,x3) = 
SSR(x1x2| x1,x2,x3) + SSR(x1x3| x1, x2, x3, x1 x2) + SSR(x2x3| x1, x2, x3, x1x2,x1x3)
are found in the Type I SS.


  1.4957180	+ 2.7043343	+ 6.5148360	=10.71489 
The df are the difference in the number of betas = 3
So F = 10.71489/3 / MSE =  3.57163  /6.7453846 =.53



We can also test this directly using the test command in proc reg.  Note when
using proc reg, we have to use the variables that we created for the interaction terms.


*/


proc reg data=fat3;
model bodyfat=triceps2 thigh2 midarm2 triceps2_thigh2 triceps2_midarm2  thigh2_midarm2 ;
test   triceps2_thigh2=triceps2_midarm2 =thigh2_midarm2=0;
run;


/* We could have also centered our variables in proc standard by setting the mean to 0 and 
not adjusting the variance.	 Then we will create our centered
interaction terms and running the full model.  We will again use the test command to test 
if any interaction terms are needed.  The results are the exact same.
*/

proc standard data = fat mean=0 out=fat4;
	var triceps thigh midarm;
run;


data fat5; set fat4;
tri_thigh=triceps*thigh;
tri_midarm=triceps*midarm;
midarm_thigh=midarm*thigh; run;



proc reg data=fat5;
model bodyfat=triceps thigh midarm tri_thigh tri_midarm midarm_thigh ;
test  tri_thigh=tri_midarm =midarm_thigh=0;
run;




