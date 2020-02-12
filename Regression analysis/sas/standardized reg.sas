data sales; input x1 x2  y;
cards;
31 1.85 4.2
46 2.8 7.28
40 2.2 5.6
49 2.85	8.12
38 1.8 5.46
49 2.8 7.42
31 1.85	3.36
38 2.3 5.88
33 1.6 4.62
42 2.15	5.88
;
run;

/* To get the standardized betas, we just add the command "stb" */
proc reg data=sales;
model y=x1 x2 /   stb;
run;



/* We can also standardize the variables first and then run our regression. 
We saw earlier how to do this in proc standard.
*/
proc standard data = sales mean=0 std=1 out=zsales;
	var y x1 x2;
run;


proc reg data=zsales;
model y=x1 x2 /   stb;
run;

/* Note, here the estimates and the standardized estimates are the same since we ran
the regression on the standardized variables*/
