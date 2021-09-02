* This do file cleans ACS2018-2019, and NHIS 2018 to compare health insurance coverage with PULSE 
* ACS2018-2019 date of access: 01/11/2021
* NHIS 2018 date of access: 06/29/2021
***************************************************************************************************************************

clear
set more off

****************************
*** SET-UP PULSE FOR MERGE
****************************

use "$cdata/hps_w1-21v.dta", clear 

* merge in replication weights for phase 1
sort scram week
merge 1:1 scram week using "$cdata/pulse_2020_replicationweights.dta"
drop _merge

* set survey data
gen pweightpool=pweight/20
svyset scram [pweight=pweightpool]

* filter adults age 18-64
drop if age>=65|age<18

gen data="PULSE"
save "$cdata/pulse_full.dta", replace

*************************
*** CLEAN NHIS2018/2019 data
*************************
use "$rdata/IPUMS_NHIS/nhis_00002.dta", clear
*gender
	gen female=0
		replace female =1 if sex==2
		replace female = . if sex>2

*age
	drop if age<18 
	drop if age>64
	gen age1826=0
		replace age1826=1 if age>=18 & age<=26
		replace age1826=. if age==.
	gen age2740=0
		replace age2740=1 if age>=27 & age<=40
		replace age2740=. if age==.
	gen age4150=0
		replace age4150=1 if age>=41 & age<=50
		replace age4150=. if age==.
	gen age5164=0 
		replace age5164=1 if age>=51 & age<=64
		replace age5164=. if age==.

*race
	gen raceth=.
	replace raceth=1 if racenew==100 & hispeth==10
	replace raceth=2 if racenew==200 & hispeth==10
	replace raceth=3 if racenew==400 & hispeth==10
	replace raceth=4 if (racenew==300|racenew==500|racenew==510|racenew==520|racenew==521) & hispeth==10
	replace raceth=5 if hispeth~=10 & hispeth~=93
	
	ta raceth, gen(raceth_)
	rename (raceth_1 raceth_2 raceth_3 raceth_4 raceth_5) (raceth_white raceth_black raceth_asian raceth_other hispanic)

*education	
	gen edhs=0
	replace edhs=1 if (educ>=100 & educ<=301)
	replace edhs=. if (educ==000|educ>504)
	gen edcoll=0
		replace edcoll=1 if (educ>=302 & educ<=400)
		replace edcoll=. if (educ==000|educ>504)
	gen edgrad=0
		replace edgrad=1 if (educ>=500 & educ<=504)
		replace edgrad=. if (educ==000|educ>504)
		
*HH size
	gen hhsz=famsize
	replace hhsz=. if famsize==98

*children
	gen anychild=0
		replace anychild=1 if nchild>0
		replace anychild=. if nchild==.
		
* create missing variable for missing income responses
	gen income_missing = 0
	replace income_missing=1 if (incfam07on==96|incfam07on==99)

* create income variables 

	gen income1 = 0
		replace income1 = 1 if incfam07on>=10 & incfam07on<=12
		label variable income1 "Less than $50,000"
	gen income2 = 0
		replace income2 = 1 if incfam07on>=21 & incfam07on<=23
		label variable income2 "$50,000 to less than $100,000"
	gen income3 = 0
		replace income3 = 1 if incfam07on>=24 & incfam07on<96
		label variable income3 "$100,000 or more"

	
* create insurance groups

*ESI 
	recode hiprivatee (2/3=1) (1=0) (7/9=.),  gen(hlthins_esi)

*Other HI 
	gen hlthins_nonesi=0
		replace hlthins_nonesi=1 if (hipubcove==2|hiothgove==20| hiothgove==21| hiothgove==22|himilite==20|himilite==21|himilite==22|himilite==23|himilite==24|himilite==25|himilite==26|histatee==20|histatee==21|histatee==22) & hlthins_esi == 0 

*uninsured 
gen hlthins_unins=0
	replace hlthins_unins=1 if hlthins_esi==0 & hlthins_nonesi==0

gen hlthins_missing=0 
replace hlthins_missing=1 if hlthins_unins==0 & hlthins_esi==0 & hlthins_nonesi==0

gen data="NHIS2019" if year==2019
replace data="NHIS2018" if year==2018

rename perweight pweight
replace pweight=sampweight if year==2019

save "$cdata/nhis2019_2018full.dta", replace

*************************
*** CLEAN ACS2018/2019 data
*************************

use "$rdata/IPUMS_ACS/usa_00006.dta" , clear
*gender
	gen female=0
		replace female =1 if sex==2
		replace female = . if sex==.

*age
	drop if age<18 
	drop if age>64
	gen age1826=0
		replace age1826=1 if age>=18 & age<=26
		replace age1826=. if age==.
	gen age2740=0
		replace age2740=1 if age>=27 & age<=40
		replace age2740=. if age==.
	gen age4150=0
		replace age4150=1 if age>=41 & age<=50
		replace age4150=. if age==.
	gen age5164=0 
		replace age5164=1 if age>=51 & age<=64
		replace age5164=. if age==.

*race
	gen raceth=.
	replace raceth=1 if race==1 & hispan==0
	replace raceth=2 if race==2 & hispan==0
	replace raceth=3 if (race==4|race==5|race==6) & hispan==0
	replace raceth=4 if (race==3|race==7|race==8|race==9) & hispan==0
	replace raceth=5 if hispan~=0
	
	ta raceth, gen(raceth_)
	rename (raceth_1 raceth_2 raceth_3 raceth_4 raceth_5) (raceth_white raceth_black raceth_asian raceth_other hispanic)

*education	
	gen edhs=0
	replace edhs=1 if educ==1 | educ==2 | educ==3 | educ==4|educ==5|educ==6|educ==7 
	replace edhs=. if educ==0
	gen edcoll=0
		replace edcoll=1 if educ==8|educ==10
		replace edcoll=. if educ==0
	gen edgrad=0
		replace edgrad=1 if educ==11
		replace edgrad=. if educ==0
		
*HH size
	gen hhsz=famsize

*children
	gen anychild=0
		replace anychild=1 if nchild>0
		replace anychild=. if nchild==.
		
*urbanacity		
	gen urban=0
		replace urban=1 if metro==2|metro==4 
		replace urban=. if metro==0

* create missing variable for missing income responses
	gen income_missing = 0

* create income variables 

	gen income1 = 0
		replace income1 = 1 if ftotinc>-15200 & ftotinc<50000
		label variable income1 "Less than $50,000"
	gen income2 = 0
		replace income2 = 1 if ftotinc>50000 & ftotinc<100000
		label variable income2 "$50,000 to less than $100,000"
	gen income3 = 0
		replace income3 = 1 if ftotinc>=100000
		label variable income3 "$100,000 or more"

	
* create insurance groups 
	
*ESI 
	recode hinsemp (2=1) (1=0),  gen(hlthins_esi)

*Other HI 
	gen hlthins_nonesi=0
		replace hlthins_nonesi=1 if (hinspur==2 | hinscaid==2 | hinscare==2 | hinstri==2| hinsva==2) & hlthins_esi == 0 

*uninsured 
gen hlthins_unins=0
	replace hlthins_unins=1 if hlthins_esi==0 & hlthins_nonesi==0


gen data="ACS2019" if year==2019
replace data="ACS2018" if year==2018

* create state name variable

gen state = ""
replace state = "AL" if statefip == 1
replace state = "AK" if statefip == 2
replace state = "AZ" if statefip == 4
replace state = "AR" if statefip == 5
replace state = "CA" if statefip == 6
replace state = "CO" if statefip == 8
replace state = "CT" if statefip == 9
replace state = "DE" if statefip == 10
replace state = "DC" if statefip == 11
replace state = "FL" if statefip == 12
replace state = "GA" if statefip == 13
replace state = "HI" if statefip == 15
replace state = "ID" if statefip == 16
replace state = "IL" if statefip == 17
replace state = "IN" if statefip == 18
replace state = "IA" if statefip == 19
replace state = "KS" if statefip == 20
replace state = "KY" if statefip == 21
replace state = "LA" if statefip == 22
replace state = "ME" if statefip == 23
replace state = "MD" if statefip == 24
replace state = "MA" if statefip == 25
replace state = "MI" if statefip == 26
replace state = "MN" if statefip == 27
replace state = "MS" if statefip == 28
replace state = "MO" if statefip == 29
replace state = "MT" if statefip == 30
replace state = "NE" if statefip == 31
replace state = "NV" if statefip == 32
replace state = "NH" if statefip == 33
replace state = "NJ" if statefip == 34
replace state = "NM" if statefip == 35
replace state = "NY" if statefip == 36
replace state = "NC" if statefip == 37
replace state = "ND" if statefip == 38
replace state = "OH" if statefip == 39
replace state = "OK" if statefip == 40
replace state = "OR" if statefip == 41
replace state = "PA" if statefip == 42
replace state = "RI" if statefip == 44
replace state = "SC" if statefip == 45
replace state = "SD" if statefip == 46
replace state = "TN" if statefip == 47
replace state = "TX" if statefip == 48 
replace state = "UT" if statefip == 49
replace state = "VT" if statefip == 50
replace state = "VA" if statefip == 51
replace state = "WA" if statefip == 53
replace state = "WV" if statefip == 54
replace state = "WI" if statefip == 55
replace state = "WY" if statefip == 56

rename statefip est_st

* create variable for states that adopted medicaid expansion policy

gen adopted=.

replace adopted=1 if est_st==2|est_st==4|est_st==5|est_st==6|est_st==8| ///
est_st==9|est_st==10|est_st==11|est_st==15|est_st==16|est_st==17| ///
est_st==18|est_st==19|est_st==21|est_st==22|est_st==23|est_st==24| ///
est_st==25|est_st==26|est_st==27|est_st==29|est_st==30|est_st==31| ///
est_st==32|est_st==33|est_st==34|est_st==35|est_st==36|est_st==38| ///
est_st==39|est_st==40|est_st==41|est_st==42|est_st==44|est_st==49| ///
est_st==50|est_st==51|est_st==53|est_st==54

replace adopted=0 if est_st==1|est_st==12|est_st==13|est_st==20|est_st==28| ///
est_st==37|est_st==45|est_st==46|est_st==47|est_st==48|est_st==55|est_st==56

rename perwt pweight

save "$cdata/acs2019_2018full.dta", replace

**********************************
*** APPENDING PULSE + ACS2018
**********************************
use "$cdata/pulse_full.dta", clear
append using "$cdata/acs2019_2018full.dta"
append using "$cdata/nhis2019_2018full.dta"
drop sample
gen sample1=(data=="ACS2018")
gen sample2=(data=="ACS2019")
gen sample3=(data=="NHIS2018")
gen sample4=(data=="PULSE" & phase==1)
gen sample5=(data=="PULSE" & hlthins_missing~=1 & phase==1)
gen sample6=(data=="PULSE" & hlthins_missing==1 & phase==1)
gen sample8=(data=="PULSE" & (phase==2|phase==3))
gen sample9=(data=="PULSE" & hlthins_missing~=1 & (phase==2|phase==3))
gen sample7=(data=="PULSE" & hlthins_missing==1 & (phase==2|phase==3))

save "$cdata/nhis_acs2019_2018pulse_fullappended.dta", replace





