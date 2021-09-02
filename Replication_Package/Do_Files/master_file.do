* ==============================================================================
* MASTER FILE
* ==============================================================================
* Updated: August 2021

*************************************
*************** INPUT ***************
*************************************

clear all
set more off

* Root folder globals
global user "username"   /* updated username */
global root "/Users//$user/Dropbox/COVID Project/Insurance Coverage/Replication_Package" 	/* change to user's path */
global root "/Users//$user/Documents/doi-10.1001-jamahealthforum.2021.2487/Replication_Package" 	/* change to user's path */

* Input and analysis folder globals
global rdata "${root}/Data/rawdata"						/* raw data and can path to csv or dta */
global prep "${root}/Do_Files/Data_Preparation"			/* do files for building data */
global cdata "${root}/Data/cleandata"					/* dta files from building data */
global analysis "${root}/Do_Files/Analysis"				/* do files for analyzing data */
global results "${root}/Exhibits"		        		/* logs, excel sheets, graphs from analyzing data */


*****************************************
******* DATA CLEANING CODE FILES ********
*****************************************

do "$prep/hps_convert_to_dta.do"			/* converts csv files to dta */		
do "$prep/hps_merge.do"						/* merges converted dta files to generate hps_w1-21.dta */		
do "$prep/hps_variables.do"					/* adds variables to generate hps_w1-21v.dta */

do "$prep/pulse_replicationweights.do" 		/* prepares replicaton weights for PULSE */
do "$prep/NHIS_ACS2018_2019_Pulse.do" 		/* cleans data for Appendix Figure 1-3, Appendix Table 1*/


*****************************************
******* DATA ANALYSIS CODE FILES ********
*****************************************

**************************
*** Manuscript Figures ***
**************************

*** Figure 1						/* generates data for Figure 1 */
do "$analysis/figure1.do"

*** Figure 2						/* generates Figure 2 */
do "$analysis/figure2.do"

*** Figure 3						/* generates Figure 3 */
do "$analysis/figure3.do"

*********************************
*** Appendix Figures & Tables ***
*********************************

*** Appendix Table 1
do "$analysis/apptab1.do" 					/*generates Appendix Table 1 */

*** Appendix Figure 1 and 2
do "$analysis/appfig1and2.do" 				/*generates Appendix Figure 1-2 */

*** Appendix Figure 3
do "$analysis/appfig3.do" 					/*generates Appendix Figure 3 */

*** Appendix Table 2					
do "$analysis/apptab2.do" 					/* generates Appendix Table 2 */

*** Appendix Table 3					
do "$analysis/apptab3.do" 					/* generates Appendix Table 3 */

*** Appendix Figure 4a						
do "$analysis/appfig4a.do" 					/* generates Appendix Figure 4a */

*** Appendix Figure 4b						
do "$analysis/appfig4b.do" 					/* generates Appendix Figure 4b */

*** Appendix Table 4a					
do "$analysis/apptab4a.do"					/* generates Appendix Table 4a */

*** Appendix Table 4b					
do "$analysis/apptab4b.do"					/* generates Appendix Table 4b */

*** Age summary table
do "$analysis/summary_age.do"				/* generates age summary table */




