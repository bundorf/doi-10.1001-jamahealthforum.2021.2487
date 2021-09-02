* This do file creates appendix Figures 1 and 2 comparing HI in ACS 2018-2019, NHIS 2018 and HPS
***************************************************************************************************************************

clear
set more off


*********************
*** APPENDIX FIG 1 
*********************

* OPTION 2
use "$cdata/nhis_acs2019_2018pulse_fullappended.dta", clear
drop if data=="NHIS2019"
replace data="PULSE1" if data=="PULSE" & phase==1
replace data="PULSE23" if data=="PULSE" & (phase==2|phase==3)
encode data, gen(datadum)

* set survey data
svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5) mse

* proportions
prop hlthins_esi hlthins_nonesi hlthins_unins [pw=pweight], over(datadum)
parmest, list(,) saving("$cdata/comp_fig1", replace)

use "$cdata/comp_fig1.dta", replace
drop stderr dof t p

gen p1=substr(parm, 1, 1)
drop if p1=="0"
drop p1

split parm, p(@) gen(part)
rename (part1 part2) (HI data)
gen datadum= subinstr(data,".datadum","",.)
destring datadum, replace

gen hlthins=subinstr(HI,"1.hlthins_","",.)
drop data parm HI

encode hlthins, gen(HI)
drop hlthins
rename estimate hlthins

* change to percentages
gen hlthins_pct = hlthins*100
gen min95_pct = min95*100
gen max95_pct = max95*100

drop hlthins min95 max95
reshape wide hlthins_pct min95_pct max95_pct , i(datadum) j(HI)

rename (hlthins_pct1 min95_pct1 max95_pct1 hlthins_pct2 min95_pct2 max95_pct2 hlthins_pct3 min95_pct3 max95_pct3) ///
(esi_pct esi_pct_lci esi_pct_uci nonesi_pct nonesi_pct_lci nonesi_pct_uci unins_pct unins_pct_lci unins_pct_uci)

format esi_pct esi_pct_lci esi_pct_uci nonesi_pct nonesi_pct_lci nonesi_pct_uci unins_pct unins_pct_lci unins_pct_uci %9.2f
set scheme plotplain
gen type=datadum

*bar
replace type=type-.20
gen type2 = type+.20
gen type3 = type+.4

*scatter
gen type4=type-.11
gen type5 = type+.09
gen type6 = type+.30


twoway  (bar unins_pct type , barwidth(.2) bcol(dkgreen*.35)) || ///
		(bar esi_pct type2, barwidth(.2) bcol(maroon*.35)) || ///
		(bar nonesi_pct type3, barwidth(.2) bcol(ebblue*.35)) || ///
		(scatter unins_pct type4 , mlabp(1) msymbol(none) mlabel(unins_pct) mcol(black) mlabsize(2.25)) || ///
	    (scatter esi_pct type5 , mlabp(1) msymbol(none) mlabel(esi_pct) mcol(black) mlabsize(2.25)) || ///
	    (scatter nonesi_pct type6 , mlabp(1) msymbol(none) mlabel(nonesi_pct) mcol(black) mlabsize(2.25)) , ///
		ylabel(0(10)70) ///
		legend(order(1 "Uninsured" 2 "Emp. Spons. Ins." 3 "Other Insurance" ) pos(6) cols(3)) ///
		xlabel( 1 "ACS 2018" 2 "ACS 2019"  3 "NHIS 2018" 4 "Pulse Spring/Summer" 5 "Pulse Fall/Winter") ///
		xtitle("") ///
  note("{it:Note:} Author's calculations of health insurance coverage in American Community Survey, 2018 and 2019, National Health Interview" "Survey, 2018, and U.S. Census Household Pulse Survey (April 23-December 21, 2020). The uninsured constituted 12.82 percent" "[95% CI, 12.76 - 12.89] in ACS 2018, 13.22 percent [95% CI, 13.15 - 13.29] in ACS 2019, and 14.88 percent [95% CI, 14.51 - 15.25]" "in NHIS 2018, compared with 14.01 percent [95% CI, 13.75 - 14.27] in the Pulse during spring/summer and 13.47 [95% CI, 13.22 -" "13.72] during fall/winter of 2020. Employer sponsored insurance constituted 61.54 percent [95% CI, 61.45 - 61.63] in ACS 2018, 61.89" "percent [95% CI, 61.80 - 61.99] in ACS 2019 and 69.22 percent [95% CI, 68.74 - 69.69] in NHIS 2018, compared with 65.45 percent" "[95% CI, 65.12 - 65.78] in Pulse during spring/summer and 66.83 percent [95% CI, 66.53 - 67.14] during fall/winter of 2020. Other" "insurance constituted 25.64 percent [95% CI, 25.55 - 25.72] in ACS2018, 24.89 percent [95% CI, 24.80 - 24.97] in ACS2019 and 15.90" "percent [95% CI, 15.52 -	16.28] in NHIS 2018, compared with 20.54 percent [95% CI, 20.27 - 20.82] in Pulse during spring/summer" "and 19.70 percent [95% CI, 19.44 - 19.96] during fall/winter of 2020." "{it:Source: ACS 2018 and 2019, NHIS 2018, and U.S. Census Household Pulse Survey (April 23-December 21, 2020).}", size(2.5))


graph export "$results/appfig1.png", as(png)  replace


*********************
*** APPENDIX FIG 2 
*********************
use "$cdata/acs2019_2018pulse_fullappended.dta", clear
replace data="PULSE1" if data=="PULSE" & phase==1
replace data="PULSE23" if data=="PULSE" & (phase==2|phase==3)
drop if year==2018
encode data, gen(datadum)

* set survey data
svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5) mse

* collapse to calculate proportions

collapse ///
(mean) hlthins_esi_m=hlthins_esi ///
(mean) hlthins_nonesi_m=hlthins_nonesi ///
(mean) hlthins_unins_m=hlthins_unins [pw=pweight], by(datadum est_st)


reshape wide hlthins_esi_m hlthins_nonesi_m hlthins_unins_m, i(est_st) j(datadum) 
gen stfips=est_st
tostring stfips, replace
replace stfips="0"+stfips if length(stfips)==1
sort stfips
merge stfips using "$rdata/stateFIPS2.dta" 
drop _merge stfips

		local Titlehlthins_esi_m "Emp. Spons. Ins"
		local Titlehlthins_nonesi_m  "Other Insurance" 
		local Titlehlthins_unins_m  "Uninsured" 
		
		local Colorhlthins_esi_m "maroon*.7"
		local Colorhlthins_nonesi_m  "ebblue*.7" 
		local Colorhlthins_unins_m  "dkgreen*.7" 
 		
* ACS2019 - PULSE SPRING/SUMMER 2020
foreach i in hlthins_unins_m hlthins_esi_m hlthins_nonesi_m   {
twoway (scatter `i'1 `i'2, msym(o) msize(medlarge) mcolor(`Color`i'') mlabel(state) mlabsize(small)) (line `i'2 `i'2, lcolor(gs5)), xlabel(,labsize(4.5)) ylabel(,labsize(4.5)) xtitle("Pulse Spring/Summer", size(4.5)) ytitle("ACS 2019", size(4.5)) title(`Title`i'', pos(11) size(5)) name(`i', replace) legend(off)
graph export "$results/pulse_acs_`i'.png", replace
}
	# delimit ;
graph combine hlthins_unins_m hlthins_esi_m hlthins_nonesi_m , cols(3) xsize(9.5) ysize(4) iscale(.7) imargin(small)
    graphregion(color(white))
    name(limits1, replace)
	title("", size(small)) subtitle("(State Level Proportions)", size(3.5))
	note("{it:Note:} Author's calculations of health insurance coverage in the fifty U.S. states in the American Community Survey, 2019 and the U.S. Census Household Pulse Survey (April 23-July 21, 2020)." "Forty-five degree line presented for comparison." "{it:Source: ACS 2019 and U.S. Census Household Pulse Survey (April 23-July 21, 2020).}", size(3))
;
# delimit cr
graph export "$results/pulse1_acs2019_corr.png", as(png) replace width(4000)

* ACS2019 - PULSE FALL/WINTER 2020
foreach i in hlthins_unins_m hlthins_esi_m hlthins_nonesi_m   {
twoway (scatter `i'1 `i'3, msym(o) msize(medlarge) mcolor(`Color`i'') mlabel(state) mlabsize(small)) (line `i'3 `i'3, lcolor(gs5)), xlabel(,labsize(4.5)) ylabel(,labsize(4.5)) xtitle("Pulse Fall/Winter", size(4.5)) ytitle("ACS 2019", size(4.5)) title(`Title`i'', pos(11) size(5)) name(`i', replace) legend(off)
graph export "$results/pulse_acs_`i'.png", replace
}
	# delimit ;
graph combine hlthins_unins_m hlthins_esi_m hlthins_nonesi_m , cols(3) xsize(9.5) ysize(4) iscale(.7) imargin(small)
    graphregion(color(white))
    name(limits1, replace)
	title("", size(small)) subtitle("(State Level Proportions)", size(3.5))
	note("{it:Note:} Author's calculations of health insurance coverage in the fifty U.S. states in the American Community Survey, 2019 and the U.S. Census Household Pulse Survey (August 19-December" "21, 2020). Forty-five degree line presented for comparison." "{it:Source: ACS 2019 and U.S. Census Household Pulse Survey (August 19-December 21, 2020).}", size(3))
;
# delimit cr
graph export "$results/pulse23_acs2019_corr.png", as(png) replace width(4000)

