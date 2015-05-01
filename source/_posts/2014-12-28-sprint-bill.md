---
layout: post
title: "#OpStahpRippinUsOff Sprint"
date: 2014-12-28 20:04:41 -0700
categories:
- Life
---

*It became apparent a $200 phone bill for 3-lines is outrageous this day in age. Any given day you can walk into a Walmart and sign with StraightTalk who's offering Unlimited everything for 45/line I hear... What follows is just some scribble for me to look back on when the topic comes up for discussion, but maybe it'll raise some savings opportunities other's overlooked.*

## 'TEP' Insurance - Mom's line
	11$/mon.. Probably unecessary

## Available Discounts
	AAA Auto Club -- 10$ Off  
	- Call or add in-store  
	- Currently only getting loyalty discount.
	Maybe qualify for something better? 

## "Family Share Pack"

	2-yr contract (extension?.. ours doesnt end til 06/2015)
	
**DATA**
Total amount shared by entire family

	2gb - 25  
	4gb - 40  
	12gb - 80  
	16gb - 90  	
	20gb - 100$  

**DATA ACCESS_FEE**
	
	25$ ea line for 1-8gb  
	15$ ea line for 12-16gb  
	15$ ea line for >20gb  


Probably unnecessary but what the hell, right?

```

#!/bin/sh
 DATA_COST="40"
 NUM_DEVICES="3"
 NUM_TABS="1"
 ACCFEE="25"
 TAB_FEE="10"
 DISCNTS="10"
 IP_INSTL="27"
 G3_INSTL="25"
 TAXES_N_FEES="15"
 
echo "$DATA_COST + ($NUM_DEVICES * $ACCFEE) + ($NUM_TABS * $TAB_FEE) - $DISCNTS + $IP_INSTL + $G3_INSTL + $TAXES_N_FEES" | bc

```

So this is what we would be paying if we chose to stick with Sprint, extend our contract another 2-yrs and brought in my Mom's iPad which she's currently paying data for separately 

```
	182$ for 4Gb 	>> 	40$ + (3 * 25$) + [10$] - 10$ + 27 + 25 + [15]
	212$ for 8Gb	>> 	70$ + (3 * 25$) + [10$] - 10$ + 27 + 25 + [15]  
	192$ for 12Gb	>> 	80$ + (3 * 15$) + [10$] - 10$ + 27 + 25 + [15] 
	202$ for 16Gb	>> 	90$ + (3 * 15$) + [10$] - 10$ + 27 + 25 + [15] 
	212$ for 20Gb	>> 	100$ + (3 * 15$) + [10$] - 10$ + 27 + 25 + [15] 

```

## Reference

**We Are Currently Paying**

```

+   $45	>> 55$ 'Kevin 1gb' - 10$ 'FramilyDiscount'
+   $83	>> 55$ 'Mom 1gb' - 10$ 'FramilyDiscount' + 11$ Insur. + 27$ ip5s
+   $70	>> 55$ 'Edward 1gb' - 10$ 'FramilyDiscount' + 25$ LG_G3
+   $15	>> 10$ 'Taxes and Fees'
---------  
Total 	$213

```

**Typical Usage**

```
        Talk	Text	Data
		
Edward  800     5568    1072

Mom     527	    854	    245

Me      381	    250	    221
        -----------------------
Totals  1708	6672	1538
```
	
**My line's contract ends 06/20/15** .. Don't know yet if this'll be an issue.
