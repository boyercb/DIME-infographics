*! version 1.5 Christopher Boyer 28dec2016

/* this is the master file for the creation of infographic 
   posters for the WB's DIME team. The program cleans the 
   raw data from several surveys; calculates indicator 
   scores, values, and totals; and updates the graphics 
   of two infographic posters summarizing the performance 
   of 140 municipal governments in Burkina Faso. */
   
version 13
set more off
	
 
/* =================================================== 
   ================== set globals ==================== 
   =================================================== */
  
global year = 2014
global national_average = 65.2

/* Note:
    (+) 2014 national average = 65.2 
    (+) 2015 national average = 82.2  */

* define subfolders
global raw  "data/raw/${year}"
global dta  "data/dta/${year}"
global json "data/json/${year}"
global etc  "data/etc/${year}"

* create subfolders if they don't already exist
foreach dir in $dta $json $etc {
	cap confirm file "`dir'/nul" 
	if _rc {
		mkdir "`dir'"
	}
}


/* =================================================== 
   ================== run do-files =================== 
   =================================================== */

do "01_clean.do"
do "02_calculate_scores.do"
do "03_create_JSON.do"
