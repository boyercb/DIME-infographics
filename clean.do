*! version 1.0 Christopher Boyer 01aug2016

/* this file cleanse raw indicator csv-files 
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
local id4 `""groupe_district_sanitairecommune""'
local id5 `""commune""'

local ids `"`id1' `id2' `id3' `id4' `id5'"'
di `ids'

* loop through raw data and extract duplicates
foreach file of local filenames {

	* read csv file with raw indicator data
	import delimited using "data/`file' 2014_WIDE.csv", ///
		clear bindquotes(strict)
		
	* sort data set 
	gettoken id ids : ids
	sort `id'
	
	* tag duplicates
	duplicates tag `id', g(dups)
	
	* drop non duplicates
	drop if dups == 0
	
	* export list to excel
	export excel using "data/duplicates.xlsx", ///
	    sheet("`file'") sheetreplace firstrow(var) 
}

import excel using "data/duplicates.xlsx", describe
forval i = 1\`r(N_worksheet)' {
	local sheets `"`sheets' `r(worksheet_`i')'"'
}

* loop through excel file and import duplicates to be kept
foreach sheet of local sheets {

	* import the sheet
	import excel using "data/duplicates.xlsx", 
	    sheet(`sheet') firstrow clear
		
	* save stata data set
	save `sheet', replace
		
}

* loop through files again and exclude duplicates on drop list
foreach file of local filenames {

	* read csv file with raw indicator data
	import delimited using "data/`file' 2014_WIDE.csv", ///
		clear bindquotes(strict)
		
	* merge the duplicate drop list
	merge 1:1 `id', keep(keep) nogen
	
	* drop duplicates
	drop if keep == 0
   
}
