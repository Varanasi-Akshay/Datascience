
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

/*The sequential extra sum of squares described in 7.1 of the book are the type 1 SS produced in SAS.
These are the extra sum of squares for adding one predictor variable, given the others are in the model.

They are produced sequentially, in the order they are listed in the model statement.  
For example, here the Type 1 SS are 
SSR(triceps)
SSR(thigh|tricpes)
SSR (midarm|triceps, thigh)

They are produced in proc reg by adding the ss1	option to the model statement following the "/".
However, only the sums of squares are produced, not the corresponding p-values. 

The t-tests that are produced are equivalent to type 3 sums of squares (explained below).  
The t-tests test each variable given all the other predictors are in the model.
That is, the t-test for triceps tests the effect triceps has, given thigh and midarm are already in the model.


*/

proc reg data=fat;
model bodyfat=triceps thigh midarm/ss1;

run;


/* The Type 1 ss are produced automatically in glm. 
Here the corresponding p-values are also produced.*/

proc glm data=fat;
model bodyfat=triceps thigh midarm;
run;


/* The Type 1 ss p-values are for testing the extra sums of squares.  
They test the effect of one variable given the others are in the model.  
That is, they test the effect of one variable after taking into account what is explained by
the variables already in the model.



Thus
SSR(triceps) tests if triceps has an effect
SSR(thigh|tricpes)   tests if thigh has an effect given triceps is in the model.  That is, this tests
if thigh has an effect after taken into account what has already been explained by triceps.


SSR (midarm|triceps, thigh)	tests if midarm has an effect given triceps and thigh are in the model.
That is, this tests	if midarm has an effect after taken into account what has already been explained
by triceps and thigh.


/* Another type of extra sums of squares are type 3 (Type III) SS.  These give the extra sum of squares for 
adding a predictor varaible, given  all the other varaibles are already in the model.  
This is regardless of what sequence the variables are in.  Here the Type III SS are 

SSR (triceps|thigh,midarm)
SSR (thigh|triceps,midarm)
SSR (midarm|triceps, thigh)


They are not produced in proc reg but are a part of the output for glm.
And again note, these are equivalent to the t-tests that are produced.*/

