data babies; input age$ pizza_yes$ count;
cards;
ababy 	1 20
young 	1 20
zadult  1 10
ababy 0 19
young 0 110
zadult 0 11

;
run;



/* One factor: We are modeling the probability that someone eats pizza depending on their age: baby, young, or adult.


*/

   proc genmod data=babies descending;
   weight count;
   class age ;
   model pizza_yes =age  / dist = bin link=logit;
    run;


/* 
Note, to test if the probability of eating pizza is the same for babies as for adults, we are testing if 
Beta_baby = 0.  This corresponds to testing if the odds ratio between the two is 1.  If the proabbilities are the same,
the odds are the same and the odds ratio is 1.


The odds that a baby eats pizza over the odds that an adult eats pizza is
exp(Beta_baby)/ exp(Beta_adult) =  exp(Beta_baby)/exp(0) = exp(Beta_baby)= exp(1.7236) =  5.604669

Thus the odds that a baby eats pizza are 5.6 times larger than the odds that an adult eats pizza.
Again, tsting if Beta_baby = 0 corresponds to testing if thsi odds ratio is 1.  Clearly thge odds ratio is not 1 
and this is seen in the p-value =  <.0001



The odds that a baby eats pizza over the odds that a young person eats pizza is
exp(Beta_baby)/ exp(Beta_young) =  exp(Beta_baby - Beta_young) = exp(1.7236 - 0.9622) = 2.141272





/* Two factors:  We will now look at the model with two factor age and gender.  Note, there is no interaction. */

 proc genmod data=babies descending;
   weight count;
   class age gender;
   model pizza_yes =age gender / dist = bin link=logit;
    run;

	/*



	Odds of a baby girl eating pizza over the odds of a adult female eating pizza are:
exp(Beta_baby + Beta_female)/ exp(Beta_young + Beta_female)	=  exp(Beta_baby + Beta_female - Beta_young - Beta_female)
=exp(Beta_baby - Beta_young) = exp(1.7057 -  0.9520) =   2.124847

Thus, the odds of a baby girl eating pizza are about twice the odds of a young female eating pizza.
 
Odds of a baby boy eating pizza over the odds of a adult male eating pizza are:

exp(Beta_baby + Beta_male)/ exp(Beta_young + Beta_male)	= exp(Beta_baby + 0)/ exp(Beta_young + 0)	
	= exp(Beta_baby - Beta_young)	= exp(1.7057 -  0.9520) =   2.124847


Since their is no interaction, the odds of a baby eating pizza over the odds of a young person eating
	pizza are the same for both males and females.   Note these are also very close to when just age was in the model


Odds of a baby girl eating pizza over the odds of a baby boy eating pizza are:
exp(Beta_baby + Beta_female)/exp(Beta_baby + Beta_male)	=  exp(Beta_baby + Beta_female)/ exp(Beta_baby + 0)
=  exp(Beta_baby + Beta_female - Beta_baby)	= exp(Beta_female)
	= exp(0.0422) =  1.043103

Note, the odds ratio of females to males is close to 1 (since there is no interaction it will be the same for
	all ages).  You can see that the p-value for age is very non-significant.  the probability of eating pizza is
	about the same for both genders, thus the odds are about the same, thus teh odds ratio is close to 1.

	*/
