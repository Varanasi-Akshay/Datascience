

data steppy; input x1 x2 x3 x4 x5 x6 x7 x8 y lny;
cards;

66.7	62	81	2.59	50	0	1	0	695	6.544
5.1	59	66	1.70	39	0	0	0	403	5.999
7.4	57	83	2.16	55	0	0	0	710	6.565
6.5	73	41	2.01	48	0	0	0	349	5.854
7.8	65	115	4.30	45	0	0	1	2343	7.759
5.8	38	72	1.42	65	1	1	0	348	5.852
5.7	46	63	1.91	49	1	0	1	518	6.250
3.7	68	81	2.57	69	1	1	0	749	6.619
6.0	67	93	2.50	58	0	1	0	1056	6.962
3.7	76	94	2.40	48	0	1	0	968	6.875
6.3	84	83	4.13	37	0	1	0	745	6.613
6.7	51	43	1.86	57	0	1	0	257	5.549
5.8	96	114	3.95	63	1	0	0	1573	7.361
5.8	83	88	3.95	52	1	0	0	858	6.754
7.7	62	67	3.40	58	0	0	1	702	6.554
7.4	74	68	2.40	64	1	1	0	809	6.695
6.0	85	28	2.98	36	1	1	0	682	6.526
3.7	51	41	1.55	39	0	0	0	205	5.321
7.3	68	74	3.56	59	1	0	0	550	6.309
5.6	57	87	3.02	63	0	0	1	838	6.731
5.2	52	76	2.85	39	0	0	0	359	5.883
3.4	83	53	1.12	67	1	1	0	353	5.866
6.7	26	68	2.10	30	0	0	1	599	6.395
5.8	67	86	3.40	49	1	1	0	562	6.332
6.3	59	100	2.95	36	1	1	0	651	6.478
5.8	61	73	3.50	62	1	1	0	751	6.621
5.2	52	86	2.45	70	0	1	0	545	6.302
11.2	76	90	5.59	58	1	0	1	1965	7.583
5.2	54	56	2.71	44	1	0	0	477	6.167
5.8	76	59	2.58	61	1	1	0	600	6.396
3.2	64	65	0.74	53	0	1	0	443	6.094
8.7	45	23	2.52	68	0	1	0	181	5.198
5.0	59	73	3.50	57	0	1	0	411	6.019
5.8	72	93	3.30	39	1	0	1	1037	6.944
5.4	58	70	2.64	31	1	1	0	482	6.179
5.3	51	99	2.60	48	0	1	0	634	6.453
2.6	74	86	2.05	45	0	0	0	678	6.519
4.3	8	119	2.85	65	1	0	0	362	5.893
4.8	61	76	2.45	51	1	1	0	637	6.457
5.4	52	88	1.81	40	1	0	0	705	6.558
5.2	49	72	1.84	46	0	0	0	536	6.283
3.6	28	99	1.30	55	0	0	1	582	6.366
8.8	86	88	6.40	30	1	1	0	1270	7.147
6.5	56	77	2.85	41	0	1	0	538	6.288
3.4	77	93	1.48	69	0	1	0	482	6.178
6.5	40	84	3.00	54	1	1	0	611	6.416
4.5	73	106	3.05	47	1	1	0	960	6.867
4.8	86	101	4.10	35	1	0	1	1300	7.170
5.1	67	77	2.86	66	1	0	0	581	6.365
3.9	82	103	4.55	50	0	1	0	1078	6.983
6.6	77	46	1.95	50	0	1	0	405	6.005
6.4	85	40	1.21	58	0	0	1	579	6.361
6.4	59	85	2.33	63	0	1	0	550	6.310
8.8	78	72	3.20	56	0	0	0	651	6.478


;
run;

/* To run the stepwise procedure, we use proc stepwise.  There are different options and we will use "stepwise"
which does a backward and forward routine.  The "detail" command tells SAS to give all the details, 
such as the R-squared values for each predictor at each step. Some options are listed below.

Forward is where we start with no variables and enter them one at a time.
Backward is where we start with all the variables in the model and eliminate them one at a time.

Again, we are using a "stepwise" which does a backward and forward routine (as described in the slides).  


 model y = x1 x2 x3 / forward;	 forward selection 
   model y = x1 x2 x3 / backward;	 backward elimination 
   model y = x1 x2 x3 / stepwise;	 forward in & backward out 
   model y = x1 x2 x3 / maxr stop=4;	 like stepwise, but using R^2 


Note, the book uses the t statistic and corresponding p-value.  SAS uses the F statistic, which is equivalent.  
F is simply t^2.

In the book, at the first step, x3 has a t value of 6.23.  6.23^2= 38.8129.  The F value we get in SAS is 38.84, which
is the same except for rounding error.

At the first step, X3 is entered into the model. It has the largerst F statistic and the smallest p-value. 

Note, once a variable has been added to the model, none are removed in this example.
The best subset is X2,X3,X4,X8.


*/

proc stepwise 
data=steppy;
model lny = x1 x2 x3 x4 x5 x6 x7 x8/stepwise detail;
run;


/*

The default level that a p-value needs to be less than to stay in the model is .15.  

The below statement in the output tells us what this level is. 

 "All variables left in the model are significant at the 0.1500 level."


We can change this level with the slstay command.  For example, the p-value for x4 is .0032
before and after it enters the model.  It stays in the model since this is less than .15.  If we 
use slstay=.002, x4 will be entered into the model but will be removed.  Again, this is becasue we
are leaving the level that a p-value needs to be less than to enter as .15, the default, 
but we are changing the level that a p-value needs to stay in the model as .002.	*/




proc stepwise 
data=steppy;
model lny = x1 x2 x3 x4 x5 x6 x7 x8/stepwise detail slstay =.002;
run;



/* 

And x4 is entered and then removed from the model.



The default level that a p-value needs to be less than to enter the model is .15. 

The below statement in the output tells us what this level is. 
 "No other variable met the 0.1500 significance level for entry into the model."

We can change this with the slentry command. 
 For example, the p-value for x4 is .0032 and it enters the model since this is less than .15.  If we 
use  slentry=.002, x4 will not be entered into the model.	       

*/


proc stepwise 
data=steppy;
model lny = x1 x2 x3 x4 x5 x6 x7 x8/stepwise detail slenrty=.002;
run;

/* In thic case, x4 is never entered into the model*/
