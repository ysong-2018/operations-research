set ORIG;   # origins
set DEST;   # destinations
set PROD;   # products

param supply {ORIG,PROD} >= 0;  # amounts available at origins
param demand {DEST,PROD} >= 0;  # amounts required at destinations

param limit {ORIG,DEST} >= 0;  # limit on total amount that can be shipped between each origin-destination pair

param cost {ORIG,DEST,PROD} >= 0;  # shipment costs per unit

var Trans {ORIG,DEST,PROD} >= 0;   # units to be shipped
var lb{j in DEST,p in PROD};
var a{i in ORIG, j in DEST,p in PROD} binary;
var b{i in ORIG, j in DEST,p in PROD} binary;
var Used {i in ORIG, j in DEST} binary;




minimize Total_Cost:
	#sum {i in ORIG,j in DEST} Used[i,j] ;
 	sum {i in ORIG, j in DEST, p in PROD} cost[i,j,p] * Trans[i,j,p];

subject to Supply {i in ORIG, p in PROD}:
   sum {j in DEST} Trans[i,j,p] <= supply[i,p];

subject to Demand {j in DEST, p in PROD}:
   sum {i in ORIG} Trans[i,j,p] >= demand[j,p];


# option 1: change the Multi-constraint to make sure that Used[i,j]=1 if we ship products on the link from i to j
subject to Multi {i in ORIG, j in DEST}:
   sum {p in PROD} Trans[i,j,p] <= limit[i,j] * Used[i,j];



#subject to Multi {i in ORIG, j in DEST}:
#   sum {p in PROD} Trans[i,j,p] <= limit[i,j];


# (b) added constraint for lb
#subject to cons1 {j in DEST, p in PROD}:
#	lb[j,p] = min(150, demand[j,p]);
	
# (b) constraints on Trans
subject to cons2 {i in ORIG,j in DEST, p in PROD}:
	 Trans[i,j,p] <= limit[i,j]*a[i,j,p];
	
subject to cons3 {i in ORIG,j in DEST, p in PROD}:
	min(150, demand[j,p]) - Trans[i,j,p] <= limit[i,j]*(1-a[i,j,p]);

# (c) constrainst on gary
#subject to gary1 {i in ORIG, j in DEST, p in PROD}:
#	sum {i in ORIG} sum {p in PROD} Trans [i, 'FRA', p] - sum{p in PROD} Trans ['GARY', 'FRA', p] <= limit[i,'FRA']*b[i,j,p];

#subject to gary2 {i in ORIG, j in DEST, p in PROD}:
#	sum {i in ORIG} sum {p in PROD} Trans [i, 'LAN', p] - sum{p in PROD} Trans ['GARY', 'LAN', p] <= limit[i,'LAN']*b[i,j,p];
	
data;

set ORIG := GARY CLEV PITT ;
set DEST := FRA DET LAN WIN STL FRE LAF ;
set PROD := bands coils plate ;

param supply (tr):  GARY   CLEV   PITT :=
            bands    400    700    800
            coils    800   1600   1800
            plate    200    300    300 ;

param demand (tr):
           FRA   DET   LAN   WIN   STL   FRE   LAF :=
   bands   300   300   100    75   650   225   250
   coils   500   750   400   250   950   850   500
   plate   100   100     0    50   200   100   250 ;

param limit default 625 ;

param cost :=

 [*,*,bands]:  FRA  DET  LAN  WIN  STL  FRE  LAF :=
        GARY    30   10    8   10   11   71    6
        CLEV    22    7   10    7   21   82   13
        PITT    19   11   12   10   25   83   15

 [*,*,coils]:  FRA  DET  LAN  WIN  STL  FRE  LAF :=
        GARY    39   14   11   14   16   82    8
        CLEV    27    9   12    9   26   95   17
        PITT    24   14   17   13   28   99   20

 [*,*,plate]:  FRA  DET  LAN  WIN  STL  FRE  LAF :=
        GARY    41   15   12   16   17   86    8
        CLEV    29    9   13    9   28   99   18
        PITT    26   14   17   13   31  104   20 ;