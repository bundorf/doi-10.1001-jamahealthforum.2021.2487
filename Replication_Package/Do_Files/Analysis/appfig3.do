* ==============================================================================
* APPENDIX FIGURE 3
* ==============================================================================

*****************
*** VERSION 1 ***
*****************

clear
set more off

* import data

use "$cdata/hps_w1-21v.dta", clear 

* merge in replication weights for phase 1
sort scram week
merge 1:1 scram week using "$cdata/pulse_2020_replicationweights.dta"
drop _merge

* drop nebraska

drop if state == "NE"

* set survey data

svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse

* filter adults age 18-64

drop if age>=65


****************
*** LOG FILE ***
****************

* Store week indicators dropping week of July 16-21 (Week 12)
local weekfe week_1 week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 week_11 week_13 week_14 week_15 week_16 week_17 week_18 week_19 week_20 week_21

* ALL - WITH STARS
svy: regress hlthins_anyins `weekfe' female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
parmest, list(,) saving("$cdata/apptab_weekfe_1_anyins", replace)

svy: regress hlthins_esi `weekfe' female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
parmest, list(,) saving("$cdata/apptab_weekfe_1_esi", replace)

svy: regress hlthins_nonesi `weekfe' female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
parmest, list(,) saving("$cdata/apptab_weekfe_1_nonesi", replace)

* PLOTS
local Titlehlthins_esi "Emp. Spons. Ins"
local Titlehlthins_nonesi  "Other Insurance" 
local Titlehlthins_anyins  "Any Insurance"

foreach i in anyins esi nonesi{
use "$cdata/apptab_weekfe_1_`i'", clear
gen week=_n
drop if week>20
replace week=week+1 if week>11
tsset week
tsfill, full
replace estimate=0 if week==12
replace min95=0 if week==12
replace max95=0 if week==12

twoway (scatter estimate week, msym(oh) mcol(ebblue)) || ///
        (rcap  min95 max95 week, lcol(gs8)) || ///
		(lfit estimate week if week<12, lpattern(dash) lwidth(medthick) lcolor(midgreen)) || ///
		(lfit estimate week if week>12, lpattern(dash) lwidth(medthick) lcolor(midblue)), ///
		legend(order(3 "Spring/Summer" 4 "Fall/Winter") pos(6) cols(2)) ///
		xlabel( 1 "4/23 – 5/5" /*2 "5/7 – 5/12"*/ 3 "5/14 – 5/19" /*4 "5/21 – 5/26"*/ 5 "5/28 – 6/2" /*6 "6/4 – 6/9"*/ 7 "6/11 – 6/16" ///
		/*8 "6/18 – 6/23"*/ 9 "6/25 – 6/30" /*10 "7/2 – 7/7"*/ 11 "7/9 – 7/14" /*12 "7/16 – 7/21"*/ 13 "8/19 – 8/31" ///
		/*14 "9/2 – 9/14"*/ 15 "9/16 – 9/28" /*16 "9/30 – 10/12"*/ 17 "10/14 – 10/26" ///
		/*18 "10/28 – 11/9"*/ 19 "11/11 – 11/23" /*20 "11/25 – 12/7"*/ 21 "12/9 – 12/21", angle(45) labsize(2.5))  ///
		yline(0, lcolor(cranberry)) name(`i', replace) graphregion(margin(tiny)) xsize(4) ysize(2) ysc(titlegap(0.5))  ylabel(-.04(.02)0.06) ///
		ytitle("Rate of coverage relative to week of Jul. 16 - Jul. 21") xtitle("Week Indicator") title(`Titlehlthins_`i'', pos(11)) 
		//graph export "$results/pulse_weekfe1_`i'.png", replace
}		
			# delimit ;
grc1leg anyins esi nonesi , cols(3) xsize(6) ysize(1.5) iscale(.6) /*imargin(small)*/ legendfrom(anyins)
    graphregion(color(white)) graphregion(margin(tiny)) 
    name(limits1, replace)
	title("", size(small)) /*subtitle("(State Level Proportions)", size(3.5))*/
	note("{it:Note:} Author's calculations of week fixed effects health insurance coverage in the fifty U.S. states in the U.S. Census Household Pulse Survey (April 23-December 21, 2020)." "{it:Source: U.S. Census Household Pulse Survey (April 23-December 21, 2020).}", size(2))
;
# delimit cr
graph export "$results/pulse_weekfe1.png", as(png) replace width(4000)
graph export "$results/pulse_weekfe1.eps", as(eps) replace 
graph export "$results/pulse_weekfe1.tif",  replace width(4000)


*****************
*** VERSION 2 ***
*****************

clear
set more off
eststo clear
* import data

use "$cdata/hps_w1-21v.dta", clear 

* merge in replication weights for phase 1
sort scram week
merge 1:1 scram week using "$cdata/pulse_2020_replicationweights.dta"
drop _merge

* drop nebraska

drop if state == "NE"

* set survey data

svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse

* filter adults age 18-64

drop if age>=65


****************
*** LOG FILE ***
****************

* Store week indicators 
local weekfe week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 week_11 week_12
local week_interact week_14interact week_15interact week_16interact week_17interact week_18interact week_19interact week_20interact week_21interact

* ALL - WITH STARS
tempfile tf1 tf14 tf15 tf16 tf17 tf18 tf19 tf20 tf21
svy: regress hlthins_anyins  `weekfe' `week_interact' phase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
parmest, list(,) saving("$cdata/apptab_weekfe_2_anyins", replace)

svy: regress hlthins_esi `weekfe' `week_interact' phase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
parmest, list(,) saving("$cdata/apptab_weekfe_2_esi", replace)

svy: regress hlthins_nonesi `weekfe' `week_interact' phase_2or3 female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st
parmest, list(,) saving("$cdata/apptab_weekfe_2_nonesi", replace)


* PLOTS
local Titlehlthins_esi "Emp. Spons. Ins"
local Titlehlthins_nonesi  "Other Insurance" 
local Titlehlthins_anyins  "Any Insurance"

foreach i in anyins {
use "$cdata/apptab_weekfe_2_`i'", clear
gen week=_n
}		
