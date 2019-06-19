set PRODUCTS;
set PRODLINES;
set RESOURCES;

param prod_per_hour { k in PRODUCTS, j in PRODLINES};
param profit { k in PRODUCTS};
param res_avail { i in RESOURCES};
param res_req { i in RESOURCES, j in PRODLINES};


# your variables, objective function and constraints should go here
















data;

set PRODUCTS := Frame Wheel Saddle HandleBar;
set PRODLINES:= line1 line2 line3;
set RESOURCES := Steel Rubber Operator;

param  profit :=
Frame		100		
Wheel		25		
Saddle		5.1		
HandleBar	8;   	

param res_avail :=
Steel		600
Rubber		50
Operator	360;


param prod_per_hour :
		line1	line2	line3 :=
Frame	3		0		0	
Wheel	0		6		0	
Saddle	0		0		20
HandleBar	0	0		6;

param res_req :
			line1	line2	line3 :=	
Steel		10		0.5		0.4	
Rubber		0		0.2		0.1
Operator	2		1		1;	