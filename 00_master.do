*! version 1.0 Christopher Boyer 04aug2016

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
   
global raw  "data/raw"
global dta  "data/dta"
global json "data/json"


/* =================================================== 
   ================== run do-files =================== 
   =================================================== */

do "01_clean.do"
do "02_calculate_scores.do"
do "03_create_JSON.do"


/* =================================================== 
   ================= process images ================== 
   =================================================== */
   
   
