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

******************************************
*** CREATING BAR AND CI INTERVAL GRAPH ***
******************************************

mat M1=J(64,21, .)
mat M2=J(64,21, .)
mat M3=J(64,21, .)

* ALL
svy: regress hlthins_test_unins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m1=r(table)'
local rows=rowsof(m1)
forvalues t=1(1)`rows'{
mat M1[`t',1]=m1[`t',1]
	mat M1[`t',2]=m1[`t',5]
	mat M1[`t',3]=m1[`t',6]
}

svy: regress hlthins_test_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m2=r(table)'
local rows=rowsof(m2)
forvalues t=1(1)`rows'{
mat M1[`t',4]=m2[`t',1]
	mat M1[`t',5]=m2[`t',5]
	mat M1[`t',6]=m2[`t',6]
}

svy: regress hlthins_test_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m3=r(table)'
local rows=rowsof(m3)
forvalues t=1(1)`rows'{
mat M1[`t',7]=m3[`t',1]
	mat M1[`t',8]=m3[`t',5]
	mat M1[`t',9]=m3[`t',6]
}

svy: regress hlthins_test_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m4=r(table)'
local rows=rowsof(m4)
forvalues t=1(1)`rows'{
mat M1[`t',10]=m4[`t',1]
	mat M1[`t',11]=m4[`t',5]
	mat M1[`t',12]=m4[`t',6]
}

svy: regress hlthins_test_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m5=r(table)'
local rows=rowsof(m5)
forvalues t=1(1)`rows'{
mat M1[`t',13]=m5[`t',1]
	mat M1[`t',14]=m5[`t',5]
	mat M1[`t',15]=m5[`t',6]
}

svy: regress hlthins_test_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m6=r(table)'
local rows=rowsof(m6)
forvalues t=1(1)`rows'{
mat M1[`t',16]=m6[`t',1]
	mat M1[`t',17]=m6[`t',5]
	mat M1[`t',18]=m6[`t',6]
}

svy: regress hlthins_missing lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m19=r(table)'
local rows=rowsof(m19)
forvalues t=1(1)`rows'{
mat M1[`t',19]=m19[`t',1]
	mat M1[`t',20]=m19[`t',5]
	mat M1[`t',21]=m19[`t',6]
}

* NON-EXP
svy: regress hlthins_test_unins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m7=r(table)'
local rows=rowsof(m7)
forvalues t=1(1)`rows'{
mat M2[`t',1]=m7[`t',1]
	mat M2[`t',2]=m7[`t',5]
	mat M2[`t',3]=m7[`t',6]
}
svy: regress hlthins_test_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m8=r(table)'
local rows=rowsof(m8)
forvalues t=1(1)`rows'{
mat M2[`t',4]=m8[`t',1]
	mat M2[`t',5]=m8[`t',5]
	mat M2[`t',6]=m8[`t',6]
}

svy: regress hlthins_test_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m9=r(table)'
local rows=rowsof(m9)
forvalues t=1(1)`rows'{
mat M2[`t',7]=m9[`t',1]
	mat M2[`t',8]=m9[`t',5]
	mat M2[`t',9]=m9[`t',6]
}

svy: regress hlthins_test_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m10=r(table)'
local rows=rowsof(m10)
forvalues t=1(1)`rows'{
mat M2[`t',10]=m10[`t',1]
	mat M2[`t',11]=m10[`t',5]
	mat M2[`t',12]=m10[`t',6]
}

svy: regress hlthins_test_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m11=r(table)'
local rows=rowsof(m11)
forvalues t=1(1)`rows'{
mat M2[`t',13]=m11[`t',1]
	mat M2[`t',14]=m11[`t',5]
	mat M2[`t',15]=m11[`t',6]
}

svy: regress hlthins_test_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m12=r(table)'
local rows=rowsof(m12)
forvalues t=1(1)`rows'{
mat M2[`t',16]=m12[`t',1]
	mat M2[`t',17]=m12[`t',5]
	mat M2[`t',18]=m12[`t',6]
}

svy: regress hlthins_missing lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m20=r(table)'
local rows=rowsof(m20)
forvalues t=1(1)`rows'{
mat M2[`t',19]=m20[`t',1]
	mat M2[`t',20]=m20[`t',5]
	mat M2[`t',21]=m20[`t',6]
}

* EXP

svy: regress hlthins_test_unins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m13=r(table)'
local rows=rowsof(m13)
forvalues t=1(1)`rows'{
mat M3[`t',1]=m13[`t',1]
	mat M3[`t',2]=m13[`t',5]
	mat M3[`t',3]=m13[`t',6]
}

svy: regress hlthins_test_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m14=r(table)'
local rows=rowsof(m14)
forvalues t=1(1)`rows'{
mat M3[`t',4]=m14[`t',1]
	mat M3[`t',5]=m14[`t',5]
	mat M3[`t',6]=m14[`t',6]
}

svy: regress hlthins_test_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m15=r(table)'
local rows=rowsof(m15)
forvalues t=1(1)`rows'{
mat M3[`t',7]=m15[`t',1]
	mat M3[`t',8]=m15[`t',5]
	mat M3[`t',9]=m15[`t',6]
}

svy: regress hlthins_test_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m16=r(table)'
local rows=rowsof(m16)
forvalues t=1(1)`rows'{
mat M3[`t',10]=m16[`t',1]
	mat M3[`t',11]=m16[`t',5]
	mat M3[`t',12]=m16[`t',6]
}

svy: regress hlthins_test_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m17=r(table)'
local rows=rowsof(m17)
forvalues t=1(1)`rows'{
mat M3[`t',13]=m17[`t',1]
	mat M3[`t',14]=m17[`t',5]
	mat M3[`t',15]=m17[`t',6]
}

svy: regress hlthins_test_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m18=r(table)'
local rows=rowsof(m18)
forvalues t=1(1)`rows'{
mat M3[`t',16]=m18[`t',1]
	mat M3[`t',17]=m18[`t',5]
	mat M3[`t',18]=m18[`t',6]
}

svy: regress hlthins_missing lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m21=r(table)'
local rows=rowsof(m21)
forvalues t=1(1)`rows'{
mat M3[`t',19]=m21[`t',1]
	mat M3[`t',20]=m21[`t',5]
	mat M3[`t',21]=m21[`t',6]
}

mat U1 = J(64,1,1)
mat U2 = J(64,1,2)
mat U3 = J(64,1,3)

mat M101=U1,M1
mat M202=U2,M2
mat M303=U3,M3

mat M=M101\M202\M303

svmat M, n(coef)

rename (coef1-coef22) ///
(type  unins_b unins_lci unins_uci ///
 esi_b esi_lci esi_uci ///
 nonesi_b nonesi_lci nonesi_uci ///
 priv_b priv_lci priv_uci ///
 med_b med_lci med_uci ///
 pub_b pub_lci pub_uci ///
 miss_b miss_lci miss_uci)

label define typel 1 "All" 2 "Non-Expansion" 3 "Expansion"
label values type typel  

bysort type: gen counter=_n
gen barposition = cond(type==1, _n, _n+1)

replace type=type-.1
gen type2 = type+.10
gen type3 = type+.2
gen type4 = type+.3
gen type5 = type+.4
gen type6 = type+.5

gen esi_b2=esi_b
gen nonesi_b2=nonesi_b
gen unins_b2=unins_b
gen priv_b2=priv_b
gen med_b2=med_b
gen pub_b2=pub_b
gen miss_b2=miss_b

format esi_b2 %9.3f
format nonesi_b2 %9.3f
format unins_b2 %9.3f
format priv_b2 %9.3f
format med_b2 %9.3f
format pub_b2 %9.3f
format miss_b2 %9.3f

format esi_b %9.3f
format nonesi_b %9.3f
format unins_b %9.3f
format priv_b %9.3f
format med_b %9.3f
format pub_b %9.3f
format miss_b %9.3f

* set graph design
set scheme plotplain, permanently
  
* horizontal CI's  
twoway (scatter type unins_b if counter==1, yscale(rev) msym(o) mcol(black*0.75)) || ///
     (rcap  unins_lci unins_uci type if counter==1, yscale(rev) horizontal lcol(black*0.75) lpattern(solid)) || ///
	(scatter type2 esi_b if counter==1, yscale(rev) msym(o) mcol(black*0.5)) || ///
	(rcap esi_lci esi_uci type2 if counter==1, yscale(rev) horizontal lcol(black*0.5) lpattern(solid)) ///
	(scatter type3 priv_b if counter==1, yscale(rev) msym(o) mcol(ebblue)) || ///
     (rcap  priv_lci priv_uci type3 if counter==1, yscale(rev) horizontal lcol(ebblue) lpattern(solid)) || ///
	(scatter type4 med_b if counter==1, yscale(rev) msym(o) mcol(ebblue*0.7)) || ///
	(rcap med_lci med_uci type4 if counter==1, yscale(rev) horizontal lcol(ebblue*0.7) lpattern(solid)) ///
	(scatter type5 pub_b if counter==1, yscale(rev) msym(o) mcol(ebblue*0.4)) || ///
		(rcap pub_lci pub_uci type5  if counter==1, yscale(rev) horizontal lcol(ebblue*0.4) lpattern(solid)) || ///
	(scatter type6 miss_b if counter==1, yscale(rev) msym(o) mcol(ebblue*0.2)) || ///
	(rcap miss_lci miss_uci type6 if counter==1, yscale(rev) horizontal lcol(ebblue*0.2) lpattern(solid)) ||, ///
  xline(0, lcolor(cranberry*0.5)) xsize(6) ysize(5) ///
  xlabel(-0.010(0.005)0.010, nogrid) xlabel(, nogrid) ///
  legend(order(1 "Uninsured" 3 "Emp. Spons. Ins." 5 "Other Private Insurance" 7 "Medicaid" 9 "Other Types of Public Coverage" 11 "Missing HI") pos(6) cols(2) size(2.5)) ///
  ylabel( 1 "All" 2 "Non-Expansion" 3 "Expansion", nogrid) name(appfig4a_phase1, replace) ///
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

mat M1=J(64,21, .)
mat M2=J(64,21, .)
mat M3=J(64,21, .)

* ALL
svy: regress hlthins_test_unins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m1=r(table)'
local rows=rowsof(m1)
forvalues t=1(1)`rows'{
mat M1[`t',1]=m1[`t',1]
	mat M1[`t',2]=m1[`t',5]
	mat M1[`t',3]=m1[`t',6]
}

svy: regress hlthins_test_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m2=r(table)'
local rows=rowsof(m2)
forvalues t=1(1)`rows'{
mat M1[`t',4]=m2[`t',1]
	mat M1[`t',5]=m2[`t',5]
	mat M1[`t',6]=m2[`t',6]
}

svy: regress hlthins_test_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m3=r(table)'
local rows=rowsof(m3)
forvalues t=1(1)`rows'{
mat M1[`t',7]=m3[`t',1]
	mat M1[`t',8]=m3[`t',5]
	mat M1[`t',9]=m3[`t',6]
}

svy: regress hlthins_test_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m4=r(table)'
local rows=rowsof(m4)
forvalues t=1(1)`rows'{
mat M1[`t',10]=m4[`t',1]
	mat M1[`t',11]=m4[`t',5]
	mat M1[`t',12]=m4[`t',6]
}

svy: regress hlthins_test_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m5=r(table)'
local rows=rowsof(m5)
forvalues t=1(1)`rows'{
mat M1[`t',13]=m5[`t',1]
	mat M1[`t',14]=m5[`t',5]
	mat M1[`t',15]=m5[`t',6]
}

svy: regress hlthins_test_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m6=r(table)'
local rows=rowsof(m6)
forvalues t=1(1)`rows'{
mat M1[`t',16]=m6[`t',1]
	mat M1[`t',17]=m6[`t',5]
	mat M1[`t',18]=m6[`t',6]
}

svy: regress hlthins_missing lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st

mat m19=r(table)'
local rows=rowsof(m19)
forvalues t=1(1)`rows'{
mat M1[`t',19]=m19[`t',1]
	mat M1[`t',20]=m19[`t',5]
	mat M1[`t',21]=m19[`t',6]
}

* NON-EXP
svy: regress hlthins_test_unins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m7=r(table)'
local rows=rowsof(m7)
forvalues t=1(1)`rows'{
mat M2[`t',1]=m7[`t',1]
	mat M2[`t',2]=m7[`t',5]
	mat M2[`t',3]=m7[`t',6]
}
svy: regress hlthins_test_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m8=r(table)'
local rows=rowsof(m8)
forvalues t=1(1)`rows'{
mat M2[`t',4]=m8[`t',1]
	mat M2[`t',5]=m8[`t',5]
	mat M2[`t',6]=m8[`t',6]
}

svy: regress hlthins_test_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m9=r(table)'
local rows=rowsof(m9)
forvalues t=1(1)`rows'{
mat M2[`t',7]=m9[`t',1]
	mat M2[`t',8]=m9[`t',5]
	mat M2[`t',9]=m9[`t',6]
}

svy: regress hlthins_test_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m10=r(table)'
local rows=rowsof(m10)
forvalues t=1(1)`rows'{
mat M2[`t',10]=m10[`t',1]
	mat M2[`t',11]=m10[`t',5]
	mat M2[`t',12]=m10[`t',6]
}

svy: regress hlthins_test_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m11=r(table)'
local rows=rowsof(m11)
forvalues t=1(1)`rows'{
mat M2[`t',13]=m11[`t',1]
	mat M2[`t',14]=m11[`t',5]
	mat M2[`t',15]=m11[`t',6]
}

svy: regress hlthins_test_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m12=r(table)'
local rows=rowsof(m12)
forvalues t=1(1)`rows'{
mat M2[`t',16]=m12[`t',1]
	mat M2[`t',17]=m12[`t',5]
	mat M2[`t',18]=m12[`t',6]
}

svy: regress hlthins_missing lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==0

mat m20=r(table)'
local rows=rowsof(m20)
forvalues t=1(1)`rows'{
mat M2[`t',19]=m20[`t',1]
	mat M2[`t',20]=m20[`t',5]
	mat M2[`t',21]=m20[`t',6]
}

* EXP

svy: regress hlthins_test_unins lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m13=r(table)'
local rows=rowsof(m13)
forvalues t=1(1)`rows'{
mat M3[`t',1]=m13[`t',1]
	mat M3[`t',2]=m13[`t',5]
	mat M3[`t',3]=m13[`t',6]
}

svy: regress hlthins_test_esi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m14=r(table)'
local rows=rowsof(m14)
forvalues t=1(1)`rows'{
mat M3[`t',4]=m14[`t',1]
	mat M3[`t',5]=m14[`t',5]
	mat M3[`t',6]=m14[`t',6]
}

svy: regress hlthins_test_nonesi lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m15=r(table)'
local rows=rowsof(m15)
forvalues t=1(1)`rows'{
mat M3[`t',7]=m15[`t',1]
	mat M3[`t',8]=m15[`t',5]
	mat M3[`t',9]=m15[`t',6]
}

svy: regress hlthins_test_priv lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m16=r(table)'
local rows=rowsof(m16)
forvalues t=1(1)`rows'{
mat M3[`t',10]=m16[`t',1]
	mat M3[`t',11]=m16[`t',5]
	mat M3[`t',12]=m16[`t',6]
}

svy: regress hlthins_test_medicaid lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m17=r(table)'
local rows=rowsof(m17)
forvalues t=1(1)`rows'{
mat M3[`t',13]=m17[`t',1]
	mat M3[`t',14]=m17[`t',5]
	mat M3[`t',15]=m17[`t',6]
}

svy: regress hlthins_test_public lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m18=r(table)'
local rows=rowsof(m18)
forvalues t=1(1)`rows'{
mat M3[`t',16]=m18[`t',1]
	mat M3[`t',17]=m18[`t',5]
	mat M3[`t',18]=m18[`t',6]
}

svy: regress hlthins_missing lweek female age1826 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other edcoll edgrad hhsz anychild i.est_st if adopted==1

mat m21=r(table)'
local rows=rowsof(m21)
forvalues t=1(1)`rows'{
mat M3[`t',19]=m21[`t',1]
	mat M3[`t',20]=m21[`t',5]
	mat M3[`t',21]=m21[`t',6]
}

mat U1 = J(64,1,1)
mat U2 = J(64,1,2)
mat U3 = J(64,1,3)

mat M101=U1,M1
mat M202=U2,M2
mat M303=U3,M3

mat M=M101\M202\M303

svmat M, n(coef)

rename (coef1-coef22) ///
(type  unins_b unins_lci unins_uci ///
 esi_b esi_lci esi_uci ///
 nonesi_b nonesi_lci nonesi_uci ///
 priv_b priv_lci priv_uci ///
 med_b med_lci med_uci ///
 pub_b pub_lci pub_uci ///
 miss_b miss_lci miss_uci)

label define typel 1 "All" 2 "Non-Expansion" 3 "Expansion"
label values type typel  

bysort type: gen counter=_n
gen barposition = cond(type==1, _n, _n+1)

replace type=type-.1
gen type2 = type+.10
gen type3 = type+.2
gen type4 = type+.3
gen type5 = type+.4
gen type6 = type+.5

gen esi_b2=esi_b
gen nonesi_b2=nonesi_b
gen unins_b2=unins_b
gen priv_b2=priv_b
gen med_b2=med_b
gen pub_b2=pub_b
gen miss_b2=miss_b

format esi_b2 %9.3f
format nonesi_b2 %9.3f
format unins_b2 %9.3f
format priv_b2 %9.3f
format med_b2 %9.3f
format pub_b2 %9.3f
format miss_b2 %9.3f

format esi_b %9.3f
format nonesi_b %9.3f
format unins_b %9.3f
format priv_b %9.3f
format med_b %9.3f
format pub_b %9.3f
format miss_b %9.3f

* set graph design
set scheme plotplain, permanently

* horizontal CI's  
twoway (scatter type unins_b if counter==1, yscale(rev) msym(o) mcol(black*0.75)) || ///
     (rcap  unins_lci unins_uci type if counter==1, yscale(rev) horizontal lcol(black*0.75) lpattern(solid)) || /// 
	(scatter type2 esi_b if counter==1, yscale(rev) msym(o) mcol(black*0.5)) || ///
	(rcap esi_lci esi_uci type2 if counter==1, yscale(rev) horizontal lcol(black*0.5) lpattern(solid)) ///
	(scatter type3 priv_b if counter==1, yscale(rev) msym(o) mcol(ebblue)) || ///
     (rcap  priv_lci priv_uci type3 if counter==1, yscale(rev) horizontal lcol(ebblue) lpattern(solid)) || ///
	(scatter type4 med_b if counter==1, yscale(rev) msym(o) mcol(ebblue*0.7)) || ///
	(rcap med_lci med_uci type4 if counter==1, yscale(rev) horizontal lcol(ebblue*0.7) lpattern(solid)) ///
	(scatter type5 pub_b if counter==1, yscale(rev) msym(o) mcol(ebblue*0.4)) || ///
		(rcap pub_lci pub_uci type5  if counter==1, yscale(rev) horizontal lcol(ebblue*0.4) lpattern(solid)) || ///
	(scatter type6 miss_b if counter==1, yscale(rev) msym(o) mcol(ebblue*0.2)) || ///
	(rcap miss_lci miss_uci type6 if counter==1, yscale(rev) horizontal lcol(ebblue*0.2) lpattern(solid)) ||, ///
  xline(0, lcolor(cranberry*0.5)) xsize(6) ysize(5) ///
  xlabel(-0.010(0.005)0.010, nogrid) xlabel(, nogrid) ///
  legend(off) ///
  ylabel( 1 "All" 2 "Non-Expansion" 3 "Expansion", nogrid) name(appfig4a_phase23, replace) ///
  b1title("Weekly Percentage Point Change", size(2.5)) b2title("Fall/Winter")

****************
*** COMBINED ***
****************

grc1leg appfig4a_phase1 appfig4a_phase23, legendfrom(appfig4a_phase1) col(2) ysize(3) 

* Save as PNG 
graph export "$results/appfig4a.png", as(png) name("Graph") width(4000) replace

* Save as EPS
graph export "$results/appfig4a.eps", as(eps) name("Graph") replace
