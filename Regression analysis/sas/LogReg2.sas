




/* CATEGORICAL RESPONSES WITH VARIABLES WITH  2 LEVELS	*/

/*In the slides, we have that azt=0 for immediate and 1 for delayed treatment.

Note, SAS orders the levels of a factor by alphabetical order and 
makes the last level of a factor the baseline.  Since delayed comes before immediate, 
immediate is used as the baseline and we have azt=0 for immediate as with the slides.

If we wanted delayed to be the baseline and have azt=0 for delayed, we could label immediate
as a_immediate and then delayed would be the last level of the factor. 

*/



data azt; input race$ azt$ aids$ count;
cards;
white immediate 1 14
white immediate 0 93
white delayed 1 32
white delayed 0 81
black immediate 1 11
black immediate 0 52
black delayed 1 12
black delayed 0 43
;
run;

/* To use categorical variables as explanatory variables in the model, they need to be listed
after the class command.
Since both race and azt are categorical predictors, they are listed here after the class 
command*/

proc genmod data=azt DESCENDING;
freq count ;
class race azt;
   model aids =race azt/dist=bin link=logit;                      
run;






/* ANOVA WITH VARIABLES WITH MORE THAN 2 LEVELS */ 

data babies; input age$ gender$ pizza_yes$ count;
cards;
ababy f	1 50
young f	1 9
zadult f 1 11
ababy m	1 14
young m	1 40
zadult m 1 52

ababy f	0 10
young f	0 48
zadult f 0 51
ababy m	0 49
young m	0 5
zadult m 0 8

;
run;



/* Lets first consider the model without interaction*/


 proc genmod data=babies descending;
   weight count;
   class age gender;
   model pizza_yes =age gender / dist = bin link=logit;
   run;


/* Note, without interaction, the Betas and the corresponding p-values for each predictor are comparing that predictor 
to the baseline level. For example, the p-value for babies is comparing babies to 
adults (the baseline). 

The odds ratio for females over males is exp(-0.9747) = 0.3773055.   The p-value
for testing if the probability of success for women is the same as that for men is <.0001,
so we reject this.


The odds ratio for babies over adults is exp(-.004)	= 0.996008.   The p-value
for testing if the probability of success for babies is the same as that for adults is .988,
so we don't reject this.


The odds ratio for babies over young is exp(-.004-(-.1014))	= 1.102301.   However, we do not have a p-value for this
comparison.  One way to get it, is to make "young" the baseline. */

data babies2; input age$ gender$ pizza_yes$ count;
cards;
ababy f	1 50
zyoung f	1 9
adult f 1 11
ababy m	1 14
zyoung m	1 40
adult m 1 52

ababy f	0 10
zyoung f	0 48
adult f 0 51
ababy m	0 49
zyoung m	0 5
adult m 0 8

;
run;



 proc genmod data=babies2 descending;
   weight count;
   class age gender;
   model pizza_yes =age gender / dist = bin link=logit;
   run;


/*  The odds ratio for babies over young is exp(.0975) = 1.102411 (the same except for rounding).  But
   now we have the p-value for this comparison, which is .7243.





To get the p-values for all the pairwise comparsions, as well as the least squares means,
   we use the command "lsmeans variable_name/pdiff;	". 

   */
    proc genmod data=babies descending;
   freq count;
   class age gender;
   model pizza_yes =age gender / dist = bin link=logit;
   lsmeans gender/pdiff;
   lsmeans age/pdiff;
   run;




/* To include the interaction between two factors in our model, we include a term that
is a cross-product of the two factors:  factor1*factor2. Here that is age*gender.  */



   proc genmod data=babies descending;
  freq count;
   class age gender;
   model pizza_yes =age gender age*gender/ dist = bin link=logit;
     run;


/*  Odds of a female baby eating pizza over the odds of a female adult eating pizza are

exp(Beta__baby + Beta_female + Beta_baby*female)  / exp(Beta__adult + Beta_female + Beta_adult*female) 

=  exp(Beta__baby + Beta_female + Beta_baby*female)  / exp(Beta_female) 	(since adult is baseline)
	
=  exp(Beta_baby + Beta_baby*female) = exp(-3.1246 + 6.2679) =  23.18024



Odds of a male baby eating pizza over the odds of a male adult eating pizza are 

exp(Beta__baby + Beta_male + Beta_baby*male)  / exp(Beta__adult + Beta_male + Beta_adult*male) 

=  exp(Beta__baby )	(since adult and males are the baselines)

=exp(-3.1246) = 0.04395451



Odds of a female baby  eating pizza over the odds of a male baby eating pizza are 

exp(Beta_baby+ Beta_female + Beta_baby*female)/exp(Beta_baby+ Beta_male + Beta_baby*male)  	

= exp(Beta_female + Beta_baby*female)  (since male is baseline)

= exp( -3.4057 + 6.2679) =  17.5



Odds of a female adult  eating pizza over the odds of a male adult eating pizza are 

exp(Beta_adult+ Beta_female + Beta_adult*female)/exp(Beta_adult + Beta_male + Beta_adult*male)  	

= exp(Beta_female) 	(since adult and males are the baselines)

=exp(-3.4057) = 0.03318358




   */


/* LR TEST

We can test if the interaction should be included in the model. The null is that the model without the 
interaction terms holds (or Ho: ß4 = ß5 = 0).

The model with the intercation terms we ran is the full model, so L_1 is -153.5067.

The first model we ran without the interaction terms is the reduced model, so  L_o is -230.3257.

Thus, -2(L0– L1)  = -2*(-230.3257 - -153.5067) = 153.638.

With 2 df this is clearly significant.  Which should be obvious from our discussion above 
 

Note, when the interaction is significant, we should do all of our interpretations in terms of the
interactions, not the main effects.  As you can see,  we don't want to simply say the effect of gender is ...

For babies, the odds ratio of females over males is about 17
For adults, the odds ratio for females over males is about .03

Nor would we want to just compare babies to adults,

For females, the odds ratio of babies over adults is about 23
For males,  the odds ratio of babies over adults is about .04


So we want to look at the interactions, or these types of comparisons.  To get p-values for these,
we can include the interaction term in the  "lsmeans variable_name/pdiff;"	command.


*/
  
    proc genmod data=babies descending;
   weight count;
   class age gender;
   model pizza_yes =age gender age*gender/ dist = bin link=logit;
   lsmeans age*gender/pdiff;
   run;


 /* Recall, when using the interaction term, the main effects are
   not described and tested simply as the difference of the corresponding Betas.  

With interaction in the model, the test Beta_young=0 no longer tests if there is a significant difference
between the odds (probability) between babies and the baseline (here adults).

Instead, the test Beta_young=0 tests if there is a signifacant difference
between the odds (probability) between babies and the baseline (here adults) at the baseline gender, here males.

The p-values for both Beta_young=0 and testing young males vs adult males
are both .7326.


Typically, we are again interested in describing the effects of one factor at the levels of the other factor. 
   We describe these efefcts with odds ratios

   odds of female babies/ odds of male babies
  odds of female young/ odds of male young
   odds of female adult/ odds of male adult

   odds of baby females/ odds of young females
   odds of baby females/ odds of adult females
   odds of young females/ odds of adult females

   odds of baby males/ odds of young males
   odds of baby males/ odds of adult males
   odds of young males/ odds of adult males



  */

/* MULITPLE LOGISTIC REGRESSION*/





   data crab;
input  color spine  width  satell  weight;
if satell>0 then y=1; if satell=0 then y=0; n=1; 
weight = weight/1000;  color = color - 1;
if color=4 then dark=0; if color < 4 then dark=1;
cards;
3  3  28.3  8  3050

4  3  22.5  0  1550

2  1  26.0  9  2300

4  3  24.8  0  2100

4  3  26.0  4  2600

3  3  23.8  0  2100

2  1  26.5  0  2350

4  2  24.7  0  1900

3  1  23.7  0  1950

4  3  25.6  0  2150

4  3  24.3  0  2150

3  3  25.8  0  2650

3  3  28.2  11 3050

5  2  21.0  0  1850

3  1  26.0  14  2300

2  1  27.1  8  2950

3  3  25.2  1  2000

3  3  29.0  1  3000

5  3  24.7  0  2200

3  3  27.4  5  2700

3  2  23.2  4  1950

2  2  25.0  3  2300

3  1  22.5  1  1600

4  3  26.7  2  2600

5  3  25.8  3  2000

5  3  26.2  0  1300

3  3  28.7  3  3150

3  1  26.8  5  2700

5  3  27.5  0  2600

3  3  24.9  0  2100

2  1  29.3  4  3200

2  3  25.8  0  2600

3  2  25.7  0  2000

3  1  25.7  8  2000

3  1  26.7  5  2700

5  3  23.7  0  1850

3  3  26.8  0  2650

3  3  27.5  6  3150

5  3  23.4  0  1900

3  3  27.9  6  2800

4  3  27.5  3  3100

2  1  26.1  5  2800

2  1  27.7  6  2500

3  1  30.0  5  3300

4  1  28.5  9  3250

4  3  28.9  4  2800

3  3  28.2  6  2600

3  3  25.0  4  2100

3  3  28.5  3  3000

3  1  30.3  3  3600

5  3  24.7  5  2100

3  3  27.7  5  2900

2  1  27.4  6  2700

3  3  22.9  4  1600

3  1  25.7  5  2000

3  3  28.3  15  3000

3  3  27.2  3  2700

4  3  26.2  3  2300

3  1  27.8  0  2750

5  3  25.5  0  2250

4  3  27.1  0  2550

4  3  24.5  5  2050

4  1  27.0  3  2450

3  3  26.0  5  2150

3  3  28.0  1  2800

3  3  30.0  8  3050

3  3  29.0  10 3200

3  3  26.2  0  2400

3  1  26.5  0  1300

3  3  26.2  3  2400

4  3  25.6  7  2800

4  3  23.0  1  1650

4  3  23.0  0  1800

3  3  25.4  6  2250

4  3  24.2  0  1900

3  2  22.9  0  1600

4  2  26.0  3  2200

3  3  25.4  4  2250

4  3  25.7  0  1200

3  3  25.1  5  2100

4  2  24.5  0  2250

5  3  27.5  0  2900

4  3  23.1  0  1650

4  1  25.9  4  2550

3  3  25.8  0  2300

5  3  27.0  3  2250

3  3  28.5  0  3050

5  1  25.5  0  2750

5  3  23.5  0  1900

3  2  24.0  0  1700

3  1  29.7  5  3850

3  1  26.8  0  2550

5  3  26.7  0  2450

3  1  28.7  0  3200

4  3  23.1  0  1550

3  1  29.0  1  2800

4  3  25.5  0  2250

4  3  26.5  1  1967

4  3  24.5  1  2200

4  3  28.5  1  3000

3  3  28.2  1  2867

3  3  24.5  1  1600

3  3  27.5  1  2550

3  2  24.7  4  2550

3  1  25.2  1  2000

4  3  27.3  1  2900

3  3  26.3  1  2400

3  3  29.0  1  3100

3  3  25.3  2  1900

3  3  26.5  4  2300

3  3  27.8  3  3250

3  3  27.0  6  2500

4  3  25.7  0  2100

3  3  25.0  2  2100

3  3  31.9  2  3325

5  3  23.7  0  1800

5  3  29.3  12  3225

4  3  22.0  0  1400

3  3  25.0  5  2400

4  3  27.0  6  2500

4  3  23.8  6  1800

2  1  30.2  2  3275

4  3  26.2  0  2225

3  3  24.2  2  1650

3  3  27.4  3  2900

3  2  25.4  0  2300

4  3  28.4  3  3200

5  3  22.5  4  1475

3  3  26.2  2  2025

3  1  24.9  6  2300

2  2  24.5  6  1950

3  3  25.1  0  1800

3  1  28.0  4  2900

5  3  25.8  10 2250

3  3  27.9  7  3050

3  3  24.9  0  2200

3  1  28.4  5  3100

4  3  27.2  5  2400

3  2  25.0  6  2250

3  3  27.5  6  2625

3  1  33.5  7  5200

3  3  30.5  3  3325

4  3  29.0  3  2925

3  1  24.3  0  2000

3  3  25.8  0  2400

5  3  25.0  8  2100

3  1  31.7  4  3725

3  3  29.5  4  3025

4  3  24.0  10 1900

3  3  30.0  9  3000

3  3  27.6  4  2850

3  3  26.2  0  2300

3  1  23.1  0  2000

3  1  22.9  0  1600

5  3  24.5  0  1900

3  3  24.7  4  1950

3  3  28.3  0  3200

3  3  23.9  2  1850

4  3  23.8  0  1800

4  2  29.8  4  3500

3  3  26.5  4  2350

3  3  26.0  3  2275

3  3  28.2  8  3050

5  3  25.7  0  2150

3  3  26.5  7  2750

3  3  25.8  0  2200

4  3  24.1  0  1800

4  3  26.2  2  2175

4  3  26.1  3  2750

4  3  29.0  4  3275

2  1  28.0  0  2625

5  3  27.0  0  2625

3  2  24.5  0  2000
; 
run;


/* To run a logistic regression with multiple predictors (categorical and continuos), 
we list the categorical predictors, here color, after the class command.

We start out without interaction.


*/


proc genmod data=crab descending; class color ;
   model y = color width / dist=bin link=logit;
output out=results1 p=probs; 
run;


/* We can make a graph of the predicted probabilities over width for each color. However, this only provides the 
predicted probabilities at observed values of width. 

The output statement in the genmod porcedure tells SAS to output a data set, which we name following the out command.
In general,we use 
output out="name we choose".

The p command is where we tell SAS to inluce the predicted probabilities and we named them "probs".
In general it is p = "name we choose".

We also need to sort our data by width so it will be plotted from smallest to largest.
This is only needed if we are going to connect the points by a line.  If they are not sorted, 
the line connecting the points follows the order of the width variable.  
If the points are not sorted by width, the line will be jagged all over the place.

*/
proc sort data=results1; by width; run;


/* We use proc gplot to plot the predicted probabilities.  The first statements are telling how we want the plot to look.
There are going to be 4 lines, one for each color, so we have 4 symbols.  i= join tells SAS to connect the points with a 
line.  v=circle says to make the points circles and l is type of line to draw and c is color.

Within proc gplot, we use plot Y*X=Z.  This creates a plot of Y by X for each value of Z.
So we use plot probs*width = color which gives a plot of the predicted probabilities, which we named probs, over width
for each color.  Note, the name of the data file is results1, what we created from the genmod procedure.


*/

symbol1 i = join v=circle l=32  c = black;
symbol2 i = join v=circle l=32  c = red;

symbol3 i = join v=circle l=32  c = green;
symbol4 i = join v=circle l=32  c = blue;

proc gplot data=results1;
plot probs*width=color; run;

/* There are a couple of ways to make the plots over a wider range for each color.  One, is to do it by 
hand in R.  Another, is to make a new dataset that has all the values of width that you want a predicted probability for.
In this dataset, we will just indicate the width, and the level of color since we need a predicted probability for
the width values for each color.  The rest of the variables we will leave as missing.

This way, SAS will create a predicted probability at each of these values of weight, which we can plot, but since the rest 
of the data is missing, it doesn't affect the analysis.
*/



data crab2; input color spine width satell weight y n dark;
cards;
1 . 11 . . . . .
1 . 13 . . . . .
1 . 15 . . . . .
1 . 17 . . . . .
1 . 19 . . . . .
1 . 21 . . . . .
1 . 23 . . . . .
1 . 25 . . . . .
1 . 27 . . . . .
1 . 29 . . . . .
1 . 31 . . . . .
1 . 33 . . . . .
1 . 35 . . . . .
1 . 37 . . . . .
1 . 39 . . . . .

2 . 11 . . . . .
2 . 13 . . . . .
2 . 15 . . . . .
 2 . 17 . . . . .
2 . 19 . . . . .
2 . 21 . . . . .
2 . 23 . . . . .
2 . 25 . . . . .
2 . 27 . . . . .
2 . 29 . . . . .
2 . 31 . . . . .
2 . 33 . . . . .
2 . 35 . . . . .
2 . 37 . . . . .
2 . 39 . . . . .




3 . 11 . . . . .
3 . 13 . . . . .
3 . 15 . . . . .
3 . 17 . . . . .
3 . 19 . . . . .
3 . 21 . . . . .
3 . 23 . . . . .
3 . 25 . . . . .
3 . 27 . . . . .
3 . 29 . . . . .
3 . 31 . . . . .
3 . 33 . . . . .
3 . 35 . . . . .
3 . 37 . . . . .
3 . 39 . . . . .


4 . 11 . . . . .
4 . 13 . . . . .
4 . 15 . . . . .
4 . 17 . . . . .
4 . 19 . . . . .
4 . 21 . . . . .
4 . 23 . . . . .
4 . 25 . . . . .
4 . 27 . . . . .
4 . 29 . . . . .
4 . 31 . . . . .
4 . 33 . . . . .
4 . 35 . . . . .
4 . 37 . . . . .
4 . 39 . . . . .


;
run;

data crab3; set crab crab2; run;

proc genmod data=crab3 descending; class color ;
   model y = color width / dist=bin link=logit;
output out=results1b p=probsb; 
run;



proc sort data=results1b; by width; run;

symbol1 i = join v=circle l=32  c = black;
symbol2 i = join v=circle l=32  c = red;

symbol3 i = join v=circle l=32  c = green;
symbol4 i = join v=circle l=32  c = blue;

proc gplot data=results1b;
plot probsb*width=color; run;









/* LR TEST for color */

/* We are interested in testing  Ho: ß1 = ß2 = ß3=0 (color has no effect)
To do the LR test, we need the log-likelihoods for the full model(L_1) and the model without color (L_o).  
From above, the log-likelihood for the full model (L_1) is -93.7285

  To get L_o, we run the model without color*/

proc genmod data=crab descending; class color ;
   model y = width / dist=bin link=logit;
run;

 /*  L_o = -97.2263	, thus -2[L_o - L-1] = -2[-97.2263-	(-93.7285)]	=7 

This is significant, so we reject the model without color holds and include color in our model.

*/







/* With interaction*/

/* To run with interaction between color and width, we include the color*width term in the model */


proc genmod data=crab3 descending;  class color ;
   model y = color width color*width/ dist=bin link=logit;
output out=results2 p=probs2; 
run;


proc sort data=results2; by width; run;


symbol1 i = join v=circle l=32  c = black;
symbol2 i = join v=circle l=32  c = red;

symbol3 i = join v=circle l=32  c = green;
symbol4 i = join v=circle l=32  c = blue;

proc gplot data=results2;
plot probs2*width=color; run;









/* To match example in book, we look at either dark or all the not dark crabs.  
The original data has a variable "dark" that is 0 for dark crabs and 1 for nondark crabs.
Since, SAS orders the variables numerically, the nondark crabs are used as the baseline.

To match the results in the slides, we will switch to make the dark crabs the baseline.
We will create a new dataset with the variable "clr" , which has two groups "dark" and "all not dark".  
Since "all not dark" comes first, "dark" will be the baseline and clr will equal 0 for "dark".  This again,
is just to match teh results in the slides.

Using either model is EXACTLY the same mathamatically, 
   the results are just are presented differently. 

*/

data crabby; set crab; 
if dark=1 then clr='allnotdark';
else if  dark=0 then clr='dark';
run;

proc genmod data=crabby descending;  class clr ;
   model y = clr width clr*width/ dist=bin link=logit;

run;

/* To see when dark = 0 is the first variable listed and the non-dark crabs are the baseline.  
Again, mathematically, it is exactly the same
*/

proc genmod data=crab descending;  class dark ;
   model y = dark width dark*width/ dist=bin link=logit;
run;

/* The first way, the intercept for the non-dark crabs is  -5.8538 + -6.9578 = -12.8116.

The second way, the intercept for the non-dark crabs (dark=1) is  -12.8116+0 = -12.8116.






/* LR TEST FOR INTERACTION */
/* to test intercation with LR statistic we use the loglikelihoods from the model with interaction, L_1, and the model 
without interaction, L_o, (the null is the reduced model without interaction).

From above L_1 = -93.3932

 We need to run the model without interaction to get L_o, but with only using dark and non-dark, not the model we 
ran to start with. Thus we use "dark" instead of "color"*/

proc genmod data=crab descending;  class dark ;
   model y = dark width / dist=bin link=logit;

run;

/*
 Thus -2[L_o - L-1] = -2[-93.9789 -  (-93.3932)]	= 1.12
The df are 1 and this is very  non-significant, so we do not reject that the model without the intercation holds.
Thus we will use the simpler model without the interaction.

*/
























