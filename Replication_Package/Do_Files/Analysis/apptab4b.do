* ==============================================================================
* APPENDIX TABLE 4B
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
putexcel set "$results/apptab4b.xlsx", replace

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
	putexcel A53:L53 = "", border(top)
	
	putexcel A6 = "Male"
		putexcel B6 = "Any Private"
		putexcel B7 = "ESI"
		putexcel B8 = "Non-ESI"

	putexcel A10 = "Female"
		putexcel B10 = "Any Private"
		putexcel B11 = "ESI"
		putexcel B12 = "Non-ESI"		
		
	putexcel A14 = "Age 18-26"
		putexcel B14 = "Any Private"
		putexcel B15 = "ESI"
		putexcel B16 = "Non-ESI"		
		
	putexcel A18 = "Age 27-50"
		putexcel B18 = "Any Private"
		putexcel B19 = "ESI"
		putexcel B20 = "Non-ESI"	
	
	putexcel A22 = "Age 51-64"
		putexcel B22 = "Any Private"
		putexcel B23 = "ESI"
		putexcel B24 = "Non-ESI"	
	
	putexcel A26 = "White"
		putexcel B26 = "Any Private"
		putexcel B27 = "ESI"
		putexcel B28 = "Non-ESI"
		
	putexcel A30 = "Black"
		putexcel B30 = "Any Private"
		putexcel B31 = "ESI"
		putexcel B32 = "Non-ESI"		
		
	putexcel A34 = "Asian"
		putexcel B34 = "Any Private"
		putexcel B35 = "ESI"
		putexcel B36 = "Non-ESI"	
	
	putexcel A38 = "Hispanic"
		putexcel B38 = "Any Private"
		putexcel B39 = "ESI"
		putexcel B40 = "Non-ESI"	
	
	putexcel A42 = "Low Income"
		putexcel B42 = "Any Private"
		putexcel B43 = "ESI"
		putexcel B44 = "Non-ESI"

	putexcel A46 = "Middle Income"
		putexcel B46 = "Any Private"
		putexcel B47 = "ESI"
		putexcel B48 = "Non-ESI"	
	
	putexcel A50 = "High Income"
		putexcel B50 = "Any Private"
		putexcel B51 = "ESI"
		putexcel B52 = "Non-ESI"

* MALE

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if female==0

	matrix A = (e(b))'
	putexcel D6 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E6 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G6 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F6 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E7 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G7 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F7 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E8 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G8 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F8 = matrix(C), hcenter nformat(0.000)

* FEMALE

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if female==1

	matrix A = (e(b))'
	putexcel D10 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E10 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G10 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F10 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E11 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G11 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F11 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E12 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G12 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F12 = matrix(C), hcenter nformat(0.000)


* AGE 18-26

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if agecat==1

	matrix A = (e(b))'
	putexcel D14 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E14 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G14 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F14 = matrix(C), hcenter nformat(0.000)


svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E15 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G15 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F15 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E16 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G16 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F16 = matrix(C), hcenter nformat(0.000)

* AGE 27-50

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if agecat==2

	matrix A = (e(b))'
	putexcel D18 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E18 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G18 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F18 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E19 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G19 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F19 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E20 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G20 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F20 = matrix(C), hcenter nformat(0.000)

* AGE 51-64

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if agecat==3

	matrix A = (e(b))'
	putexcel D22 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E22 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G22 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F22 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E23 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G23 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F23 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E24 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G24 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F24 = matrix(C), hcenter nformat(0.000)

* NON-HISP WHITE

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if raceth_white==1

	matrix A = (e(b))'
	putexcel D26 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E26 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G26 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F26 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E27 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G27 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F27 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E28 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G28 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F28 = matrix(C), hcenter nformat(0.000)
		
* NON-HISP BLACK

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if raceth_black==1

	matrix A = (e(b))'
	putexcel D30 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E30 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G30 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F30 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E31 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G31 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F31 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E32 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G32 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F32 = matrix(C), hcenter nformat(0.000)

* NON-HISP ASIAN

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if raceth_asian==1

	matrix A = (e(b))'
	putexcel D34 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E34 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G34 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F34 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E35 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G35 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F35 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E36 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G36 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F36 = matrix(C), hcenter nformat(0.000)

*HISPANIC

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if hispanic==1

	matrix A = (e(b))'
	putexcel D38 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E38 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G38 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F38 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E39 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G39 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F39 = matrix(C), hcenter nformat(0.000)
svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E40 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G40 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F40 = matrix(C), hcenter nformat(0.000)

* LOW INCOME

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if inc_low==1

	matrix A = (e(b))'
	putexcel D42 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E42 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G42 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F42 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E43 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G43 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F43 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E44 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G44 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F44 = matrix(C), hcenter nformat(0.000)

* MID INCOME

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if inc_mid==1

	matrix A = (e(b))'
	putexcel D46 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E46 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G46 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F46 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E47 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G47 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F47 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E48 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G48 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F48 = matrix(C), hcenter nformat(0.000)

* HIGH INCOME

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if inc_high==1

	matrix A = (e(b))'
	putexcel D50 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E50 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G50 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F50 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E51 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G51 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F51 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel E52 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel G52 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel F52 = matrix(C), hcenter nformat(0.000)


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
	
* MALE

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if female==0

	matrix A = (e(b))'
	putexcel I6 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J6 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L6 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K6 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J7 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L7 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K7 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J8 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L8 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K8 = matrix(C), hcenter nformat(0.000)

* FEMALE

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if female==1

	matrix A = (e(b))'
	putexcel I10 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J10 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L10 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K10 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J11 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L11 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K11 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J12 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L12 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K12 = matrix(C), hcenter nformat(0.000)


* AGE 18-26

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if agecat==1

	matrix A = (e(b))'
	putexcel I14 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J14 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L14 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K14 = matrix(C), hcenter nformat(0.000)


svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J15 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L15 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K15 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J16 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L16 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K16 = matrix(C), hcenter nformat(0.000)

* AGE 27-50

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if agecat==2

	matrix A = (e(b))'
	putexcel I18 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J18 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L18 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K18 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J19 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L19 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K19 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J20 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L20 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K20 = matrix(C), hcenter nformat(0.000)

* AGE 51-64

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if agecat==3

	matrix A = (e(b))'
	putexcel I22 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J22 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L22 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K22 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J23 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L23 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K23 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J24 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L24 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K24 = matrix(C), hcenter nformat(0.000)

* NON-HISP WHITE

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if raceth_white==1

	matrix A = (e(b))'
	putexcel I26 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J26 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L26 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K26 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J27 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L27 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K27 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J28 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L28 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K28 = matrix(C), hcenter nformat(0.000)
		
* NON-HISP BLACK

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if raceth_black==1

	matrix A = (e(b))'
	putexcel I30 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J30 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L30 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K30 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J31 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L31 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K31 = matrix(C), hcenter nformat(0.000)
		
svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J32 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L32 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K32 = matrix(C), hcenter nformat(0.000)

* NON-HISP ASIAN

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if raceth_asian==1

	matrix A = (e(b))'
	putexcel I34 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J34 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L34 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K34 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J35 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L35 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K35 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J36 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L36 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K36 = matrix(C), hcenter nformat(0.000)

*HISPANIC

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if hispanic==1

	matrix A = (e(b))'
	putexcel I38 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J38 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L38 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K38 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J39 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L39 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K39 = matrix(C), hcenter nformat(0.000)
svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J40 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L40 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K40 = matrix(C), hcenter nformat(0.000)

* LOW INCOME

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if inc_low==1

	matrix A = (e(b))'
	putexcel I42 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J42 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L42 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K42 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J43 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L43 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K43 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J44 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L44 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K44 = matrix(C), hcenter nformat(0.000)

* MID INCOME

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if inc_mid==1

	matrix A = (e(b))'
	putexcel I46 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J46 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L46 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K46 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J47 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L47 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K47 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J48 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L48 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K48 = matrix(C), hcenter nformat(0.000)

* HIGH INCOME

* Input coverage rate
svy: mean hlthins_anyins hlthins_esi hlthins_nonesi if inc_high==1

	matrix A = (e(b))'
	putexcel I50 = matrix(A), hcenter nformat(0.000)

* Input weekly change
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J50 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L50 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K50 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J51 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L51 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K51 = matrix(C), hcenter nformat(0.000)

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

	matrix A = r(table)'
	matrix A = A[1,1]
		putexcel J52 = matrix(A), hcenter nformat(0.0000) 
	matrix B = r(table)'
	matrix B = B[1,2]
		putexcel L52 = matrix(B), hcenter nformat((0.0000))
	matrix C = r(table)'
	matrix C = C[1,4]
		putexcel K52 = matrix(C), hcenter nformat(0.000)

	
