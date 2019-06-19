set PRODUCTS;
set RESOURCES;


param contribution {PRODUCTS};
param capacity {RESOURCES};
param requirement {RESOURCES, PRODUCTS};

var x {j in PRODUCTS} >= 0;

maximize total_contribution :
	sum {j in PRODUCTS} contribution[j] * x[j];
	
	
subject to availability {i in RESOURCES}:
	sum {j in PRODUCTS} requirement[i,j] * x[j] <= capacity[i];
	 	

data;

set PRODUCTS := chair bench table; 
set RESOURCES := tube_bending welding tubing;

	
param requirement :
					chair	bench	table :=
	tube_bending	1.2		1.7		1.2
	welding			0.8		0		2.3
	tubing			2		3		4.5;
		
param contribution :=
	chair	3
	bench	3
	table	5;
	
param capacity :=
	tube_bending	1000
	welding			1200
	tubing			2000;