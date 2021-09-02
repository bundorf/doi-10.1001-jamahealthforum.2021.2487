This repository contains code and data to replicate the exhibits in "Trends in US Health Insurance Coverage During the COVID-19 Pandemic" by M. Kate Bundorf, Sumedha Gupta, and Christine Kim.

The Do_Files folder contains code that both processes raw data and analyzes the data to produce figures for the paper. The folder contains a Data_Preparation and Analysis subfolder that cleans and analyzes the data, respectively.

The Data folder contains a cleandata and rawdata subfolder. The cleandata subfolder is empty and the code that processes raw data will deposit intermediate data into this folder. The rawdata subfolder contains additional subfolders that are separated by the data source. These subfolders must be populated with the publicly available raw data from the Census, FRED, ACS, and NHIS. The pulse subfolder is divided into csv and dta for the Census raw data and intermediate data, respectively. The csv subfolder contains the files dates_2020.csv and hps_weekdates.csv which were manually created to be used by the Analysis .do files. The dates_2020.csv file contains all dates in year 2020 with a month and year column. The hps_weekdates.csv file contains the survey weeks from week 1 to week 21 with their respective start and end survey dates.

These are the raw data that must be deposited.
------------------------------------------------------

-- Census Household Pulse Survey Public Use Files
	Files downloaded from:
	https://www.census.gov/programs-surveys/household-pulse-survey/datasets.html
	Location to be deposited: Data/rawdata/pulse/csv
	File(s):
		-- pulse2020_puf_01.csv
		-- pulse2020_puf_02.csv		-- pulse2020_puf_03.csv		-- pulse2020_puf_04.csv		-- pulse2020_puf_05.csv		-- pulse2020_puf_06.csv		-- pulse2020_puf_07.csv		-- pulse2020_puf_08.csv		-- pulse2020_puf_09.csv		-- pulse2020_puf_10.csv		-- pulse2020_puf_11.csv		-- pulse2020_puf_12.csv		-- pulse2020_puf_13.csv		-- pulse2020_puf_14.csv		-- pulse2020_puf_15.csv		-- pulse2020_puf_16.csv		-- pulse2020_puf_17.csv		-- pulse2020_puf_18.csv		-- pulse2020_puf_19.csv		-- pulse2020_puf_20.csv		-- pulse2020_puf_21.csv

-- Unemployment Rate, Not Seasonally Adjusted, from January 2020-January 2021
	Files downloaded from:
	https://fred.stlouisfed.org/series/UNRATENSA
	Location to be deposited: Data/rawdata/pulse/csv
	File(s):
		-- UNRATENSA.csv

-- Replication Weights
	Files downloaded from:
	https://www.census.gov/programs-surveys/household-pulse-survey/datasets.html
	Location to be deposited: Data/rawdata/replication_weights
	File(s):
		-- pulse2020_repwgt_puf_01.csv		-- pulse2020_repwgt_puf_02.csv		-- pulse2020_repwgt_puf_03.csv		-- pulse2020_repwgt_puf_04.csv		-- pulse2020_repwgt_puf_05.csv		-- pulse2020_repwgt_puf_06.csv		-- pulse2020_repwgt_puf_07.csv		-- pulse2020_repwgt_puf_08.csv		-- pulse2020_repwgt_puf_09.csv		-- pulse2020_repwgt_puf_10.csv		-- pulse2020_repwgt_puf_11.csv		-- pulse2020_repwgt_puf_12.csv		-- pulse2020_repwgt_puf_13.csv		-- pulse2020_repwgt_puf_14.csv		-- pulse2020_repwgt_puf_15.csv		-- pulse2020_repwgt_puf_16.csv		-- pulse2020_repwgt_puf_17.csv		-- pulse2020_repwgt_puf_18.csv		-- pulse2020_repwgt_puf_19.csv		-- pulse2020_repwgt_puf_20.csv		-- pulse2020_repwgt_puf_21.csv

-- ACS 2018-2019
	Files downloaded from:
	https://usa.ipums.org/usa/acs.shtml
	Location to be deposited: Data/rawdata/IPUMS_ACS
	File(s):
		-- usa_00006.dta

-- NHIS
	Files downloaded from:
	https://nhis.ipums.org/nhis/
	Location to be deposited: Data/rawdata/IPUMS_NHIS
	File(s):
		-- nhis_00002.dta

The Exhibits folder is empty and the code that analyzes the data will deposit figures into this folder.

The Do_Files folder contain the following Stata .do files:

   -- master_file.do
	-- this code organizes directory paths and the .do files used for the manuscript and supplemental content. The .do files are listed in the order of execution.

---------------------------------------------------------------
-- Code that processes raw data (Data_Preparation subfolder) --
---------------------------------------------------------------
** Note: Please run these files in the order that they appear. You must first download raw data.

   -- hps_convert_to_dta.do
        -- this code takes in raw data from the Census and FRED. It converts the Household Pulse Survey public use files from week 1 (April 23 – May 5) to week 21 (December 9 – December 21) and unemployment data to .dta files. These files are saved to the Data/rawdata/pulse/dta folder.

   -- hps_merge.do
        -- this code appends the converted Household Pulse Survey .dta files and saves the appended data to the Data/cleandata folder.

   -- hps_variables.do
        -- this code generates variables that are used in the Analysis code. The edited data file is saved to the Data/cleandata folder.

   -- pulse_replicationweights.do
        -- this code prepares replication weights for PULSE using raw survey weights from the Census.

   -- NHIS_ACS2018_2019_Pulse.do
        -- this code cleans ACS2018-2019 raw data and NHIS 2018 raw data to compare health insurance coverage with PULSE.

--------------------------------------------------------
-- Code that analyzes clean data (Analysis subfolder) --
--------------------------------------------------------
** Note: These files must be run after the code that processes the raw data completes. They can be run in any order. Output generated by these files are deposited to the Exhibits folder.

   -- figure1.do
        -- This file exports an excel spreadsheet of the data from Figure 1 in the manuscript.

   -- figure2.do
        -- This file generates Figure 2 in the manuscript.

   -- figure3.do
        -- This file generates Figure 3 in the manuscript.

   -- apptab1.do
        -- This file generates Appendix Table 1 in the supplemental content.

   -- appfig1and2.do
        -- This file generates Appendix Figures 1 and 2 in the supplemental content.

   -- appfig3.do
        -- This file generates Appendix Figure 3 in the supplemental content.

   -- apptab2.do
        -- This file generates Appendix Table 2 in the supplemental content.

   -- apptab3.do
        -- This file generates Appendix Table 3 in the supplemental content.

   -- appfig4a.do
        -- This file generates Appendix Figure 4a in the supplemental content.

   -- appfig4b.do
        -- This file generates Appendix Figure 4b in the supplemental content.

   -- apptab4a.do
        -- This file generates Appendix Table 4a in the supplemental content.

   -- apptab4b.do
        -- This file generates Appendix Table 4b in the supplemental content.

   -- summary_age.do
        -- This file exports the mean and standard deviation of age for the entire study population to an excel spreadsheet.

