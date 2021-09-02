* ==============================================================================
* STUDY POPULATION ANALYSIS - MEAN AND SD OF AGE
* ==============================================================================

clear
set more off

* import data

use "$cdata/hps_w1-21v.dta", clear

* drop nebraska

drop if state == "NE"

* set survey data

sort scram week
merge 1:1 scram week using "$cdata/pulse_2020_replicationweights.dta"
drop _merge
svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse


* filter adults age 18-64

drop if age>=65

* drop adults with missing health insurance information

drop if hlthins_missing == 1

*****************************
*** INPUT INTO EXCEL FILE ***
*****************************

* set excel sheet

putexcel set "$results/summary_age.xlsx", replace

	putexcel A2 = "Mean Age", hcenter border(bottom)
	putexcel B2 = "Standard Deviation", hcenter border(bottom)
	putexcel C2 = "N", hcenter border(bottom)
	
* calculate and record mean, sd, and N

svy: mean age
estat sd

	matrix A = (e(b))'
	putexcel A3 = matrix(A), hcenter nformat(0.000)

	matrix B = (r(sd))'
	putexcel B3 = matrix(B), hcenter nformat(0.000)
	
	count
		return list
		putexcel C3 = `r(N)'
	


