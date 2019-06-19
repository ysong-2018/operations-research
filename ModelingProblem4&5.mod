set DISTRICT;
set ETHNICITY;
set SCHOOL;

param studentnumber {i in DISTRICT, k in ETHNICITY}; 		# also OK to write param demand {PRODUCTS};
param distance {i in DISTRICT, j in SCHOOL};	# fill in the blank

# add variables, objective function and constraints below
var M {i in DISTRICT, j in SCHOOL} >= 0; # minority student numbers
var N {i in DISTRICT, j in SCHOOL} >= 0; # nonminority student numbers

minimize total_travel :
	sum{i in DISTRICT} sum{j in SCHOOL} (M[i,j] + N[i,j])*distance[i,j] ;


subject to stu_limit_m {i in DISTRICT}:
	sum {j in SCHOOL} M[i,j] = studentnumber[i,'minority'];
	
subject to stu_limit_n {i in DISTRICT}:
	sum {j in SCHOOL} N[i,j] = studentnumber[i,'nonminority'];


subject to percentage1:
	sum {i in DISTRICT} (0.8*M[i,'cooley']-0.2*N[i,'cooley']) >= 0;
	
subject to percentage2:
	sum {i in DISTRICT} (0.7*M[i,'cooley']-0.3*N[i,'cooley']) <= 0;
	
subject to percentage3:
	sum {i in DISTRICT} (0.8*M[i,'walt']-0.2*N[i,'walt']) >= 0;
	
subject to percentage4:
	sum {i in DISTRICT} (0.7*M[i,'walt']-0.3*N[i,'walt']) <= 0;


subject to number1:
	sum {i in DISTRICT} (M[i,'cooley'] + N[i,'cooley']) >=300;
	
subject to number2:
	sum {i in DISTRICT} (M[i,'cooley'] + N[i,'cooley']) <=500;

subject to number3:
	sum {i in DISTRICT} (M[i,'walt'] + N[i,'walt']) >=300;
	
subject to number4:
	sum {i in DISTRICT} (M[i,'walt'] + N[i,'walt']) <=500;


data;

set DISTRICT := one two three ;
set ETHNICITY := minority nonminority;
set SCHOOL := cooley walt;


	
param studentnumber:
			minority nonminority :=
	one	    50 200
	two 	50 250
	three   100 150;
	
	
	
param distance:
			cooley walt :=
	one	    1 2
	two 	2 1
	three   1 1;
