set PRODUCTS;
set STAGES;

param demand {j in PRODUCTS}; 		# also OK to write param demand {PRODUCTS};
param rate {                                };	# fill in the blank
param profit {PRODUCTS};
param avail {              		     };

# add variables, objective function and constraints below


var x {j in PRODUCTS} >= 0;

maximize total_profit :
	sum {j in PRODUCTS} profit[j] * x[j];
	
subject to demand_cons {j in PRODUCTS}:
	x[j] <= demand[j];
	
subject to hours {i in STAGES}:
	sum {j in PRODUCTS} (1/rate[i,j]) * x[j] <= avail[i];
	
subject to total_steel:
	sum {j in PRODUCTS} x[j] <= 9000;
	 	

data;

set PRODUCTS := bands coils plates;
set STAGES := reheating rolling_mill;

param demand:=
	bands	6000	
	coils	4000
	plates	3500;
	
param rate :
			bands	coils	plates :=
	reheating	200	200	200
	rolling_mill 	200	150	160	;
		
param profit :=
	bands	25	
	coils	30
	plates	29;	

param avail:=
	reheating	35
	rolling_mill	40	;
