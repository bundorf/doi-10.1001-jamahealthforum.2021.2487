* ==============================================================================
* CONVERT CSV FILES TO DTA
* Raw data files and survey dates obtained from: https://www.census.gov/programs-surveys/household-pulse-survey/datasets.html
* Raw unemployment data files obtained from: https://fred.stlouisfed.org/series/UNRATENSA
* ==============================================================================

* set working directory to csv files

cd "${rdata}/pulse/csv/"	

* convert PHASE 1 csv (date of access: 08/18/2020)

insheet using "pulse2020_puf_01.csv", clear
save "../dta/pulse2020_puf_01.dta", replace
insheet using "pulse2020_puf_02.csv", clear
save "../dta/pulse2020_puf_02.dta", replace
insheet using "pulse2020_puf_03.csv", clear
save "../dta/pulse2020_puf_03.dta", replace
insheet using "pulse2020_puf_04.csv", clear
save "../dta/pulse2020_puf_04.dta", replace
insheet using "pulse2020_puf_05.csv", clear
save "../dta/pulse2020_puf_05.dta", replace
insheet using "pulse2020_puf_06.csv", clear
save "../dta/pulse2020_puf_06.dta", replace
insheet using "pulse2020_puf_07.csv", clear
save "../dta/pulse2020_puf_07.dta", replace
insheet using "pulse2020_puf_08.csv", clear
save "../dta/pulse2020_puf_08.dta", replace
insheet using "pulse2020_puf_09.csv", clear
save "../dta/pulse2020_puf_09.dta", replace
insheet using "pulse2020_puf_10.csv", clear
save "../dta/pulse2020_puf_10.dta", replace
insheet using "pulse2020_puf_11.csv", clear
save "../dta/pulse2020_puf_11.dta", replace
insheet using "pulse2020_puf_12.csv", clear
save "../dta/pulse2020_puf_12.dta", replace

* convert PHASE 2 csv
insheet using "pulse2020_puf_13.csv", clear /* (date of access: 09/03/2020) */
save "../dta/pulse2020_puf_13.dta", replace
insheet using "pulse2020_puf_14.csv", clear	/* (date of access: 09/15/2020) */
save "../dta/pulse2020_puf_14.dta", replace
insheet using "pulse2020_puf_15.csv", clear	/* (date of access: 09/29/2020) */
save "../dta/pulse2020_puf_15.dta", replace
insheet using "pulse2020_puf_16.csv", clear	/* (date of access: 10/13/2020) */
save "../dta/pulse2020_puf_16.dta", replace
insheet using "pulse2020_puf_17.csv", clear	/* (date of access: 10/27/2020) */
save "../dta/pulse2020_puf_17.dta", replace

* convert PHASE 3 csv
insheet using "pulse2020_puf_18.csv", clear	/* (date of access: 11/10/2020) */
save "../dta/pulse2020_puf_18.dta", replace
insheet using "pulse2020_puf_19.csv", clear	/* (date of access: 11/24/2020) */
save "../dta/pulse2020_puf_19.dta", replace
insheet using "pulse2020_puf_20.csv", clear	/* (date of access: 12/08/2020) */
save "../dta/pulse2020_puf_20.dta", replace
insheet using "pulse2020_puf_21.csv", clear	/* (date of access: 12/22/2020) */
save "../dta/pulse2020_puf_21.dta", replace

* unemployment data not seasonally adjusted from jan 2020-jan 2021 (date of access: 02/26/2021)
insheet using "UNRATENSA.csv", clear
save "../dta/UNRATENSA.dta", replace

* convert hps weekdates
insheet using "hps_weekdates.csv", clear
gen startdate = date(start_date, "MDY", 2025)
	format startdate %td
gen enddate = date(end_date, "MDY", 2025)
	format enddate %td
save "../dta/hps_weekdates.dta", replace

* convert calendar dates
insheet using "dates_2020.csv", clear
gen date2 = date(date, "DMY", 2021)
	format date2 %td
save "../dta/dates_2020.dta", replace


	

