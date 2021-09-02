* This do file creates the table comparing HI coverage in ACS2018, 2019, NHIS 2018  and PULSE 
***************************************************************************************************************************

clear
set more off


*********************
*** APPENDIX Table 1
*********************
use "$cdata/nhis_acs2019_2018pulse_fullappended.dta", clear
drop if data=="NHIS2019"

encode data, gen(datadum)

* set survey data
svyset scram [pw=pweight]
putexcel set "$results/AppendixTable1.xlsx", replace
local cell1 "B"
local cell2 "C"
local cell3 "D"
local cell4 "E"
local cell5 "F"
local cell6 "G"
local cell7 "H"
local cell8 "I"
local cell9 "J"
local cell10 "K"
local cell11 "L"


putexcel A2 = "Female"
putexcel A4 = "Age 18-26"
putexcel A6 = "Age 27-40"
putexcel A8 = "Age 41-50"
putexcel A10 = "Age 51-64"
putexcel A12 = "Non-Hispanic White"
putexcel A14 = "Non-Hispanic Black"
putexcel A16 = "Non-Hispanic Asian"
putexcel A18 = "Non-Hispanic Other"
putexcel A20 = "Hispanic"
putexcel A22 = "High School Diploma"
putexcel A24 = "College Degree"
putexcel A26 = "Graduate Degree"
putexcel A28 = "Low income"
putexcel A30 = "Middle income"
putexcel A32 = "High income"
putexcel A34 = "Household Size"
putexcel A36 = "Children in household"
putexcel A38 = "Missing Income"
putexcel A40 = "Missing Health Ins."
putexcel A42 = "N"


putexcel B1 = "ACS 2018"
putexcel C1 = "ACS 2019"
putexcel D1 = "NHIS 2018"
putexcel E1 = "Pulse Spring/Summer"
putexcel F1 = "Pulse Spring/Summer, excl. missing HI"
putexcel G1 = "Pulse Spring/Summer, with rep. weights"
putexcel H1 = "Pulse Spring/Summer, excl. missing HI, with rep. weights"
putexcel I1 = "Pulse Fall/Winter"
putexcel J1 = "Pulse Fall/Winter, excl. missing HI"
putexcel K1 = "Pulse Fall/Winter, with rep. weights"
putexcel L1 = "Pulse Fall/Winter, excl. missing HI, with rep. weights"


svyset scram [pw=pweight]

foreach s in 1 2 3 4 5 8 9{
local row = 1    
    foreach v in female age1826 age2740 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other hispanic edhs edcoll edgrad income1 income2 income3 hhsz anychild{
mean `v' [pw=pweight] if sample`s'==1
matrix tab`v'`s'=r(table)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[1,1]), nformat(0.0000)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[2,1]), nformat((0.0000))
putexcel `cell`s''42=`e(N)'
}
}

local cell1 "B"
local cell2 "C"
local cell3 "D"
local cell4 "E"
local cell5 "F"
local cell6 "G"
local cell7 "H"
local cell8 "I"
local cell9 "J"
local cell10 "K"

svyset scram [pw=pweight]
foreach s in 4 5 8 9{
local row = 37    
    foreach v in income_missing hlthins_missing{
mean `v' [pw=pweight] if sample`s'==1
matrix tab`v'`s'=r(table)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[1,1]), nformat(0.0000)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[2,1]), nformat((0.0000))
}
}


* with replication weights
svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse
foreach s in 6 7 10 11{
local r=`s'-2	
local row = 1    
    foreach v in female age1826 age2740 age4150 age5164 raceth_white raceth_black raceth_asian raceth_other hispanic edhs edcoll edgrad income1 income2 income3 hhsz anychild{
svy, subpop(sample`r'):  mean `v' 
matrix tab`v'`s'=r(table)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[1,1]), nformat(0.0000)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[2,1]), nformat((0.0000))
putexcel `cell`s''42=`e(N)'
}
}

svyset[pw=pweight], vce(brr) brrweight(pweight1-pweight80) fay(.5)mse
foreach s in 6 7 10 11{
local r=`s'-2
local row = 37    
    foreach v in income_missing hlthins_missing{
svy, subpop(sample`r'):  mean `v' 
matrix tab`v'`s'=r(table)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[1,1]), nformat(0.0000)
local ++row
putexcel `cell`s''`row'=matrix(tab`v'`s'[2,1]), nformat((0.0000))
}
}
