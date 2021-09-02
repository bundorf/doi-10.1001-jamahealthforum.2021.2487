* ==============================================================================
* MERGE DTA FILES
* ==============================================================================

clear
set more off

* set working directory

cd "${rdata}/pulse/dta/"

* merge data files (PHASE 1-3, for JAMA submission)

use pulse2020_puf_01.dta, clear

append using pulse2020_puf_02.dta pulse2020_puf_03.dta pulse2020_puf_04.dta ///
pulse2020_puf_05.dta pulse2020_puf_06.dta pulse2020_puf_07.dta ///
pulse2020_puf_08.dta pulse2020_puf_09.dta pulse2020_puf_10.dta ///
pulse2020_puf_11.dta pulse2020_puf_12.dta pulse2020_puf_13.dta pulse2020_puf_14.dta ///
pulse2020_puf_15.dta pulse2020_puf_16.dta pulse2020_puf_17.dta pulse2020_puf_18.dta ///
pulse2020_puf_19.dta pulse2020_puf_20.dta pulse2020_puf_21.dta ///

* save

save "${cdata}/hps_w1-21.dta", replace
