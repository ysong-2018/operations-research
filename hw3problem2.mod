set CURRENCY;

param beginning {i in CURRENCY}; 		# also OK to write param demand {PRODUCTS};
param ending {i in CURRENCY};	# fill in the blank
param conversion {i in CURRENCY, j in CURRENCY};

# add variables, objective function and constraints below

var e {i in CURRENCY} >= 0;
var t {i in CURRENCY, j in CURRENCY} >= 0;

maximize total_profit :
	sum {i in CURRENCY} ((conversion[i,'dollars']+(1/conversion['dollars',i]))/2) * e[i];
	
subject to min_limit {i in CURRENCY}:
	e[i] >= ending[i];
	
subject to total_start {i in CURRENCY}:
	sum {j in CURRENCY} t[i,j] = beginning[i];
	
subject to total_end {j in CURRENCY}:
	sum {i in CURRENCY} conversion[i,j]*t[i,j] = e[j];


data;

set CURRENCY := dollars pounds marks yen;


param beginning:=
	dollars 8
	pounds 1
	marks 8
	yen 0;
	
param ending:=
	dollars 6
	pounds 3
	marks 1
	yen 10;
	
	
param conversion:
			dollars pounds marks yen :=
	dollars	1 0.58928 1.743 138.3
	pounds 	1.697 1 2.9579 234.7
	marks   0.57372 0.33808 1 79.346
	yen     0.007233 0.00426 0.126 1;
