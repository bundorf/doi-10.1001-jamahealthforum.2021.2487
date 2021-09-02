* ==============================================================================
* APPENDIX TABLE 3
* ==============================================================================


clear
set more off

* import data

use "$cdata/hps_w1-21v.dta", clear

* drop nebraska

drop if state == "NE"

* set survey data, merge in replication weights for phase 1

sort scram week
merge 1:1 scram week using "$cdata/pulse_2020_replicationweights.dta"
drop _merge
svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse

* filter adults age 18-64

drop if age>=65

* create linear trend variable

gen lweek = week - 1
	replace lweek = lweek + 1 if week > 1
	replace lweek = (lweek + 4) + (week - 13) if week >= 13
	tab lweek
	
* check lweek variable

tab lweek if week >= 1 & week <= 12
tab lweek if week >= 13 & week <= 21

* create interaction variable

gen lweekphase_2or3 = lweek * phase_2or3

* label variables
label var lweek "Week"
label var phase_2or3 "Fall/Winter Period"
label var lweekphase_2or3 "Week * Fall/Winter Period"

************************************
*** CREATE TABLES - BY EXPANSION ***
************************************

eststo clear

* ALL
eststo: svy: regress hlthins_anyins lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
eststo: svy: regress hlthins_esi lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
eststo: svy: regress hlthins_nonesi lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

* NON-EXP
eststo: svy: regress hlthins_anyins lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0
eststo: svy: regress hlthins_esi lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0
eststo: svy: regress hlthins_nonesi lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

* EXP
eststo: svy: regress hlthins_anyins lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1
eststo: svy: regress hlthins_esi lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1
eststo: svy: regress hlthins_nonesi lweek phase_2or3 lweekphase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

esttab est1 est2 est3 est4 est5 est6 est7 est8 est9 using "$results/apptab3.csv", label keep(lweek phase_2or3 lweekphase_2or3) ///
b(a3) se(5) mtitles("Any Insurance (All)" "ESI (All)" "Non-ESI (All)" "Any Insurance (Non-Expansion)" "ESI (Non-Expansion)" "Non-ESI (Non-Expansion)" "Any Insurance (Expansion)" "ESI (Expansion)" "Non-ESI (Expansion)") ///
nogaps star(* 0.10 ** 0.05 *** 0.01) stats(N, labels ("Observations")) replace





