* ==============================================================================
* APPENDIX TABLE 2
* ==============================================================================

clear
set more off

**********************
*** Build the data ***
**********************

* import data

use "$cdata/hps_w1-21v.dta", clear

* filter adults age 18-64

drop if age>=65

* set survey weights

sort scram week
merge 1:1 scram week using "$cdata/pulse_2020_replicationweights.dta"
drop _merge
svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse

***************************************************
*** Create Appendix Table 2 with Marital Status ***
***************************************************

* Simplified labels
la var inc_low "Low Income"
la var inc_mid "Middle Income"
la var inc_high "High Income"

* Recode missing to zeros for constant sample

	* Income
	replace inc_low = 0 if income_missing == 1
	replace inc_mid = 0 if income_missing == 1
	replace inc_high = 0 if income_missing == 1

	* Health insurance
	replace hlthins_esi = 0 if hlthins_missing == 1
	replace hlthins_nonesi = 0 if hlthins_missing == 1 
	replace hlthins_unins = 0 if hlthins_missing == 1 
	replace hlthins_priv = 0 if hlthins_missing == 1 
	replace hlthins_medicaid = 0 if hlthins_missing == 1 
	replace hlthins_public = 0 if hlthins_missing == 1

	* Marital status
	replace ms_married = 0 if ms_missing == 1
	replace ms_notmarried = 0 if ms_missing == 1

	* Check for mutual exclusiveness
	summ inc_low inc_mid inc_high income_missing
	summ hlthins_esi hlthins_nonesi hlthins_unins hlthins_missing
	summ ms_married ms_notmarried ms_missing

svy: reg inc_low week_1 week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 week_11 week_13 week_14 week_15 week_16 week_17 week_18 week_19 week_20 week_21
outreg2 using "$results/apptab2.xls", label bdec(3) pdec(3) par(se) addstat("F-statistic", e(F), "p-value", e(p)) replace

local x inc_mid inc_high income_missing hlthins_esi hlthins_nonesi hlthins_unins hlthins_priv hlthins_medicaid hlthins_public hlthins_missing ms_married ms_notmarried ms_missing

foreach var in `x'{
	svy: reg `var' week_1 week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 week_11 /*week_12*/ week_13 week_14 week_15 week_16 week_17 week_18 week_19 week_20 week_21
	outreg2 using "$results/apptab2.xls", label bdec(3) pdec(3) par(se) addstat("F-statistic", e(F), "p-value", e(p)) append
}



