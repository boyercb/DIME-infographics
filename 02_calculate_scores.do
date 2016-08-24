*! version 1.1 Christopher Boyer 01aug2016
*! version 1.0 Christopher Boyer 04jul2016

/* this file calculates indicator scores, values, 
   and totals for two infographic posters summarizing 
   the performance of 140 municipal governments in 
   Burkina Faso. */
   
version 13
set more off
 
/* =================================================== 
   ==================== Poster 1 ===================== 
   =================================================== */
   
* read csv file with raw indicator data
use "${dta}/merged.dta", clear

/* 1. indicator values - the number at the bottom of
   the sliding scale in the infographic */

g value_meetings1 = total_num_ordinary_scm

g value_meetings2 = num_cadre_concertation_meeting20

g avg = (councilor_attendance_meeting1 +  ///
         councilor_attendance_meeting2 +  ///
	     councilor_attendance_meeting3 +  /// 
	     councilor_attendance_meeting4) / ///
	     total_num_ordinary_scm
		 
g value_attendance = (avg * 100) / total_councilor

g value_taxes_raised = local_taxes_2012 / commune_population_number

g value_taxes_forecast = 100 * local_taxes_2012 / local_taxes_forecast_2012

g value_procurement = execution_equipment_procurement_

forval i = 1/8 {
	g value_personnel`i' = "false"
}
replace value_personnel1 = "true" if agent_materiel_transfere == 1
replace value_personnel2 = "true" if agent_secretaire == 1
replace value_personnel3 = "true" if agent_etat_civil == 1
replace value_personnel4 = "true" if agent_services_statistiques == 1
replace value_personnel5 = "true" if agent_service_techniques == 1
replace value_personnel6 = "true" if comptable == 1
replace value_personnel7 = "true" if regisseur_recettes == 1
replace value_personnel8 = "true" if agent_affaires_domaniales == 1

/* 2. indicator scores - the number at the top of the
   sliding scale in the infographic */
   
* number of personnel fulfilling the organigramme type
g score_personnel = 0
replace score_personnel = score_personnel + 1 if agent_secretaire == 1
replace score_personnel = score_personnel + 2 if agent_etat_civil == 1
replace score_personnel = score_personnel + 2 if comptable == 1
replace score_personnel = score_personnel + 1 if regisseur_recettes == 1
replace score_personnel = score_personnel + 1 if agent_materiel_transfere == 1
replace score_personnel = score_personnel + 1 if agent_services_statistiqu == 1
replace score_personnel = score_personnel + 1 if agent_service_techniques == 1
replace score_personnel = score_personnel + 1 if agent_affaires_domaniales == 1

* number of meetings held (1 - 4)
g score_meetings1 = 0
replace score_meetings1 = 0 if value_meetings1 == 0
replace score_meetings1 = 1 if value_meetings1 == 1
replace score_meetings1 = 3 if value_meetings1 == 2
replace score_meetings1 = 4 if value_meetings1 == 3
replace score_meetings1 = 5 if value_meetings1 == 4

* number of meetings held (0-4): How many of these meetings were held: ic_a_05-CdC_meetings_2013
g score_meetings2 = value_meetings2 * 2

* average attendance for the meetings held in 2013
g score_attendance = 0
replace score_attendance = 1 -((60 - value_attendance) / 20) if value_attendance >= 20 & value_attendance < 40
replace score_attendance = 5 + ((80 - value_attendance) / 10) if value_attendance >= 40 & value_attendance < 80
replace score_attendance = 7 + ((90 - value_attendance) / 5) if value_attendance >= 80 & value_attendance < 90
replace score_attendance = 10 + ((100 - value_attendance) * 3 / 10) if value_attendance >= 90 & value_attendance < 100
replace score_attendance = 10 if value_attendance >= 100 & value_attendance < .

* local taxes raised in 2013
egen score_taxes_raised = cut(value_taxes_raised), ///
    at(100,  ///
	   200,  ///
	   400,  ///
	   600,  ///
	   1000, ///
	   1200, ///
	   1400, ///
	   1800, ///
	   2000, ///
	   2200, ///
	   2400, ///
	   2800, ///
	   3000, ///
	   3500, ///
	   4000, ///
	   4500, ///
	   5000, ///
	   5500, ///
	   6000, ///
	   6500, ///
	   7000, ///
	   7500)

* local taxes raised in 2013 / forecast for 2013
g score_taxes_forecast = 0
replace score_taxes_forecast = 1 if value_taxes_forecast >= 60 & value_taxes_forecast < .
replace score_taxes_forecast = 2 if value_taxes_forecast >= 65 & value_taxes_forecast < .
replace score_taxes_forecast = 3 if value_taxes_forecast >= 70 & value_taxes_forecast < .
replace score_taxes_forecast = 4 if value_taxes_forecast >= 75 & value_taxes_forecast < .
replace score_taxes_forecast = 5 if value_taxes_forecast >= 80 & value_taxes_forecast < .
replace score_taxes_forecast = 6 if value_taxes_forecast >= 85 & value_taxes_forecast < .
replace score_taxes_forecast = 7 if value_taxes_forecast >= 90 & value_taxes_forecast < .
replace score_taxes_forecast = 9 if value_taxes_forecast >= 95 & value_taxes_forecast < .
replace score_taxes_forecast = 10 if value_taxes_forecast >= 100 & value_taxes_forecast < .

* percent completion of procurment plan
g score_procurement = 0
replace score_procurement = 1 if value_procurement >= 20 & value_procurement < .
replace score_procurement = 2 if value_procurement >= 30 & value_procurement < .
replace score_procurement = 3 if value_procurement >= 35 & value_procurement < .
replace score_procurement = 4 if value_procurement >= 40 & value_procurement < .
replace score_procurement = 5 if value_procurement >= 50 & value_procurement < .
replace score_procurement = 6 if value_procurement >= 55 & value_procurement < .
replace score_procurement = 7 if value_procurement >= 60 & value_procurement < .
replace score_procurement = 8 if value_procurement >= 65 & value_procurement < .
replace score_procurement = 9 if value_procurement >= 70 & value_procurement < .
replace score_procurement = 10 if value_procurement >= 75 & value_procurement < .
replace score_procurement = 11 if value_procurement >= 80 & value_procurement < .
replace score_procurement = 12 if value_procurement >= 85 & value_procurement < .
replace score_procurement = 14 if value_procurement >= 90 & value_procurement < .
replace score_procurement = 16 if value_procurement >= 95 & value_procurement < .
replace score_procurement = 18 if value_procurement >= 100 & value_procurement < .

* calculate subtotals
g total_services = score_personnel
g total_council = score_meetings1 + score_meetings2 + score_attendance 
g total_finances = score_taxes_raised + score_taxes_forecast + score_procurement

* calculate total score
g total_points = total_services + total_council + total_finances

* keep only important variables
keep region ///
     province ///
	 commune ///
	 value_personnel* ///
	 value_meetings1 ///
	 value_meetings2 ///
	 value_attendance ///
	 value_taxes_raised ///
	 value_taxes_forecast ///
	 value_procurement ///
	 score_personnel ///
	 score_meetings1 ///
	 score_meetings2 ///
	 score_attendance ///
	 score_taxes_raised ///
	 score_taxes_forecast ///
	 score_procurement ///
	 total_services ///
	 total_council ///
	 total_finances ///
	 total_points
	 
/* Note: this line is to be replaced by either an export to 
   csv or via the construction of JSON formatted text */
save "${dta}/poster1.dta", replace


/* =================================================== 
   ==================== Poster 2 ===================== 
   =================================================== */
	
* read csv file with raw indicator data
use "${dta}/merged.dta", clear
	
  /* Note - aggregate_final.csv is created in a separate do-file by
     combining the ecole, district sanitaire, CEB, water access, and 
	 questionnaire files and aggregating data to the district level */
	 
local national_average = 65.2

/* 1. indicator values - the number at the bottom of
   the sliding scale in the infographic */

g value_passing_exam = 100 * sd_a_01students_admitted_exam / sd_a_01students_admitted_exam - `national_average'

* no. of weeks before or after start of school year that supplies were received
g value_school_supplies = supplies_received

* calculated by aggregating number of latrines per class
g value_school_latrines = functional_latrines

g value_school_wells = functional_water / 100

g value_assisted_births = 100 * assisted_deliveries / projected_deliveries

g bcg = vaccination_coverage_bcg / target_vaccination_bcg

g vpo3 = vaccination_coverage_vpo / target_vaccination_vpo3 

g dtc = vaccination_coverage_dtchephib3 / target_vaccination_dtchephib3

g var = vaccination_coverage_var / target_vaccination_var

g vaa  = vaccination_coverage_vaa / target_vaccination_vaa

g value_vaccines = bcg * vpo3 * dtc * var * vaa * 100

g value_csps = sd_a_01stock_gas

g value_water_access = tauxaccess

g value_birth_certificates = birth_certificates / projected_deliveries


/* 2. indicator scores - the number at the top of the
   sliding scale in the infographic */

* difference from national average in pass rates of CEP
g score_passing_exam = 0
replace score_passing_exam = 1 if value_passing_exam <= -40
replace score_passing_exam = 2 if value_passing_exam <= -30
replace score_passing_exam = 3 if value_passing_exam <= -25
replace score_passing_exam = 4 if value_passing_exam <= -20
replace score_passing_exam = 5 if value_passing_exam <= -15
replace score_passing_exam = 6 if value_passing_exam <= -10
replace score_passing_exam = 7 if value_passing_exam <= -5
replace score_passing_exam = 8 if value_passing_exam <= 5
replace score_passing_exam = 9 if value_passing_exam <= 10
replace score_passing_exam = 10 if value_passing_exam <= 15
replace score_passing_exam = 12 if value_passing_exam <= 20
replace score_passing_exam = 14 if value_passing_exam <= 25
replace score_passing_exam = 18 if value_passing_exam <= 35
replace score_passing_exam = 20 if value_passing_exam > 35 & value_passing_exam < .

* delay in provision of school supplies
g score_school_supplies = max(0, 10 - sqrt(3 * value_school_supplies))

* percentage of schools with working water source
g score_school_wells = 0
replace score_school_wells = 1 if value_school_wells < 20 
replace score_school_wells = 2 if value_school_wells < 25 
replace score_school_wells = 3 if value_school_wells < 30
replace score_school_wells = 4 if value_school_wells < 35 
replace score_school_wells = 5 if value_school_wells < 40 
replace score_school_wells = 6 if value_school_wells < 45
replace score_school_wells = 7 if value_school_wells < 50 
replace score_school_wells = 8 if value_school_wells < 55 
replace score_school_wells = 9 if value_school_wells < 60
replace score_school_wells = 10 if value_school_wells < 65 
replace score_school_wells = 11 if value_school_wells < 70 
replace score_school_wells = 12 if value_school_wells < 75 
replace score_school_wells = 13 if value_school_wells < 80 
replace score_school_wells = 14 if value_school_wells < 85 
replace score_school_wells = 15 if value_school_wells < 90 
replace score_school_wells = 16 if value_school_wells < 95 
replace score_school_wells = 20 if value_school_wells < 100
replace score_school_wells = 25 if value_school_wells >= 100 & value_school_wells < .

* percentage of schools with functioning latrines for each class
g score_school_latrines = 0
replace score_school_latrines = 1 if value_school_latrines >= 30 & value_school_latrines < . 
replace score_school_latrines = 2 if value_school_latrines >= 35 & value_school_latrines < .
replace score_school_latrines = 3 if value_school_latrines >= 40 & value_school_latrines < .
replace score_school_latrines = 4 if value_school_latrines >= 50 & value_school_latrines < .
replace score_school_latrines = 5 if value_school_latrines >= 55 & value_school_latrines < .
replace score_school_latrines = 6 if value_school_latrines >= 60 & value_school_latrines < .
replace score_school_latrines = 7 if value_school_latrines >= 65 & value_school_latrines < .
replace score_school_latrines = 8 if value_school_latrines >= 70 & value_school_latrines < .
replace score_school_latrines = 9 if value_school_latrines >= 75 & value_school_latrines < .
replace score_school_latrines = 10 if value_school_latrines >= 80 & value_school_latrines < .
replace score_school_latrines = 11 if value_school_latrines >= 85 & value_school_latrines < .
replace score_school_latrines = 12 if value_school_latrines >= 90 & value_school_latrines < .
replace score_school_latrines = 14 if value_school_latrines >= 95 & value_school_latrines < .
replace score_school_latrines = 15 if value_school_latrines >= 100 & value_school_latrines < .

* percentage of births assisted by trained health worker
g score_assisted_births = 0
replace score_assisted_births = 1 if value_assisted_birth >= 40 & value_assisted_birth < .
replace score_assisted_births = 2 if value_assisted_birth >= 55 & value_assisted_birth < .
replace score_assisted_births = 4 if value_assisted_birth >= 60 & value_assisted_birth < .
replace score_assisted_births = 5 if value_assisted_birth >= 65 & value_assisted_birth < .
replace score_assisted_births = 7 if value_assisted_birth >= 70 & value_assisted_birth < .
replace score_assisted_births = 8 if value_assisted_birth >= 75 & value_assisted_birth < .
replace score_assisted_births = 9 if value_assisted_birth >= 80 & value_assisted_birth < .
replace score_assisted_births = 10 if value_assisted_birth >= 85 & value_assisted_birth < .
replace score_assisted_births = 11 if value_assisted_birth >= 90 & value_assisted_birth < .
replace score_assisted_births = 12 if value_assisted_birth >= 95 & value_assisted_birth < .
replace score_assisted_births = 13 if value_assisted_birth >= 100 & value_assisted_birth < .
replace score_assisted_births = 14 if value_assisted_birth >= 110 & value_assisted_birth < .
replace score_assisted_births = 15 if value_assisted_birth >= 120 & value_assisted_birth < .

* percentage of infants vaccinated for BCG, VAR, VAA, VPO3, and DTC-Hep+Hib3
g score_vaccines = 0
replace score_vaccines = 1 if value_vaccines >= 60 & value_vaccines < .
replace score_vaccines = 2 if value_vaccines >= 65 & value_vaccines < .
replace score_vaccines = 3 if value_vaccines >= 70 & value_vaccines < .
replace score_vaccines = 5 if value_vaccines >= 75 & value_vaccines < .
replace score_vaccines = 7 if value_vaccines >= 80 & value_vaccines < .
replace score_vaccines = 8 if value_vaccines >= 85 & value_vaccines < .
replace score_vaccines = 9 if value_vaccines >= 90 & value_vaccines < .
replace score_vaccines = 10 if value_vaccines >= 100 & value_vaccines < .
replace score_vaccines = 12 if value_vaccines >= 120 & value_vaccines < .
replace score_vaccines = 14 if value_vaccines >= 140 & value_vaccines < .
replace score_vaccines = 15 if value_vaccines >= 150 & value_vaccines < .

* percentage of CSPS with stocked gas
g score_csps = 10 * value_csps

* percentage of the population with access to potable water source
g score_water_access = 0
replace score_water_access = 1 if value_water_access >= 20 & value_water_access < .
replace score_water_access = 2 if value_water_access >= 25 & value_water_access < .
replace score_water_access = 3 if value_water_access >= 30 & value_water_access < .
replace score_water_access = 4 if value_water_access >= 35 & value_water_access < .
replace score_water_access = 5 if value_water_access >= 40 & value_water_access < .
replace score_water_access = 6 if value_water_access >= 45 & value_water_access < .
replace score_water_access = 7 if value_water_access >= 50 & value_water_access < .
replace score_water_access = 8 if value_water_access >= 55 & value_water_access < .
replace score_water_access = 9 if value_water_access >= 60 & value_water_access < .
replace score_water_access = 10 if value_water_access >= 65 & value_water_access < .
replace score_water_access = 11 if value_water_access >= 70 & value_water_access < .
replace score_water_access = 12 if value_water_access >= 75 & value_water_access < .
replace score_water_access = 13 if value_water_access >= 80 & value_water_access < .
replace score_water_access = 14 if value_water_access >= 85 & value_water_access < .
replace score_water_access = 16 if value_water_access >= 90 & value_water_access < .
replace score_water_access = 18 if value_water_access >= 95 & value_water_access < .

* percentage of birth certificates to births attended
g score_birth_certificates = 0
replace score_birth_certificates = 1 if value_birth_certificates >= 20 & value_birth_certificates < .
replace score_birth_certificates = 2 if value_birth_certificates >= 30 & value_birth_certificates < .
replace score_birth_certificates = 3 if value_birth_certificates >= 40 & value_birth_certificates < .
replace score_birth_certificates = 4 if value_birth_certificates >= 50 & value_birth_certificates < .
replace score_birth_certificates = 5 if value_birth_certificates >= 60 & value_birth_certificates < .
replace score_birth_certificates = 6 if value_birth_certificates >= 70 & value_birth_certificates < .
replace score_birth_certificates = 7 if value_birth_certificates >= 80 & value_birth_certificates < .
replace score_birth_certificates = 8 if value_birth_certificates >= 85 & value_birth_certificates < .
replace score_birth_certificates = 9 if value_birth_certificates >= 90 & value_birth_certificates < .
replace score_birth_certificates = 10 if value_birth_certificates >= 95 & value_birth_certificates < .
replace score_birth_certificates = 12 if value_birth_certificates >= 100 & value_birth_certificates < .

* calculate subtotals
g total_school = score_passing_exam + score_school_supplies + score_school_wells + score_school_latrines
g total_health = score_assisted_births + score_vaccines + score_csps
g total_water_access = score_water_access
g total_birth_certificates = score_birth_certificates

* calculate total score
g total_points = total_school + total_health + total_water_access + total_birth_certificates

* keep only important variables
keep region ///
     province ///
	 commune ///
     value_passing_exam ///
	 value_school_supplies ///
	 value_school_latrines ///
	 value_school_wells ///
	 value_assisted_births ///
	 value_vaccines ///
	 value_csps ///
	 value_water_access ///
	 value_birth_certificates ///
	 score_passing_exam ///
	 score_school_supplies ///
	 score_school_latrines ///
	 score_school_wells ///
	 score_assisted_births ///
	 score_vaccines ///
	 score_csps ///
	 score_water_access ///
	 score_birth_certificates ///
	 total_school ///
	 total_health ///
	 total_water_access ///
	 total_birth_certificates ///
	 total_points

/* Note: this line is to be replaced by either an export to 
   csv or via the construction of JSON formatted text */
save "${dta}/poster2.dta", replace

