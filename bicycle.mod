set PRODUCTS;
set PRODLINES;
set RESOURCES;

param prod_per_hour { k in PRODUCTS, j in PRODLINES};
param res_avail { i in RESOURCES};
param res_req { i in RESOURCES, j in PRODLINES};

var x {k in PRODUCTS} >= 0, integer; # number of products k required for the final product
var y {j in PRODLINES} >= 0; # number of hours to run production line j
var z >= 0, integer; # number of bicycles to be sold

maximize Total_Profit:
	200 * z;
	
subject to Produce {k in PRODUCTS}:
	x[k] = sum{ j in PRODLINES } prod_per_hour[k,j] * y[j];			

subject to Resource_Availability {i in RESOURCES}:
	sum{ j in PRODLINES } res_req[i,j] * y[j] <= res_avail[i];			

subject to Bicycle_Component {k in PRODUCTS}:
	z <= x[k];

subject to Wheel:
	z <= x['Wheel'] / 2;



data;

set PRODUCTS := Frame Wheel Saddle HandleBar;
set PRODLINES:= line1 line2 line3;
set RESOURCES := Steel Rubber Operator;


param res_avail :=
Steel		600
Rubber		50
Operator	360;

param prod_per_hour :
		line1	line2	line3 :=
Frame		3		0		0	
Wheel		0		6		0	
Saddle		0		0		20
HandleBar	0		0		6;

param res_req :
			line1	line2	line3 :=	
Steel		10		0.5		0.4	
Rubber		0		0.2		0.1
Operator	2		1		1;	