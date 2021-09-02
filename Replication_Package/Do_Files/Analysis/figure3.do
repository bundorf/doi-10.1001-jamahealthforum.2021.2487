* ==============================================================================
* FIGURE 3
* ==============================================================================

clear
set more off

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

******************************************
*** CREATING BAR AND CI INTERVAL GRAPH ***
******************************************

mat M1=J(64,9, .)
mat M2=J(64,9, .)
mat M3=J(64,9, .)
mat M4=J(64,9, .)
mat M5=J(64,9, .)
mat M6=J(64,9, .)
mat M7=J(64,9, .)
mat M8=J(64,9, .)
mat M9=J(64,9, .)
mat M10=J(64,9, .)
mat M11=J(64,9, .)
mat M12=J(64,9, .)
mat M13=J(64,9, .)

* ALL
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m1=r(table)'
local rows=rowsof(m1)
forvalues t=1(1)`rows'{
mat M1[`t',1]=m1[`t',1]
	mat M1[`t',2]=m1[`t',5]
	mat M1[`t',3]=m1[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m2=r(table)'
local rows=rowsof(m2)
forvalues t=1(1)`rows'{
mat M1[`t',4]=m2[`t',1]
	mat M1[`t',5]=m2[`t',5]
	mat M1[`t',6]=m2[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m3=r(table)'
local rows=rowsof(m3)
forvalues t=1(1)`rows'{
mat M1[`t',7]=m3[`t',1]
	mat M1[`t',8]=m3[`t',5]
	mat M1[`t',9]=m3[`t',6]
}

* MALE

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

mat m10=r(table)'
local rows=rowsof(m10)
forvalues t=1(1)`rows'{
mat M2[`t',1]=m10[`t',1]
	mat M2[`t',2]=m10[`t',5]
	mat M2[`t',3]=m10[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

mat m11=r(table)'
local rows=rowsof(m11)
forvalues t=1(1)`rows'{
mat M2[`t',4]=m11[`t',1]
	mat M2[`t',5]=m11[`t',5]
	mat M2[`t',6]=m11[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

mat m12=r(table)'
local rows=rowsof(m12)
forvalues t=1(1)`rows'{
mat M2[`t',7]=m12[`t',1]
	mat M2[`t',8]=m12[`t',5]
	mat M2[`t',9]=m12[`t',6]
}

* FEMALE

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

mat m13=r(table)'
local rows=rowsof(m13)
forvalues t=1(1)`rows'{
mat M3[`t',1]=m13[`t',1]
	mat M3[`t',2]=m13[`t',5]
	mat M3[`t',3]=m13[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

mat m14=r(table)'
local rows=rowsof(m14)
forvalues t=1(1)`rows'{
mat M3[`t',4]=m14[`t',1]
	mat M3[`t',5]=m14[`t',5]
	mat M3[`t',6]=m14[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

mat m15=r(table)'
local rows=rowsof(m15)
forvalues t=1(1)`rows'{
mat M3[`t',7]=m15[`t',1]
	mat M3[`t',8]=m15[`t',5]
	mat M3[`t',9]=m15[`t',6]
}

* AGE 18-26

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

mat m16=r(table)'
local rows=rowsof(m16)
forvalues t=1(1)`rows'{
mat M4[`t',1]=m16[`t',1]
	mat M4[`t',2]=m16[`t',5]
	mat M4[`t',3]=m16[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

mat m17=r(table)'
local rows=rowsof(m17)
forvalues t=1(1)`rows'{
mat M4[`t',4]=m17[`t',1]
	mat M4[`t',5]=m17[`t',5]
	mat M4[`t',6]=m17[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

mat m18=r(table)'
local rows=rowsof(m18)
forvalues t=1(1)`rows'{
mat M4[`t',7]=m18[`t',1]
	mat M4[`t',8]=m18[`t',5]
	mat M4[`t',9]=m18[`t',6]
}

* AGE 27-50

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

mat m19=r(table)'
local rows=rowsof(m19)
forvalues t=1(1)`rows'{
mat M5[`t',1]=m19[`t',1]
	mat M5[`t',2]=m19[`t',5]
	mat M5[`t',3]=m19[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

mat m20=r(table)'
local rows=rowsof(m20)
forvalues t=1(1)`rows'{
mat M5[`t',4]=m20[`t',1]
	mat M5[`t',5]=m20[`t',5]
	mat M5[`t',6]=m20[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

mat m21=r(table)'
local rows=rowsof(m21)
forvalues t=1(1)`rows'{
mat M5[`t',7]=m21[`t',1]
	mat M5[`t',8]=m21[`t',5]
	mat M5[`t',9]=m21[`t',6]
}

* AGE 51-64

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

mat m22=r(table)'
local rows=rowsof(m22)
forvalues t=1(1)`rows'{
mat M6[`t',1]=m22[`t',1]
	mat M6[`t',2]=m22[`t',5]
	mat M6[`t',3]=m22[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

mat m23=r(table)'
local rows=rowsof(m23)
forvalues t=1(1)`rows'{
mat M6[`t',4]=m23[`t',1]
	mat M6[`t',5]=m23[`t',5]
	mat M6[`t',6]=m23[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

mat m24=r(table)'
local rows=rowsof(m24)
forvalues t=1(1)`rows'{
mat M6[`t',7]=m24[`t',1]
	mat M6[`t',8]=m24[`t',5]
	mat M6[`t',9]=m24[`t',6]
}

* NON-HISP WHITE

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

mat m25=r(table)'
local rows=rowsof(m25)
forvalues t=1(1)`rows'{
mat M7[`t',1]=m25[`t',1]
	mat M7[`t',2]=m25[`t',5]
	mat M7[`t',3]=m25[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

mat m26=r(table)'
local rows=rowsof(m26)
forvalues t=1(1)`rows'{
mat M7[`t',4]=m26[`t',1]
	mat M7[`t',5]=m26[`t',5]
	mat M7[`t',6]=m26[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

mat m27=r(table)'
local rows=rowsof(m27)
forvalues t=1(1)`rows'{
mat M7[`t',7]=m27[`t',1]
	mat M7[`t',8]=m27[`t',5]
	mat M7[`t',9]=m27[`t',6]
}

* NON-HISP BLACK

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

mat m28=r(table)'
local rows=rowsof(m28)
forvalues t=1(1)`rows'{
mat M8[`t',1]=m28[`t',1]
	mat M8[`t',2]=m28[`t',5]
	mat M8[`t',3]=m28[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

mat m29=r(table)'
local rows=rowsof(m29)
forvalues t=1(1)`rows'{
mat M8[`t',4]=m29[`t',1]
	mat M8[`t',5]=m29[`t',5]
	mat M8[`t',6]=m29[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

mat m30=r(table)'
local rows=rowsof(m30)
forvalues t=1(1)`rows'{
mat M8[`t',7]=m30[`t',1]
	mat M8[`t',8]=m30[`t',5]
	mat M8[`t',9]=m30[`t',6]
}

* NON-HISP ASIAN

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

mat m31=r(table)'
local rows=rowsof(m31)
forvalues t=1(1)`rows'{
mat M9[`t',1]=m31[`t',1]
	mat M9[`t',2]=m31[`t',5]
	mat M9[`t',3]=m31[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

mat m32=r(table)'
local rows=rowsof(m32)
forvalues t=1(1)`rows'{
mat M9[`t',4]=m32[`t',1]
	mat M9[`t',5]=m32[`t',5]
	mat M9[`t',6]=m32[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

mat m33=r(table)'
local rows=rowsof(m33)
forvalues t=1(1)`rows'{
mat M9[`t',7]=m33[`t',1]
	mat M9[`t',8]=m33[`t',5]
	mat M9[`t',9]=m33[`t',6]
}

*HISPANIC

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

mat m34=r(table)'
local rows=rowsof(m34)
forvalues t=1(1)`rows'{
mat M10[`t',1]=m34[`t',1]
	mat M10[`t',2]=m34[`t',5]
	mat M10[`t',3]=m34[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

mat m35=r(table)'
local rows=rowsof(m35)
forvalues t=1(1)`rows'{
mat M10[`t',4]=m35[`t',1]
	mat M10[`t',5]=m35[`t',5]
	mat M10[`t',6]=m35[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

mat m36=r(table)'
local rows=rowsof(m36)
forvalues t=1(1)`rows'{
mat M10[`t',7]=m36[`t',1]
	mat M10[`t',8]=m36[`t',5]
	mat M10[`t',9]=m36[`t',6]
}

* LOW INCOME

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

mat m37=r(table)'
local rows=rowsof(m37)
forvalues t=1(1)`rows'{
mat M11[`t',1]=m37[`t',1]
	mat M11[`t',2]=m37[`t',5]
	mat M11[`t',3]=m37[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

mat m38=r(table)'
local rows=rowsof(m38)
forvalues t=1(1)`rows'{
mat M11[`t',4]=m38[`t',1]
	mat M11[`t',5]=m38[`t',5]
	mat M11[`t',6]=m38[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

mat m39=r(table)'
local rows=rowsof(m39)
forvalues t=1(1)`rows'{
mat M11[`t',7]=m39[`t',1]
	mat M11[`t',8]=m39[`t',5]
	mat M11[`t',9]=m39[`t',6]
}

* MID INCOME

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

mat m40=r(table)'
local rows=rowsof(m40)
forvalues t=1(1)`rows'{
mat M12[`t',1]=m40[`t',1]
	mat M12[`t',2]=m40[`t',5]
	mat M12[`t',3]=m40[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

mat m41=r(table)'
local rows=rowsof(m41)
forvalues t=1(1)`rows'{
mat M12[`t',4]=m41[`t',1]
	mat M12[`t',5]=m41[`t',5]
	mat M12[`t',6]=m41[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

mat m42=r(table)'
local rows=rowsof(m42)
forvalues t=1(1)`rows'{
mat M12[`t',7]=m42[`t',1]
	mat M12[`t',8]=m42[`t',5]
	mat M12[`t',9]=m42[`t',6]
}

* HIGH INCOME

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

mat m43=r(table)'
local rows=rowsof(m43)
forvalues t=1(1)`rows'{
mat M13[`t',1]=m43[`t',1]
	mat M13[`t',2]=m43[`t',5]
	mat M13[`t',3]=m43[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

mat m44=r(table)'
local rows=rowsof(m44)
forvalues t=1(1)`rows'{
mat M13[`t',4]=m44[`t',1]
	mat M13[`t',5]=m44[`t',5]
	mat M13[`t',6]=m44[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

mat m45=r(table)'
local rows=rowsof(m45)
forvalues t=1(1)`rows'{
mat M13[`t',7]=m45[`t',1]
	mat M13[`t',8]=m45[`t',5]
	mat M13[`t',9]=m45[`t',6]
}

mat U1 = J(64,1,1)
mat U2 = J(64,1,2)
mat U3 = J(64,1,3)
mat U4 = J(64,1,4)
mat U5 = J(64,1,5)
mat U6 = J(64,1,6)
mat U7 = J(64,1,7)
mat U8 = J(64,1,8)
mat U9 = J(64,1,9)
mat U10 = J(64,1,10)
mat U11 = J(64,1,11)
mat U12 = J(64,1,12)
mat U13 = J(64,1,13)

mat M101=U1,M1
mat M202=U2,M2
mat M303=U3,M3
mat M404=U4,M4
mat M505=U5,M5
mat M606=U6,M6
mat M707=U7,M7
mat M808=U8,M8
mat M909=U9,M9
mat M1010=U10,M10
mat M1111=U11,M11
mat M1212=U12,M12
mat M1313=U13,M13


mat M=M101\M202\M303\M404\M505\M606\M707\M808\M909\M1010\M1111\M1212\M1313

svmat M, n(coef)

rename (coef1-coef10) ///
(type  anyins_b anyins_lci anyins_uci ///
 esi_b esi_lci esi_uci ///
 nonesi_b nonesi_lci nonesi_uci )

label define typel 1 "All" 2 "Male" 3 "Female" 4 "Age 18-26" 5 "Age 27-50" 6 "Age 51-64" ///
	7 "White" 8 "Black" 9 "Asian" 10 "Hispanic" ///
	11 "Low Income" 12 "Middle Income" 13 "High Income"
label values type typel  

bysort type: gen counter=_n
gen barposition = cond(type==1, _n, _n+1)

replace type=type-.2
gen type2 = type+.20
gen type3 = type+.4
gen type4=type-.10
gen type5 = type+.125
gen type6 = type+.325

gen esi_b2=esi_b
gen nonesi_b2=nonesi_b
gen anyins_b2=anyins_b

format esi_b2 %9.3f
format nonesi_b2 %9.3f
format anyins_b2 %9.3f
format esi_b %9.3f
format nonesi_b %9.3f
format anyins_b %9.3f

* set graph design
set scheme plotplain, permanently
  
* horizontal CI's  
twoway (scatter type anyins_b if counter==1, yscale(rev) msym(o) mcol(black*0.75)) || ///
     (rcap  anyins_lci anyins_uci type if counter==1, yscale(rev) horizontal lcol(black*0.75) lpattern(solid)) || ///
	(scatter type2 esi_b if counter==1, yscale(rev) msym(o) mcol(black*0.5)) || ///
	(rcap esi_lci esi_uci type2 if counter==1, yscale(rev) horizontal lcol(black*0.5) lpattern(solid)) ///
	(scatter type3 nonesi_b if counter==1, yscale(rev) msym(o) mcol(black*0.2)) || ///
		(rcap nonesi_lci nonesi_uci type3  if counter==1, yscale(rev) horizontal lcol(black*0.2) lpattern(solid)) ||, ///
  xline(0, lcolor(cranberry*0.5)) ///
  legend(order(1 "Any Insurance" 3 "Emp. Spons. Ins." 5 "Other Insurance") pos(6) cols(3) size(2.5)) ///
  ysize(7) xlabel(-0.010(0.005)0.010, nogrid) ///
  ylabel( 1 "All" 2 "Male" 3 "Female" 4 "Age 18-26" 5 "Age 27-50" 6 "Age 51-64" ///
	7 "White" 8 "Black" 9 "Asian" 10 "Hispanic" ///
	11 "Low Income" 12 "Middle Income" 13 "High Income", nogrid) name(figure3_phase1, replace) ///
  b1title("Weekly Percentage Point Change", size(2.5)) b2title("Spring/Summer")

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
	
******************************************
*** CREATING BAR AND CI INTERVAL GRAPH ***
******************************************

mat M1=J(64,9, .)
mat M2=J(64,9, .)
mat M3=J(64,9, .)
mat M4=J(64,9, .)
mat M5=J(64,9, .)
mat M6=J(64,9, .)
mat M7=J(64,9, .)
mat M8=J(64,9, .)
mat M9=J(64,9, .)
mat M10=J(64,9, .)
mat M11=J(64,9, .)
mat M12=J(64,9, .)
mat M13=J(64,9, .)

* ALL
svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m1=r(table)'
local rows=rowsof(m1)
forvalues t=1(1)`rows'{
mat M1[`t',1]=m1[`t',1]
	mat M1[`t',2]=m1[`t',5]
	mat M1[`t',3]=m1[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m2=r(table)'
local rows=rowsof(m2)
forvalues t=1(1)`rows'{
mat M1[`t',4]=m2[`t',1]
	mat M1[`t',5]=m2[`t',5]
	mat M1[`t',6]=m2[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m3=r(table)'
local rows=rowsof(m3)
forvalues t=1(1)`rows'{
mat M1[`t',7]=m3[`t',1]
	mat M1[`t',8]=m3[`t',5]
	mat M1[`t',9]=m3[`t',6]
}

* MALE

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

mat m10=r(table)'
local rows=rowsof(m10)
forvalues t=1(1)`rows'{
mat M2[`t',1]=m10[`t',1]
	mat M2[`t',2]=m10[`t',5]
	mat M2[`t',3]=m10[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

mat m11=r(table)'
local rows=rowsof(m11)
forvalues t=1(1)`rows'{
mat M2[`t',4]=m11[`t',1]
	mat M2[`t',5]=m11[`t',5]
	mat M2[`t',6]=m11[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==0

mat m12=r(table)'
local rows=rowsof(m12)
forvalues t=1(1)`rows'{
mat M2[`t',7]=m12[`t',1]
	mat M2[`t',8]=m12[`t',5]
	mat M2[`t',9]=m12[`t',6]
}

* FEMALE

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

mat m13=r(table)'
local rows=rowsof(m13)
forvalues t=1(1)`rows'{
mat M3[`t',1]=m13[`t',1]
	mat M3[`t',2]=m13[`t',5]
	mat M3[`t',3]=m13[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

mat m14=r(table)'
local rows=rowsof(m14)
forvalues t=1(1)`rows'{
mat M3[`t',4]=m14[`t',1]
	mat M3[`t',5]=m14[`t',5]
	mat M3[`t',6]=m14[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if female==1

mat m15=r(table)'
local rows=rowsof(m15)
forvalues t=1(1)`rows'{
mat M3[`t',7]=m15[`t',1]
	mat M3[`t',8]=m15[`t',5]
	mat M3[`t',9]=m15[`t',6]
}

* AGE 18-26

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

mat m16=r(table)'
local rows=rowsof(m16)
forvalues t=1(1)`rows'{
mat M4[`t',1]=m16[`t',1]
	mat M4[`t',2]=m16[`t',5]
	mat M4[`t',3]=m16[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

mat m17=r(table)'
local rows=rowsof(m17)
forvalues t=1(1)`rows'{
mat M4[`t',4]=m17[`t',1]
	mat M4[`t',5]=m17[`t',5]
	mat M4[`t',6]=m17[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==1

mat m18=r(table)'
local rows=rowsof(m18)
forvalues t=1(1)`rows'{
mat M4[`t',7]=m18[`t',1]
	mat M4[`t',8]=m18[`t',5]
	mat M4[`t',9]=m18[`t',6]
}

* AGE 27-50

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

mat m19=r(table)'
local rows=rowsof(m19)
forvalues t=1(1)`rows'{
mat M5[`t',1]=m19[`t',1]
	mat M5[`t',2]=m19[`t',5]
	mat M5[`t',3]=m19[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

mat m20=r(table)'
local rows=rowsof(m20)
forvalues t=1(1)`rows'{
mat M5[`t',4]=m20[`t',1]
	mat M5[`t',5]=m20[`t',5]
	mat M5[`t',6]=m20[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==2

mat m21=r(table)'
local rows=rowsof(m21)
forvalues t=1(1)`rows'{
mat M5[`t',7]=m21[`t',1]
	mat M5[`t',8]=m21[`t',5]
	mat M5[`t',9]=m21[`t',6]
}

* AGE 51-64

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

mat m22=r(table)'
local rows=rowsof(m22)
forvalues t=1(1)`rows'{
mat M6[`t',1]=m22[`t',1]
	mat M6[`t',2]=m22[`t',5]
	mat M6[`t',3]=m22[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

mat m23=r(table)'
local rows=rowsof(m23)
forvalues t=1(1)`rows'{
mat M6[`t',4]=m23[`t',1]
	mat M6[`t',5]=m23[`t',5]
	mat M6[`t',6]=m23[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if agecat==3

mat m24=r(table)'
local rows=rowsof(m24)
forvalues t=1(1)`rows'{
mat M6[`t',7]=m24[`t',1]
	mat M6[`t',8]=m24[`t',5]
	mat M6[`t',9]=m24[`t',6]
}

* NON-HISP WHITE

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

mat m25=r(table)'
local rows=rowsof(m25)
forvalues t=1(1)`rows'{
mat M7[`t',1]=m25[`t',1]
	mat M7[`t',2]=m25[`t',5]
	mat M7[`t',3]=m25[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

mat m26=r(table)'
local rows=rowsof(m26)
forvalues t=1(1)`rows'{
mat M7[`t',4]=m26[`t',1]
	mat M7[`t',5]=m26[`t',5]
	mat M7[`t',6]=m26[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_white==1

mat m27=r(table)'
local rows=rowsof(m27)
forvalues t=1(1)`rows'{
mat M7[`t',7]=m27[`t',1]
	mat M7[`t',8]=m27[`t',5]
	mat M7[`t',9]=m27[`t',6]
}

* NON-HISP BLACK

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

mat m28=r(table)'
local rows=rowsof(m28)
forvalues t=1(1)`rows'{
mat M8[`t',1]=m28[`t',1]
	mat M8[`t',2]=m28[`t',5]
	mat M8[`t',3]=m28[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

mat m29=r(table)'
local rows=rowsof(m29)
forvalues t=1(1)`rows'{
mat M8[`t',4]=m29[`t',1]
	mat M8[`t',5]=m29[`t',5]
	mat M8[`t',6]=m29[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_black==1

mat m30=r(table)'
local rows=rowsof(m30)
forvalues t=1(1)`rows'{
mat M8[`t',7]=m30[`t',1]
	mat M8[`t',8]=m30[`t',5]
	mat M8[`t',9]=m30[`t',6]
}

* NON-HISP ASIAN

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

mat m31=r(table)'
local rows=rowsof(m31)
forvalues t=1(1)`rows'{
mat M9[`t',1]=m31[`t',1]
	mat M9[`t',2]=m31[`t',5]
	mat M9[`t',3]=m31[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

mat m32=r(table)'
local rows=rowsof(m32)
forvalues t=1(1)`rows'{
mat M9[`t',4]=m32[`t',1]
	mat M9[`t',5]=m32[`t',5]
	mat M9[`t',6]=m32[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if raceth_asian==1

mat m33=r(table)'
local rows=rowsof(m33)
forvalues t=1(1)`rows'{
mat M9[`t',7]=m33[`t',1]
	mat M9[`t',8]=m33[`t',5]
	mat M9[`t',9]=m33[`t',6]
}

* HISPANIC

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

mat m34=r(table)'
local rows=rowsof(m34)
forvalues t=1(1)`rows'{
mat M10[`t',1]=m34[`t',1]
	mat M10[`t',2]=m34[`t',5]
	mat M10[`t',3]=m34[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

mat m35=r(table)'
local rows=rowsof(m35)
forvalues t=1(1)`rows'{
mat M10[`t',4]=m35[`t',1]
	mat M10[`t',5]=m35[`t',5]
	mat M10[`t',6]=m35[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if hispanic==1

mat m36=r(table)'
local rows=rowsof(m36)
forvalues t=1(1)`rows'{
mat M10[`t',7]=m36[`t',1]
	mat M10[`t',8]=m36[`t',5]
	mat M10[`t',9]=m36[`t',6]
}

* LOW INCOME

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

mat m37=r(table)'
local rows=rowsof(m37)
forvalues t=1(1)`rows'{
mat M11[`t',1]=m37[`t',1]
	mat M11[`t',2]=m37[`t',5]
	mat M11[`t',3]=m37[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

mat m38=r(table)'
local rows=rowsof(m38)
forvalues t=1(1)`rows'{
mat M11[`t',4]=m38[`t',1]
	mat M11[`t',5]=m38[`t',5]
	mat M11[`t',6]=m38[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_low==1

mat m39=r(table)'
local rows=rowsof(m39)
forvalues t=1(1)`rows'{
mat M11[`t',7]=m39[`t',1]
	mat M11[`t',8]=m39[`t',5]
	mat M11[`t',9]=m39[`t',6]
}

* MID INCOME

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

mat m40=r(table)'
local rows=rowsof(m40)
forvalues t=1(1)`rows'{
mat M12[`t',1]=m40[`t',1]
	mat M12[`t',2]=m40[`t',5]
	mat M12[`t',3]=m40[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

mat m41=r(table)'
local rows=rowsof(m41)
forvalues t=1(1)`rows'{
mat M12[`t',4]=m41[`t',1]
	mat M12[`t',5]=m41[`t',5]
	mat M12[`t',6]=m41[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_mid==1

mat m42=r(table)'
local rows=rowsof(m42)
forvalues t=1(1)`rows'{
mat M12[`t',7]=m42[`t',1]
	mat M12[`t',8]=m42[`t',5]
	mat M12[`t',9]=m42[`t',6]
}

* HIGH INCOME

svy: regress hlthins_anyins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

mat m43=r(table)'
local rows=rowsof(m43)
forvalues t=1(1)`rows'{
mat M13[`t',1]=m43[`t',1]
	mat M13[`t',2]=m43[`t',5]
	mat M13[`t',3]=m43[`t',6]
}

svy: regress hlthins_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

mat m44=r(table)'
local rows=rowsof(m44)
forvalues t=1(1)`rows'{
mat M13[`t',4]=m44[`t',1]
	mat M13[`t',5]=m44[`t',5]
	mat M13[`t',6]=m44[`t',6]
}

svy: regress hlthins_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if inc_high==1

mat m45=r(table)'
local rows=rowsof(m45)
forvalues t=1(1)`rows'{
mat M13[`t',7]=m45[`t',1]
	mat M13[`t',8]=m45[`t',5]
	mat M13[`t',9]=m45[`t',6]
}

mat U1 = J(64,1,1)
mat U2 = J(64,1,2)
mat U3 = J(64,1,3)
mat U4 = J(64,1,4)
mat U5 = J(64,1,5)
mat U6 = J(64,1,6)
mat U7 = J(64,1,7)
mat U8 = J(64,1,8)
mat U9 = J(64,1,9)
mat U10 = J(64,1,10)
mat U11 = J(64,1,11)
mat U12 = J(64,1,12)
mat U13 = J(64,1,13)

mat M101=U1,M1
mat M202=U2,M2
mat M303=U3,M3
mat M404=U4,M4
mat M505=U5,M5
mat M606=U6,M6
mat M707=U7,M7
mat M808=U8,M8
mat M909=U9,M9
mat M1010=U10,M10
mat M1111=U11,M11
mat M1212=U12,M12
mat M1313=U13,M13


mat M=M101\M202\M303\M404\M505\M606\M707\M808\M909\M1010\M1111\M1212\M1313

svmat M, n(coef)

rename (coef1-coef10) ///
(type  anyins_b anyins_lci anyins_uci ///
 esi_b esi_lci esi_uci ///
 nonesi_b nonesi_lci nonesi_uci )

label define typel 1 "All" 2 "Male" 3 "Female" 4 "Age 18-26" 5 "Age 27-50" 6 "Age 51-64" ///
	7 "White" 8 "Black" 9 "Asian" 10 "Hispanic" ///
	11 "Low Income" 12 "Middle Income" 13 "High Income"
label values type typel  

bysort type: gen counter=_n
gen barposition = cond(type==1, _n, _n+1)

replace type=type-.2
gen type2 = type+.20
gen type3 = type+.4
gen type4=type-.10
gen type5 = type+.125

gen esi_b2=esi_b
gen nonesi_b2=nonesi_b
gen anyins_b2=anyins_b

format esi_b2 %9.3f
format nonesi_b2 %9.3f
format anyins_b2 %9.3f
format esi_b %9.3f
format nonesi_b %9.3f
format anyins_b %9.3f

* set graph design
set scheme plotplain, permanently
  
* horizontal CI's  
twoway (scatter type anyins_b if counter==1, yscale(rev) msym(o) mcol(black*0.75)) || ///
     (rcap  anyins_lci anyins_uci type if counter==1, yscale(rev) horizontal lcol(black*0.75) lpattern(solid)) || ///
	(scatter type2 esi_b if counter==1, yscale(rev) msym(o) mcol(black*0.5)) || ///
	(rcap esi_lci esi_uci type2 if counter==1, yscale(rev) horizontal lcol(black*0.5) lpattern(solid)) ///
	(scatter type3 nonesi_b if counter==1, yscale(rev) msym(o) mcol(black*0.2)) || ///
		(rcap nonesi_lci nonesi_uci type3  if counter==1, yscale(rev) horizontal lcol(black*0.2) lpattern(solid)) ||, ///
  xline(0, lcolor(cranberry*0.5)) ///
  legend(off) ///
  ysize(7) xlabel(-0.010(0.005)0.010, nogrid) ///
  ylabel( 1 "All" 2 "Male" 3 "Female" 4 "Age 18-26" 5 "Age 27-50" 6 "Age 51-64" ///
	7 "White" 8 "Black" 9 "Asian" 10 "Hispanic" ///
	11 "Low Income" 12 "Middle Income" 13 "High Income", nogrid) name(figure3_phase23, replace) ///
  b1title("Weekly Percentage Point Change", size(2.5)) b2title("Fall/Winter")

****************
*** COMBINED ***
****************

grc1leg figure3_phase1 figure3_phase23, legendfrom(figure3_phase1) col(2) ysize(3)

* Save as PNG 
graph export "$results/figure3.png", as(png) name("Graph") width(4000) replace

* Save as EPS
graph export "$results/figure3.eps", as(eps) name("Graph") replace


