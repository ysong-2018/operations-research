
# Decision variables
var x1 >= 0;
var x2 >= 0;
var x3 >= 0;
var x4 >= 0;

# Objective function
maximize Total_Profit: 
	450 - 26 * x1 - 28.3 * x2 - 20 * x3 - 8 * x4;

# Constraints
subject to Amount : 
	1000 * x1 + 1000 * x2 + 1000 * x3 + x4 = 1000;
subject to ManganeseLB : 
	4.5 * x1 + 5.0 * x2 + 4.0 * x3 + x4 >= 4.5;
subject to SiliconLB : 
	40 * x1 + 10 * x2 + 6 * x3 >= 32.5;
subject to SiliconUB : 
	40 * x1 + 10 * x2 + 6 * x3 <= 55.0;
