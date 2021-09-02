* ==============================================================================
* CREATE AND LABEL VARIABLES
* ==============================================================================

clear
set more off


***************************
*** Survey Data - PHASE 1-3
***************************

* set survey data with relevant weeks
use "$cdata/hps_w1-21.dta", clear

* label variables

label variable hlthins1 "Employer- or union-sponsored insurance"
label variable hlthins2 "Private insurance"
label variable hlthins3	"Medicare, for people 65 and older, or people with certain disabilities"
label variable hlthins4	"Medicaid, Medical Assistance, or any kind of government-assistance"
label variable hlthins5	"TRICARE or other military health care"
label variable hlthins6	"VA (including those who have ever used or enrolled for VA health care)"
label variable hlthins7	"Indian Health Service"
label variable hlthins8	"Other"
label variable tbirth_year "Birth year"
label variable est_st "State code"
label variable wrkloss "Experienced a loss of employment income since March 13, 2020"
label variable anywork "In the last 7 days, did you do ANY work for either pay or profit"
label variable unemppay "Receiving pay for the time you are not working"
label variable curfoodsuf "Best describes the food eaten in your household?"
label variable income "Total household income before taxes in 2019"
label variable anxious "Feeling nervous, anxious, or on edge"
label variable down "Feeling down, depressed, or hopeless"
label variable delay "Delayed getting medical care because of the coronavirus pandemic"
label variable notget "Did not get medical care because of the coronavirus pandemic"

* create phase variable
gen phase = .
	replace phase = 1 if week >= 1 & week <= 12
	replace phase = 2 if week >= 13 & week <= 17
	replace phase = 3 if week >= 18 & week <= 21
	
* create indicator for phase 2
gen phase_2or3 = .
	replace phase_2or3 = 1 if phase == 2 | phase == 3
	replace phase_2or3 = 0 if phase == 1
la var phase_2or3 "Phase 2 or 3"
	
* create variable for missing hlth ins responses
gen hlthins_missing=0
		replace hlthins_missing=1 if (hlthins1==-88 | hlthins1==-99) ///
		& (hlthins2==-88 | hlthins2==-99) ///
		& (hlthins3==-88 | hlthins3==-99) ///
		& (hlthins4==-88 | hlthins4==-99) ///
		& (hlthins5==-88 | hlthins5==-99) ///
		& (hlthins6==-88 | hlthins6==-99) ///
		& (hlthins7==-88 | hlthins7==-99) ///
		& (hlthins8==-88 | hlthins8==-99)

* create three main insurance groups 

gen hlthins_esi=0
	replace hlthins_esi=1 if hlthins1==1
	replace hlthins_esi=. if hlthins_missing==1

gen hlthins_nonesi=0 /* conditional to not having ESI, excludes IHS and other */
	replace hlthins_nonesi=1 if (hlthins2==1 | hlthins3==1 | hlthins4==1 | hlthins5==1 | hlthins6==1) & hlthins_esi == 0 
	replace hlthins_nonesi=. if hlthins_missing==1
	
gen hlthins_unins=0
	replace hlthins_unins=1 if hlthins_esi==0 & hlthins_nonesi==0
	replace hlthins_unins=. if hlthins_missing==1
	
* specific non-ESI and other specific categories conditional to not having ESI	
	
gen hlthins_priv=0
	replace hlthins_priv=1 if hlthins2==1 & hlthins_esi==0
	replace hlthins_priv=. if hlthins_missing==1
	
gen hlthins_medicaid=0
	replace hlthins_medicaid=1 if hlthins4==1 & hlthins_esi==0
	replace hlthins_medicaid=. if hlthins_missing==1

gen hlthins_public=0
	replace hlthins_public=1 if (hlthins3==1|hlthins5==1|hlthins6==1) & hlthins_esi==0
	replace hlthins_public=. if hlthins_missing==1

* create category for any insurance
	
gen hlthins_anyins=0
	replace hlthins_anyins=1 if hlthins_unins==0
	replace hlthins_anyins=. if hlthins_missing==1

* test missing HI variables for appendix figure 4a and 4b
gen hlthins_test_missing=0
	replace hlthins_test_missing=1 if hlthins_missing==1
	
gen hlthins_test_esi=0
	replace hlthins_test_esi=1 if hlthins1==1  & hlthins_test_missing==0
	
gen hlthins_test_nonesi=0
	replace hlthins_test_nonesi=1 if (hlthins2==1 | hlthins3==1 | hlthins4==1 | hlthins5==1 | hlthins6==1) & hlthins_test_esi == 0 & hlthins_test_missing==0

gen hlthins_test_unins=0
	replace hlthins_test_unins=1 if hlthins_test_esi == 0 & hlthins_test_nonesi == 0 & hlthins_test_missing==0
	
gen hlthins_test_anyins=0
	replace hlthins_test_anyins=1 if hlthins_test_esi==1 | hlthins_test_nonesi==1 
	
gen hlthins_test_priv=0
	replace hlthins_test_priv=1 if hlthins2==1 & hlthins_esi==0 & hlthins_test_missing==0
	
gen hlthins_test_medicaid=0
	replace hlthins_test_medicaid=1 if hlthins4==1 & hlthins_esi==0 & hlthins_test_missing==0

gen hlthins_test_public=0
	replace hlthins_test_public=1 if (hlthins3==1|hlthins5==1|hlthins6==1) & hlthins_esi==0 & hlthins_test_missing==0
	
* create state name variable

gen state = ""
replace state = "AL" if est_st == 1
replace state = "AK" if est_st == 2
replace state = "AZ" if est_st == 4
replace state = "AR" if est_st == 5
replace state = "CA" if est_st == 6
replace state = "CO" if est_st == 8
replace state = "CT" if est_st == 9
replace state = "DE" if est_st == 10
replace state = "DC" if est_st == 11
replace state = "FL" if est_st == 12
replace state = "GA" if est_st == 13
replace state = "HI" if est_st == 15
replace state = "ID" if est_st == 16
replace state = "IL" if est_st == 17
replace state = "IN" if est_st == 18
replace state = "IA" if est_st == 19
replace state = "KS" if est_st == 20
replace state = "KY" if est_st == 21
replace state = "LA" if est_st == 22
replace state = "ME" if est_st == 23
replace state = "MD" if est_st == 24
replace state = "MA" if est_st == 25
replace state = "MI" if est_st == 26
replace state = "MN" if est_st == 27
replace state = "MS" if est_st == 28
replace state = "MO" if est_st == 29
replace state = "MT" if est_st == 30
replace state = "NE" if est_st == 31
replace state = "NV" if est_st == 32
replace state = "NH" if est_st == 33
replace state = "NJ" if est_st == 34
replace state = "NM" if est_st == 35
replace state = "NY" if est_st == 36
replace state = "NC" if est_st == 37
replace state = "ND" if est_st == 38
replace state = "OH" if est_st == 39
replace state = "OK" if est_st == 40
replace state = "OR" if est_st == 41
replace state = "PA" if est_st == 42
replace state = "RI" if est_st == 44
replace state = "SC" if est_st == 45
replace state = "SD" if est_st == 46
replace state = "TN" if est_st == 47
replace state = "TX" if est_st == 48 
replace state = "UT" if est_st == 49
replace state = "VT" if est_st == 50
replace state = "VA" if est_st == 51
replace state = "WA" if est_st == 53
replace state = "WV" if est_st == 54
replace state = "WI" if est_st == 55
replace state = "WY" if est_st == 56

* encode state variable
encode state, gen(state_d)

* create age filter

gen age=.
replace age=2020-tbirth_year

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

* create missing variable for missing income responses
gen income_missing = 0
replace income_missing = 1 if income == -99 | income == -88
label variable income_missing "Missing response for income"

* create income variables (3 levels)

gen inc_low=.
replace inc_low=1 if income==1|income==2|income==3
replace inc_low=0 if income>3

gen inc_mid=.
replace inc_mid=1 if income==4|income==5
replace inc_mid=0 if income==1|income==2|income==3
replace inc_mid=0 if income>=6

gen inc_high=.
replace inc_high=1 if income>=6
replace inc_high=0 if income>=1 & income <=5

* create income variables (6 levels)

gen income1 = 0
	replace income1 = 1 if income == 1
	replace income1 = . if income_missing == 1
	label variable income1 "Less than $25,000"
gen income2 = 0
	replace income2 = 1 if income == 2 | income == 3
	replace income2 = . if income_missing == 1
	label variable income2 "$25,000 to less than $50,000"
gen income3 = 0
	replace income3 = 1 if income == 4
	replace income3 = . if income_missing == 1
	label variable income3 "$50,000 to less than $75,000"
gen income4 = 0
	replace income4 = 1 if income == 5
	replace income4 = . if income_missing == 1
	label variable income4 "$75,000 to less than $100,000"
gen income5 = 0
	replace income5 = 1 if income == 6 
	replace income5 = . if income_missing == 1
	label variable income5 "$100,000 to less than $150,000"
gen income6 = 0
	replace income6 = 1 if income == 7 | income == 8
	replace income6 = . if income_missing == 1
	label variable income6 "$150,000 or more"


* create variables for individual characteristics

/*recode individual characteristics*/
gen female=0
	replace female =1 if egender==2
	replace female = . if egender==.
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
gen hispanic=0
	replace hispanic=1 if rhispanic==2
	replace hispanic=. if rhispanic==.	
gen rblack=0
	replace rblack=1 if rrace==2
	replace rblack=. if rrace==.
gen rasian=0
	replace rasian=1 if rrace==3
	replace rasian=. if rrace==.
gen rothmix=0
	replace rothmix=1 if rrace==4
	replace rothmix=1 if rrace==.
gen raceth=.
	replace raceth=1 if rrace==1 & rhispanic~=2
	replace raceth=2 if rrace==2 & rhispanic~=2
	replace raceth=3 if rrace==3 & rhispanic~=2
	replace raceth=4 if rrace==4 & rhispanic~=2
	replace raceth=5 if rhispanic==2
gen raceth_white=0
	replace raceth_white=1 if rrace==1 & rhispanic~=2	
gen raceth_black=0
	replace raceth_black=1 if rrace==2 & rhispanic~=2	
gen raceth_asian=0
	replace raceth_asian=1 if rrace==3 & rhispanic~=2	
gen raceth_other=0
	replace raceth_other=1 if rrace==4 & rhispanic~=2
gen edhs=0
	replace edhs=1 if eeduc==1 | eeduc==2 | eeduc==3 | eeduc==4
	replace edhs=. if eeduc==.
gen edcoll=0
	replace edcoll=1 if eeduc==5 | eeduc==6
	replace edcoll=. if eeduc==.
gen edgrad=0
	replace edgrad=1 if eeduc==7
	replace edgrad=. if eeduc==.
gen hhsz=thhld_numper
gen anychild=0
	replace anychild=1 if thhld_numkid>0
	replace anychild=. if thhld_numkid==.
gen urban=0
	replace urban=1 if est_msa~=.
	
* examine linear trend by week - adjusted categories

* old version
gen week12=week/12
gen week12adopt=week12*adopted
label var week12 "Linear Trend by Week"

* new version, suggested by reviewer
gen week_rev = week-1
gen week11 = week_rev/11
gen week11adopt = week11*adopted
label var week11 "Linear Trend by Week"

* create three age categories
gen agecat = .
	replace agecat = 1 if age >= 18 & age <= 26
	replace agecat = 2 if age >= 27 & age <= 50
	replace agecat = 3 if age >= 51

* create and label week dummy variables
forvalues i = 1(1)21{
	gen week_`i'=0
	replace week_`i' = 1 if week == `i'
}

label var week_1 "Apr 23-May 5"
label var week_2 "May 7-May 12"
label var week_3 "May 14-May 19"
label var week_4 "May 21-May 26"
label var week_5 "May 28-Jun 2"
label var week_6 "Jun 4-Jun 9"
label var week_7 "Jun 11-Jun 16"
label var week_8 "Jun 18-Jun 23"
label var week_9 "Jun 25-Jun 30"
label var week_10 "Jul 2-Jul 7"
label var week_11 "Jul 9-Jul 14"
label var week_12 "Jul 16-Jul 21"

label var week_13 "Aug 19-Aug 31"
label var week_14 "Sep 2-Sep 14"
label var week_15 "Sep 16-Sep 28"
label var week_16 "Sep 30-Oct 12"
label var week_17 "Oct 14-Oct 26"
label var week_18 "Oct 28-Nov 9"
label var week_19 "Nov 11-Nov 23"
label var week_20 "Nov 25-Dec 7"
label var week_21 "Dec 9-Dec 21"

* create week interactions for weeks 14-21
forvalues i = 14(1)21{
	gen week_`i'interact = week_`i' * phase_2or3
} 

* create marital status variable
gen ms_married = .
	replace ms_married = 1 if ms == 1
	replace ms_married = 0 if ms > 1
	
gen ms_widowed = .
	replace ms_widowed = 1 if ms == 2
	replace ms_widowed = 0 if ms == 1|ms > 2
	
gen ms_divorced = .
	replace ms_divorced = 1 if ms == 3
	replace ms_divorced = 0 if ms == 1|ms == 2|ms > 3
	
gen ms_separated = .
	replace ms_separated = 1 if ms == 4
	replace ms_separated = 0 if ms == 1|ms == 2|ms == 3|ms > 4

gen ms_nevermarried = .
	replace ms_nevermarried = 1 if ms == 5
	replace ms_nevermarried = 0 if ms == 1|ms == 2|ms == 3|ms == 4
	
gen ms_notmarried = .
	replace ms_notmarried = 1 if ms == 2|ms == 3|ms == 4|ms == 5
	replace ms_notmarried = 0 if ms == 1
	
gen ms_missing = .
	replace ms_missing = 1 if ms == -88|ms == -99
	replace ms_missing = 0 if ms >= 1

* label variables

label variable state "State name"

label variable adopted "States that adopted Medicaid expansion policy"

label variable inc_low "Income range is less than $25,000, $25,000 - $34,999, or $35,000 - $49,999"
label variable inc_mid "Income range is $50,000 - $74,999, or $75,000 - $99,999"
label variable inc_high "Income range is $100,000 - $149,999, $150,000 - $199,999, or $200,000 and above"

label var female "Female" 
label var age1826 "Age 18-26" 
label var age2740 "Age 27-40"
label var age4150 "Age 41-50"
label var age5164 "Age 51-64"
label var hispanic "Hispanic"
label var rblack "Black"
label var rasian "Asian"
label var rothmix "Other Race"

	label var raceth_white "Non-Hispanic White"
	label var raceth_black "Non-Hispanic Black"
	label var raceth_asian "Non-Hispanic Asian"
	label var raceth_other "Non-Hispanic Other"

label var edhs "High School Diploma"
label var edcoll "College Degree"
label var edgrad "Graduate Degree"
label var hhsz "Household"
label var anychild "Any Child"

	label variable income1 "Income $0-$24999"
	label variable income2 "Income $25000-$49999"
	label variable income3 "Income $50000-$74999"
	label variable income4 "Income $75000-$99999"
	label variable income5 "Income $100000-$149999"
	label variable income6 "Income $150000+"

label var income_missing "Income Missing"

label var hlthins_esi "ESI"
label var hlthins_nonesi "Non-ESI"
label var hlthins_unins "Uninsured"
label var hlthins_priv "Private"
label var hlthins_medicaid "Medicaid"
label var hlthins_public "Public"
label var hlthins_anyins "Any Insurance"
label var hlthins_missing "Insurance Missing"

	label var hlthins_test_esi "ESI"
	label var hlthins_test_nonesi "Non-ESI"
	label var hlthins_test_unins "Uninsured"
	label var hlthins_test_priv "Private"
	label var hlthins_test_medicaid "Medicaid"
	label var hlthins_test_public "Public"
	label var hlthins_test_anyins "Any Insurance"

label var ms_married "Married"
label var ms_widowed "Widowed"
label var ms_divorced "Divorced"
label var ms_separated "Separated"
label var ms_nevermarried "Never Married"
label var ms_notmarried "Not Married"
label var ms_missing "Marital Status Missing"


* save
save "$cdata/hps_w1-21v.dta", replace

*********************
*** Unemployment Data
*********************

* import data

use "$rdata/pulse/dta/UNRATENSA.dta", clear

* destring variables

gen date_temp=date(date, "YMD", 2021)
format date_temp %td
drop date
rename date_temp date

* save

save "$cdata/UNRATENSA_clean.dta", replace

