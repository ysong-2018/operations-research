set FOODS;
set NUTRIENTS;

param c {j in FOODS };
param b {i in NUTRIENTS };
param a {i in NUTRIENTS, j in FOODS };

var x {j in FOODS} >= 0;

minimize total_cost : 
		sum { j in FOODS } c[j]*x[j];

subject to nutrient_req {i in NUTRIENTS} : 
		sum { j in FOODS} a[i,j] * x[j] >= b[i];
		
data;

set FOODS := brownies chocice cola cheesecake;
set NUTRIENTS := calories chocolate sugar fat;

param c :=
	brownies	50
	chocice		20
	cola		30
	cheesecake	80;
	
param b :=
	calories	500
	chocolate	6
	sugar		10
	fat			8;
	
param a :
			brownies		chocice		cola		cheesecake :=
calories	400			200			150			500	
chocolate	3			2			0			0
sugar		2			2			4			4
fat			2			4			1			5;
	
			