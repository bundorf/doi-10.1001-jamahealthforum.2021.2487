* ==============================================================================
* FIGURE 1
* ==============================================================================

clear
set more off

**********************
*** BUILD THE DATA ***
**********************

* import data

use "$cdata/hps_w1-21v.dta", clear

* filter adults age 18-64

drop if age>=65

* set survey data

svyset scram [pweight=pweight]

* collapse to calculate proportions

tempfile hlthins_nat

collapse ///
(mean) hlthins_esi_m=hlthins_esi ///
(mean) hlthins_nonesi_m=hlthins_nonesi ///
(mean) hlthins_anyins_m=hlthins_anyins [pw=pweight], by(week)

* change to percentages

gen esi_pct = hlthins_esi_m*100
gen nonesi_pct = hlthins_nonesi_m*100
gen anyins_pct = hlthins_anyins_m*100

* merge dates to week

merge 1:1 week using "$rdata/pulse/dta/hps_weekdates", keepusing(startdate enddate)
	drop if _merge == 2
	drop _merge
gen date = startdate
gen month = month(startdate)

save `hlthins_nat'

*** --- national unemployment rates from january to december --- ***

tempfile rates
use "$cdata/UNRATENSA_clean.dta", clear
	drop if date == d(01jan2021)
sort date
rename date date_temp
gen month = month(date)
merge 1:m month using "$rdata/pulse/dta/dates_2020.dta", keepusing(date)
	keep if _merge == 3
	drop _merge
	sum month
gen date_clean = date(date, "MDY", 2021)
format date_clean %td
	drop date
	rename date_clean date
sort date
save `rates'

use `hlthins_nat', clear
merge m:1 date month using `rates', keepusing(unratensa date)
	format date %td
	sort date
drop _merge
sort date

* keep one observation of unemployment rate for each month

gen day = day(date)
replace unratensa = . if day != 12

* clean and reorder varlist

drop week hlthins_esi_m hlthins_nonesi_m hlthins_anyins_m startdate enddate month day 
order date unratensa anyins_pct esi_pct nonesi_pct

la var date "Date"
la var unratensa "Unemployment Rate"
la var anyins_pct "Any Insurance"
la var esi_pct "ESI"
la var nonesi_pct "Other Insurance"

* note: data is exported as excel file to create figure 1
export excel using "$results/figure1_data.xlsx", sheet("Data") firstrow(varlabels)

