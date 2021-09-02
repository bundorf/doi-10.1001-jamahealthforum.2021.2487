* This do file prepares replication weights for PULSE, phase 1 (w1-w21)
* Raw data files obtained from: https://www.census.gov/programs-surveys/household-pulse-survey/datasets.html

* Date of access for replication weights:
* survey week 1-2 (05/28/2020)
* week 3-4 (05/29/2020)
* week 5 (06/04/2020)
* week 6, week 11, week 13-14, week 18, week 21 (05/04/2021)
* week 7 (06/18/2020)
* week 8 (06/24/2020)
* week 9 (07/01/2020)
* week 10 (07/08/2020)
* week 12 (07/22/2020)
* week 15 (09/29/2020)
* week 16 (10/13/2020)
* week 17 (10/27/2020)
* week 19 (11/24/2020)
* week 20 (12/08/2020)
***************************************************************************************************************************

clear
set more off

************************************
*** import csv files, clean append
************************************

foreach w in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21{
	import delimited "$rdata/replication_weights/pulse2020_repwgt_puf_`w'.csv", clear
    save "$rdata/replication_weights/pulse2020_puf_repwgt_`w'.dta", replace
}

cd "$rdata/replication_weights/"
append using pulse2020_puf_repwgt_01 pulse2020_puf_repwgt_02 pulse2020_puf_repwgt_03 pulse2020_puf_repwgt_04 pulse2020_puf_repwgt_05 pulse2020_puf_repwgt_06 pulse2020_puf_repwgt_07 pulse2020_puf_repwgt_08 pulse2020_puf_repwgt_09 pulse2020_puf_repwgt_10 pulse2020_puf_repwgt_11 pulse2020_puf_repwgt_12 pulse2020_puf_repwgt_13 pulse2020_puf_repwgt_14 pulse2020_puf_repwgt_15 pulse2020_puf_repwgt_16 pulse2020_puf_repwgt_17 pulse2020_puf_repwgt_18 pulse2020_puf_repwgt_19 pulse2020_puf_repwgt_20 pulse2020_puf_repwgt_21
drop hweight*
duplicates drop
sort scram week
save "$cdata/pulse_2020_replicationweights.dta", replace
