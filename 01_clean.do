*! version 1.0 Christopher Boyer 01aug2016

/* this file cleans raw indicator csv-files 
   for two infographic posters summarizing the 
   performance of 140 municipal governments in 
   Burkina Faso. */
   
version 13
set more off

/* =================================================== 
   =================== duplicates ==================== 
   =================================================== */

* raw data files
local f1 `""CEB""'
local f2 `""Directeur Ecole""'
local f3 `""Directeur Formation Sanitaire""'
local f4 `""District Sanitaire""'
local f5 `""Municipalite""'

local filenames `"`f1' `f2' `f3' `f4' `f5'"'

* unique id list
local id1 `""commune""'
local id2 `""commune school school_autre""'
local id3 `""commune formation_sanitaire formation_sanitaire_autre""'
local id4 `""commune1""'
local id5 `""commune""'

local ids `"`id1' `id2' `id3' `id4' `id5'"'

* loop through raw data and extract duplicates
foreach file of local filenames {

	* read csv file with raw indicator data
	import delimited using "${raw}/`file' ${year}_WIDE.csv", ///
		clear bindquotes(strict)
		
	* sort data set 
	gettoken id ids : ids
	sort `id' submissiondate
	
	* tag duplicates
	duplicates tag `id', g(dups)
	
	* create unique identifier
	g id = _n
	
	* drop non duplicates
	drop if dups == 0
		
	* export list to excel
	export excel using "${etc}/duplicates.xlsx", ///
	    sheet("`file'") sheetreplace firstrow(var) 
}

import excel using "${etc}/replacements.xlsx", describe
forval i = 1/`r(N_worksheet)' {
	local sheet `"`r(worksheet_`i')'"'

	* import the sheet
	import excel using "${etc}/replacements.xlsx", ///
	    sheet(`sheet') firstrow clear
		
	* save stata data set
	save "${dta}/`sheet'_rep.dta", replace
}

local ids `"`id1' `id2' `id3' `id4' `id5'"'

* loop through files again and exclude duplicates on drop list
foreach file of local filenames {

	* read csv file with raw indicator data
	import delimited using "${raw}/`file' ${year}_WIDE.csv", ///
		clear bindquotes(strict)
		
	* sort data set 
	gettoken id ids : ids
	sort `id' submissiondate
	
	* create unique identifier
	g id = _n
	
	* merge the duplicate drop list
	merge 1:1 id using "${dta}/`file'_rep.dta", keepusing(keep) nogen
	
	* drop duplicates
	drop if keep == 0
	drop keep
	
	* save stata data set
	save "${dta}/`file'.dta", replace
}

* add the potable water data set (already in Stata format)
local f6 `""Access Potable Water""'
local filenames `"`filenames' `f6'"'

* loop through files again and standardize for merging
foreach file of local filenames {

	* load data set
	use "${dta}/`file'.dta", clear
	
	* standardize naming of commune variable for merging
	cap confirm variable commune1
	if !_rc {
		g commune = commune1
	}
	
	* fix inconsistencies in the way communes are named across data sets
	replace commune = subinstr(commune, "-", "_", .)
	replace commune = "WOLONKOTO" if commune == "WOLOKONTO"
	replace commune = "ARBINDA" if commune == "ARIBINDA"
	replace commune = "NIAOGO" if commune == "NIAOGHO"
	replace commune = "BAGRE" if commune == "BAGRE (TENKODOGO)"
	replace commune = "SANGA" if commune == "SANGHA"
	replace commune = "BOUSSOUMA GARANGO" if commune == "BOUSSOUMA_GARANGO" 
	replace commune = "BOUSSOUMA KAYA" if commune == "BOUSSOUMA_KAYA"
	replace commune = "ZIMTANGA" if commune == "ZIMTENGA"
	
	if "`file'" == "CEB" & ${year} == 2015 {
		ren students_admitted_exam sd_a_01students_admitted_exam 
	    ren total_students_sitting_exam sd_a_01total_students_sitting_ex
	} 
	
	* save stata data set
	save "${dta}/`file'.dta", replace
}


/* =================================================== 
   ==================== collapse ===================== 
   =================================================== */

   /* this section aggregates the school and gas stock
      data to the commune level */
	  
* 1. schooling data
use "${dta}/Directeur Ecole.dta", clear

* calculate indicators to be aggregated
if ${year} == 2014 {
	g functional_latrines = (sd_a_02functional_latrines / number_classes) >= 1
	g functional_water = sd_a_01water_source_functional >= 9
	g supplies_received = date(sd_a_03year_month_received_schoo, "MDY", 2100) - ///
		date("10/01/${year}", "MDY") + 7 * (sd_a_03week_received_school_supp - 1)
}
else {
	replace functional_latrines = (functional_latrines / number_classes) >= 1
	g functional_water = water_source_functional >= 9
	g supplies_received = date(year_month_received_schoo, "DMY", 2100) - ///
		date("10/01/${year}", "MDY") + 7 * (week_received_school_supp - 1)

}

replace supplies_received = 0 if supplies_received < 0
replace supplies_received = 364 if mi(supplies_received) | supplies_received >= 365 | supplies_received <= -200

* aggregate schooling data by commune
collapse (mean) functional_latrines functional_water supplies_received, by(commune)

save "${dta}/Directeur Ecole.dta", replace


* 2. gas stock data
use "${dta}/Directeur Formation Sanitaire.dta", clear

* aggregate gas stock data by commune
if ${year} == 2015 {
	g sd_a_01stock_gas = stock_gas
}
collapse (mean) sd_a_01stock_gas , by(commune)

save "${dta}/Directeur Formation Sanitaire.dta", replace


/* =================================================== 
   ====================== merge ====================== 
   =================================================== */

gettoken file filenames : filenames
use "${dta}/`file'.dta", clear

foreach file of local filenames {

	merge 1:1 commune using "${dta}/`file'.dta", nogen

	save "${dta}/merged.dta", replace
	
}
