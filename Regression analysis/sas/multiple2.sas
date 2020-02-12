/* 1 is bad diet, 0 is good diet*/

data bp;  input  bloodpressure age diet;
cards;
142  20 1
148  25 1
160 30 1
171 35 1
179 40 1
189 45 1
117 20 0
128 25 0
137 30 0
150 35 0
159 40 0
170 45 0
;
run;


proc glm data=bp;
model bloodpressure=age diet/solution;
output out=resultsd p=predictedsd;
run;


symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=star l=32  c = red;
PROC GPLOT DATA=resultsd;
PLOT predictedsd*age=diet ;
RUN;





data bpplot;  input  bloodpressure age diet$;
cards;
140  20 bad
150  25 bad
160 30 bad
170 35 bad
180 40 bad
190 45 bad
120 20 good
130 25 good
140 30 good
150 35 good
160 40 good
170 45 good
;
run;

symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=star l=32  c = red;
PROC GPLOT DATA=bpplot;
PLOT bloodpressure*age=diet ;
RUN;








data bpplot2;  input  bloodpressure age diet$;
cards;
140  20 bad
165  25 bad
190 30 bad
215 35 bad
240 40 bad
265 45 bad
120 20 good
130 25 good
140 30 good
150 35 good
160 40 good
170 45 good
;
run;

symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=star l=32  c = red;
PROC GPLOT DATA=bpplot2;
PLOT bloodpressure*age=diet ;
RUN;
















/* This is an example of a fisrt order regression model with two predictors (NO Intercation) with one
of the varaibles a qualitative variable (gender).  It can be run as a regression by coding gender as a 1 for females
and 0 for males.

it could also be run as an ANCOVA, with gender a categorical varaible. */

/* as a regression with gender continuos - 0 or 1*/

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

/* we run the model the same as before, listing both variables in teh model statement.
Here we use GLM.  Teh solution command tells it to give teh eestimates of the Betas*/


proc glm data=stays;
model stay=age gender/solution;
output out=resultsmm p=predictedsmm;
run;



/* as an ANCOVA with gender as categories - male or female
*/


data stayes; input stay age gender$;
cards;
10  10 f
14  15 f
20 20 f
26 25 f
30 30 f
35 35 f
31 10 m
36 14 m
42 21 m
46 27 m
51 30 m
57 34 m
;
run;

/* here we run the model but need to include the class statement to tell that gender is a categorical variable.
The lsmeans statement tells it to give the means of gender*/


proc glm data=stayes;
class gender;
model stay=age gender/solution;
lsmeans gender; 
output out=resultsm p=predictedsm;
run;


/* NOTE THE RESULTS ARE EXACTLY THE SAME EITHER WAY WE RUN THE MODEL.  IGNORE Warning statement.  
That can happen when you make up data. */

/*We will not plot the fitted responses across the levels of age for both genders. This is done by using
the format plot y*x=z.  This makes a plot of y*x at every level of z, here we use plot predictedsmm*age=gender, which
gives a plot of the fitted values against age for both levels of gender */



/* Note they are two parallel lines.  When ther is no interaction, the lines are pararlel, they just have different intercepts.
The beta for age gives the slope of both lines.  The intercept and the beta for females (when the varaible is 1) is the intercept forfemales
and the intercept for males is just the intercept (when gender is 0.

Note, continuos variables efefct the slope and categorical variables effect the intercept.  Even though we coded gender
as a continuos variable, 0 or 1, it is still categorical.  Making it 0 or 1 is just a way to fit it into a regression model. */ 
