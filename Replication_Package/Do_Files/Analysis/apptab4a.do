* ==============================================================================
* APPENDIX TABLE 4A
* ==============================================================================

***************
*** PHASE 1 ***
***************

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

keep if phase == 1

* recode weeks to create linear trend variable
gen lweek = week - 1
	replace lweek = lweek + 1 if week > 1
	tab lweek

*****************************
*** INPUT INTO EXCEL FILE ***
*****************************

* Set excel sheet
putexcel set "$results/apptab4a.xlsx", replace

	putexcel D4:G4 = "Spring/Summer", merge hcenter border(bottom)
	putexcel I4:L4 = "Fall/Winter", merge hcenter border(bottom)
	
	putexcel D5 = "Coverage Rate", hcenter border(bottom)
	putexcel E5 = "Weekly Change", hcenter border(bottom)
	putexcel F5 = "P-value", hcenter border(bottom)
	putexcel G5 = "Standard Error", hcenter border(bottom)

	putexcel I5 = "Coverage Rate", hcenter border(bottom)
	putexcel J5 = "Weekly Change", hcenter border(bottom)
	putexcel K5 = "P-value", hcenter border(bottom)
	putexcel L5 = "Standard Error", hcenter border(bottom)
	
	putexcel A6:L6 = "", border(top)
	putexcel A26:L26 = "", border(top)
	
	putexcel A6 = "All"
		putexcel B6 = "Any Private"
		putexcel B7 = "ESI"
		putexcel B8 = "Non-ESI"
		putexcel B9 = "Other Private"
		putexcel B10 = "Medicaid"
		putexcel B11 = "Other Public"
	
	putexcel A13 = "Non-Expansion"
		putexcel B13 = "Any Private"
		putexcel B14 = "ESI"
		putexcel B15 = "Non-ESI"
		putexcel B16 = "Other Private"
		putexcel B17 = "Medicaid"
		putexcel B18 = "Other Public"
	
	putexcel A20 = "Expansion"
		putexcel B20 = "Any Private"
		putexcel B21 = "ESI"
		putexcel B22 = "Non-ESI"
		putexcel B23 = "Other Private"
		putexcel B24 = "Medicaid"
		putexcel B25 = "Other Public"

* ALL

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi hlthins_priv hlthins_medicaid hlthins_public

	matrix A = (e(b))'
	putexcel D6 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E6 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G6 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F6 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E7 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G7 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F7 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E8 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G8 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F8 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E9 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G9 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F9 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E10 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G10 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F10 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E11 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G11 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F11 = matrix(C), hcenter nformat(0.000)

* NON-EXP

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi hlthins_priv hlthins_medicaid hlthins_public if adopted==0

	matrix A = (e(b))'
	putexcel D13 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E13 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G13 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F13 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E14 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G14 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F14 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E15 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G15 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F15 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E16 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G16 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F16 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E17 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G17 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F17 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E18 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G18 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F18 = matrix(C), hcenter nformat(0.000)

* EXP

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi hlthins_priv hlthins_medicaid hlthins_public if adopted==1

	matrix A = (e(b))'
	putexcel D20 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E20 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G20 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F20 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E21 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G21 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F21 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E22 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G22 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F22 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E23 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G23 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F23 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E24 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G24 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F24 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E25 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G25 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F25 = matrix(C), hcenter nformat(0.000)


*****************
*** PHASE 2-3 ***
*****************

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

keep if phase == 2 | phase == 3

* recode weeks to create linear trend variable
gen lweek = (week - 13) * 2 
	tab lweek
	

*****************************
*** INPUT INTO EXCEL FILE ***
*****************************


* ALL

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi hlthins_priv hlthins_medicaid hlthins_public

	matrix A = (e(b))'
	putexcel I6 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J6 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L6 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K6 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J7 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L7 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K7 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J8 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L8 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K8 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J9 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L9 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K9 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J10 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L10 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K10 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J11 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L11 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K11 = matrix(C), hcenter nformat(0.000)

* NON-EXP

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi hlthins_priv hlthins_medicaid hlthins_public if adopted==0

	matrix A = (e(b))'
	putexcel I13 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J13 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L13 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K13 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J14 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L14 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K14 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J15 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L15 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K15 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J16 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L16 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K16 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J17 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L17 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K17 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J18 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L18 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K18 = matrix(C), hcenter nformat(0.000)

* EXP

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi hlthins_priv hlthins_medicaid hlthins_public if adopted==1

	matrix A = (e(b))'
	putexcel I20 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J20 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L20 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K20 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J21 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L21 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K21 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J22 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L22 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K22 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J23 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L23 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K23 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J24 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L24 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K24 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J25 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L25 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K25 = matrix(C), hcenter nformat(0.000)
	


	
