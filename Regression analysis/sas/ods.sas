
data example; input y x;
cards;
1  3
2  5
4  9
10  11
20 39
 
;
run;


/* To output your results to a word file, you can use code similiar to below.  Just use the first and last line
before and after your proc code lines.  You will need to indicate where you want the file to be output to
after the "=" in the first line. You do not need to save it, it is automatically created in the location you give it*/

ods rtf file = "C:\Documents and Settings\mhersh\My Documents\StatMethsI_2010\output.rtf";

    proc reg data=example;
model y=x;

run;

ods rtf close;



