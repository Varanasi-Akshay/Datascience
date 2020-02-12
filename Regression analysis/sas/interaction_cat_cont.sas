
data bp; input bloodpressure age gender;
cards;
150 20 1
165 28 1
189 38 1
225 49 1
250 59 1
275 69 1

111 20 0
114 29 0
120 39 0
127 50 0
140 60 0
148 70 0
;
run;



/* To include interaction in Proc glm and mixed between X1 and X2, you inlude the crossproduct term X1*X2
in the model statement.

*/

proc glm data=bp;
model bloodpressure = age gender age*gender ;
run; 



proc mixed data=bp;
model bloodpressure = age gender age*gender ;
run; 


/* To run a model with interaction in proc reg, you first need to create the interaction variable
in your datafile.  The interaction variable between x1 and x2 is simply their cross product.
We can use the set command to do this.*/


data bp2; set bp; agexgender= age*gender; run;





proc reg data=bp2;
 model bloodpressure = age gender agexgender ;
 output out=results_int p=predicted_bp
 run;
quit;



/* Here we plot the predicted values for both men and women.  To do this we use the format Y*X=Z.
This gives the different Y*X plots for each level of Z (on the same figure)*/ 

symbol1 v=circle i = join l=32  c = red;
symbol2 i = join v=star l=32  c = blue;
PROC GPLOT DATA=results_int;
PLOT  predicted_bp*age=gender;
RUN;


/* Notice that gender is not significant.  Clearly there is a difference between the two genders.
When the interaction is significant, you should not look at the individual effects.  They can be misleading
and at best they do not give the full information.   

It is more informative to say men's bloodpressure goes up at a fast rate as they get older and women's
goes up at a slow rate as they get older than to just say bloodpressure goes up as people
get older.  

ALso, the results could be misleading.  Such as to say there is no difference between the genders.
Here, when the age is low, the genders are close together and when age is high the genders are far apart.  
This is more informative and accurate than concluding there is no gender effect.  To say there is no gender effect
is misleading.
*/


/* To test if there is a significant difference between genders at age 33, we 
re-parameterize age by using age2=age-33.  Note, we need to recreate our
age by gender interaction variable as well*/ 

data bp3; set bp; age2=age-33; 	 age2xgender= age2*gender; run;
proc print data=bp3; run;
proc reg data=bp3;
 model bloodpressure = age2 gender age2xgender ;
 output out=results_int2 p=predicted_bp2
 run;
quit;


