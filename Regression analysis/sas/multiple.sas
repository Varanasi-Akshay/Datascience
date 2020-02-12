

/* We consider a model where length of hospital stay is the response and gender and age are
the predictors.  This is an example of a first order regression model with two predictors (no interaction) with one
of the varaibles a qualitative variable (gender).  It can be run as a regression by coding gender as continuos
with a 1 for females and 0 for males.



/* As a regression with gender continuos: 0 or 1*/

data stays; input stay age gender;
cards;
10  10 1
14  15 1
20 20 1
26 25 1
30 30 1
35 35 1
31 10 0
36 14 0
42 21 0
46 27 0
51 30 0
57 34 0
;
run;

/* We run the model the same as before, listing both variables in the model statement.
We can use GLM or reg.  */


proc reg data=stays;
model stay=age gender;
output out=resultsmm p=predicted_stay;
run;


proc glm data=stays;
model stay=age gender;
run;


/*We will now plot the fitted responses across the levels of age for both genders. This is done by using
the format plot y*x=z.  This makes a plot of y*x at every level of z, here we use plot predicted_stay*age=gender, which
gives a plot of the fitted values against age for both levels of gender */



symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=star l=32  c = red;
PROC GPLOT DATA=resultsmm;
PLOT predicted_stay*age=gender ;
RUN;

/* Note they are two parallel lines.  When there is no interaction, the lines are parralel, they just have 
different intercepts.  The beta for age gives the slope of both lines.  The intercept and the beta for 
females  is the intercept for females (when gender is 1) and the intercept for males is just the 
intercept (when gender is 0).

Note, continuos variables effect the slope and categorical variables effect the intercept. 
Even though we coded gender as a continuos variable, 0 or 1, it is still categorical.  
Making it 0 or 1 is just a way to fit it into a regression model. */ 
