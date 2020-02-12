/* Below is code to import data from a csv file.  After the datafile command, the directory of where the file
is needs to be given, with the name of the file last.  After the command "out", you specify what you want the 
data file to be called in SAS.  It can be the same name or something new.

Here we import a file named "Bobs_data" and name it data_to_use */

proc import datafile="C:\Documents and Settings\mhersh\My Documents\Bobs_data.csv"
out=data_to_use
DBMS=CSV REPLACE;
getnames=yes;
run;


/* Below is the same but to import an EXCEL file */

proc import datafile="C:\Documents and Settings\mhersh\My Documents\Bobs_data.xls"
out=data_to_use
DBMS=EXCEL REPLACE;
getnames=yes;
run;
