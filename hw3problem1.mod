set PRODUCTS;
set LINES;
set RESOURCES;

param bike_limit {k in PRODUCTS};
param profit {k in PRODUCTS}; 		# also OK to write param demand {PRODUCTS};
param availability {i in RESOURCES};	# fill in the blank
param production {k in PRODUCTS, j in LINES};
param usage {i in RESOURCES, j in LINES};

# add variables, objective function and constraints below


var x {k in PRODUCTS} >= 0 integer;
var y {j in LINES} >= 0;
var bike >= 0 integer;

maximize total_profit :
	200*bike;
	
subject to production_amount {k in PRODUCTS}:
	sum {j in LINES} production[k,j]*y[j] = x[k];
	
subject to resource_usage {i in RESOURCES}:
	sum {j in LINES} usage[i,j] * y[j] <= availability[i];
	
subject to maxi_min {k in PRODUCTS}:
	bike <= (1/bike_limit[k])*x[k];

data;

set PRODUCTS := frame wheel saddle handlebar;
set LINES := line1 line2 line3;
set RESOURCES := steel rubber operator ;

param bike_limit:=
	frame 1
	wheel 2
	saddle 1
	handlebar 1;

param profit:=
	frame 100
	wheel 25
	saddle 5
	handlebar 8;
	
param availability:=
	steel 600
	rubber 50
	operator 360;
	
param production:
			line1 line2 line3 :=
	frame	3 0 0
	wheel 	0 6 0	
	saddle 	0 0 20	
	handlebar 0 0 6;
	
param usage:
			line1 line2 line3 :=
	steel	10 0.5 0.4
	rubber 	0 0.2 0.1	
	operator 2 1 1;
		