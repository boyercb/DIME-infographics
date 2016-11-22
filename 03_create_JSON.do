*! version 1.0 Christopher Boyer 19aug2016

/* this file creates JSON formatted text files
   for the creation of the infographic posters. */
   
version 13
set more off

local yrplus1 = ${year} - 2000 + 1 


/* =================================================== 
   ==================== Poster 1 ===================== 
   =================================================== */
   
use "${dta}/poster1.dta", clear

file open p1 using "${json}/poster1.json", write replace
file w p1 "[" _n

forval i = 1/`=_N' {

    * get current values
    foreach var of varlist _all {
        local `var' = `var'[`i']
    }    

    * write formatted json
    
    * header
    file w p1 _tab(1) "{" _n 
    file w p1 _tab(2) `""label": "PERFORMANCE MUNICIPALE ${year}/`yrplus1'","' _n
    file w p1 _tab(2) `""year": "${year}/`yrplus1'","' _n 
    file w p1 _tab(2) `""commune": `commune',"' _n
    file w p1 _tab(2) `""total_points": `total_points',"' _n
    file w p1 _tab(2) `""max_points": 86,"' _n 
    file w p1 _tab(2) `""stars": `stars_total',"' _n
	
    file w p1 _tab(2) `""items":["' _n 
    
    * section 1: municipal services 
    file w p1 _tab(3) "{" _n
    file w p1 _tab(4) `""label": "MAIRIE/SERVICES MUNICIPAUX","' _n
    file w p1 _tab(4) `""points": `total_services',"' _n
    file w p1 _tab(4) `""max_points": 10,"' _n
	file w p1 _tab(4) `""stars": `stars_services',"' _n
    file w p1 _tab(4) `""personnel": {"' _n
	file w p1 _tab(5) `""agent_materiel_transfere": `value_personnel1',"' _n
    file w p1 _tab(5) `""agent_secretaire": `value_personnel2',"' _n
    file w p1 _tab(5) `""agent_etat_civil": `value_personnel3',"' _n
    file w p1 _tab(5) `""agent_services_statistiques": `value_personnel4',"' _n
    file w p1 _tab(5) `""agent_service_techniques": `value_personnel5',"' _n
    file w p1 _tab(5) `""comptable": `value_personnel6',"' _n
    file w p1 _tab(5) `""regisseur_recettes": `value_personnel7',"' _n
    file w p1 _tab(5) `""agent_affaires_domaniales_foncieres": `value_personnel8'"' _n
    file w p1 _tab(4) "}" _n
	file w p1 _tab(3) "}," _n
    
    * section 2: councils 
    file w p1 _tab(3) "{" _n
    file w p1 _tab(4) `""label": "CONSEIL MUNICIPAL","' _n
    file w p1 _tab(4) `""points": `total_council',"' _n
    file w p1 _tab(4) `""max_points": 23,"' _n
    file w p1 _tab(4) `""stars": `stars_council',"' _n

    file w p1 _tab(4) `""items": ["' _n

    * subsection 2.1: 
    file w p1 _tab(5) "{" _n
    file w p1 _tab(6) `""label": "Nombre de sessions\ndu Conseil Municipal\ntenues en ${year}","' _n
    file w p1 _tab(6) `""score": `score_meetings1',"' _n
    file w p1 _tab(6) `""meetings": {"' _n
	file w p1 _tab(7) `""session_1": `value_meetings1_1',"' _n
	file w p1 _tab(7) `""session_2": `value_meetings1_2',"' _n
	file w p1 _tab(7) `""session_3": `value_meetings1_3',"' _n
	file w p1 _tab(7) `""session_4": `value_meetings1_4'"' _n
    file w p1 _tab(6) "}" _n
    file w p1 _tab(5) "}," _n
    
    * subsection 2.3:
    file w p1 _tab(5) "{" _n
    file w p1 _tab(6) `""label": "Nombre de cadres de\nconcertations organisés\npar la mairie en ${year}","' _n
    file w p1 _tab(6) `""score": `score_meetings2',"' _n
    file w p1 _tab(6) `""meetings": {"' _n
	file w p1 _tab(7) `""session_1": `value_meetings2_1',"' _n
	file w p1 _tab(7) `""session_2": `value_meetings2_2',"' _n
	file w p1 _tab(7) `""session_3": `value_meetings2_3',"' _n
	file w p1 _tab(7) `""session_4": `value_meetings2_4'"' _n
    file w p1 _tab(6) "}" _n	
    file w p1 _tab(5) "}," _n
	
    * subsection 2.2:
    file w p1 _tab(5) "{" _n
    file w p1 _tab(6) `""label": "Taux de participation\naux sessions ordinaires du\nConseil Municipal (%)","' _n
    file w p1 _tab(6) `""value": `value_attendance',"' _n
    file w p1 _tab(6) `""score": `score_attendance',"' _n
    file w p1 _tab(6) `""points": [0,1,4,6,8,10],"' _n
    file w p1 _tab(6) `""scale_marks": [20,40,60,80,90,100]"' _n
    file w p1 _tab(5) "}" _n
    
    file w p1 _tab(4) "]" _n
    file w p1 _tab(3) "}," _n 
    
    * section 3: finances
    file w p1 _tab(3) "{" _n
    file w p1 _tab(4) `""label": "GESTION FINANCIERE","' _n
    file w p1 _tab(4) `""points": `total_finances',"' _n
    file w p1 _tab(4) `""max_points": 53,"' _n
    file w p1 _tab(4) `""stars": `stars_finances',"' _n

    file w p1 _tab(4) `""items": ["' _n
    
    * subsection 3.1: 
    file w p1 _tab(5) "{" _n
    file w p1 _tab(6) `""label": "Recettes fiscales collectées\nen ${year} en fonction de la\npopulation (FCFA/habitant)","' _n
    file w p1 _tab(6) `""value": `value_taxes_raised',"' _n
    file w p1 _tab(6) `""score": `score_taxes_raised',"' _n
    file w p1 _tab(6) `""points": [0,10,15,25],"' _n
    file w p1 _tab(6) `""scale_marks": [50,2200,4500,7500]"' _n
    file w p1 _tab(5) "}," _n
    
    * subsection 3.2: 
    file w p1 _tab(5) "{" _n 
    file w p1 _tab(6) `""label": "Taux du recouvrement de\ntaxes en ${year} en fonction\ndes prévisions (%)","' _n
    file w p1 _tab(6) `""value": `value_taxes_forecast',"' _n
    file w p1 _tab(6) `""score": `score_taxes_forecast',"' _n
    file w p1 _tab(6) `""points": [0,2,4,6,8,10],"' _n
    file w p1 _tab(6) `""scale_marks": [50,60,70,80,90,100]"' _n
    file w p1 _tab(5) "}," _n
    
    * subsection 3.3
    file w p1 _tab(5) "{" _n
    file w p1 _tab(6) `""label": "Taux d’exécution du plan\nde passation des marchés\nau cours de ${year} (%)","' _n
    file w p1 _tab(6) `""value": `value_procurement',"' _n
    file w p1 _tab(6) `""score": `score_procurement',"' _n
    file w p1 _tab(6) `""points": [0,1,4,7,12,16],"' _n
    file w p1 _tab(6) `""scale_marks": [0,20,40,60,80,100]"' _n
    file w p1 _tab(5) "}" _n
    
    file w p1 _tab(4) "]" _n
    file w p1 _tab(3) "}" _n
    file w p1 _tab(2) "]" _n
    
    if `i' == `=_N' {
        file w p1 _tab(1) "}" _n
    }
    else {
        file w p1 _tab(1) "}," _n
    }
}
            
file w p1 "]" _n 
file close p1


/* =================================================== 
   ==================== Poster 2 ===================== 
   =================================================== */
   
use "${dta}/poster2.dta", clear

file open p2 using "${json}/poster2.json", write replace
file w p2 "[" _n

forval i = 1/`=_N' {

    * get current values
    foreach var of varlist _all {
        local `var' = `var'[`i']
    }    
    
    file w p2 _tab(1) "{" _n
    file w p2 _tab(2) `""label": "PERFORMANCE MUNICIPALE ${year}/`yrplus1'","' _n
    file w p2 _tab(2) `""year": "${year}/`yrplus1'","' _n
    file w p2 _tab(2) `""commune": `commune',"' _n
    file w p2 _tab(2) `""total_points": `total_points',"'  _n
    file w p2 _tab(2) `""max_points": 140,"'  _n
    file w p2 _tab(2) `""stars": `stars_total',"' _n

    file w p2 _tab(2) `""items":["' _n

    file w p2 _tab(3) "{" _n
    file w p2 _tab(4) `""label": "ÉCOLES PRIMAIRES","' _n
    file w p2 _tab(4) `""points": `total_school',"'  _n
    file w p2 _tab(4) `""max_points": 70,"'  _n
    file w p2 _tab(4) `""stars": `stars_school',"' _n

    file w p2 _tab(4) `""items": ["' _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Écart entre le taux d'admission\nau CEP dans la commune et au\nniveau national (en points\nde pourcentage)","'  _n
    file w p2 _tab(6) `""value": `value_passing_exam',"' _n
    file w p2 _tab(6) `""score": `score_passing_exam',"'  _n
    file w p2 _tab(6) `""points": [0,4,8,14,18],"' _n
    file w p2 _tab(6) `""scale_marks": [-40,-20,0,20,35]"' _n
    file w p2 _tab(5) "}," _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Retard moyen d'appro-\nvisionnement en fournitures\nscolaires (nombre de jours\naprès la rentrée scolaire)","' _n
    file w p2 _tab(6) `""value": `value_school_supplies',"' _n
    file w p2 _tab(6) `""score": `score_school_supplies',"'  _n
    file w p2 _tab(6) `""points": [1,2,3,5,10],"'  _n
    file w p2 _tab(6) `""scale_marks": [50,25,10,4,0]"' _n
    file w p2 _tab(5) "}," _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux d'écoles avec\nun forage fonctionnel","'  _n
    file w p2 _tab(6) `""value": `value_school_wells',"' _n
    file w p2 _tab(6) `""score": `score_school_wells',"' _n
    file w p2 _tab(6) `""points": [0,2,8,12,25],"'  _n
    file w p2 _tab(6) `""scale_marks": [0,25,50,75,100]"' _n
    file w p2 _tab(5) "}," _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux d’écoles avec\ndes latrines fonctionnelles\npour chaque classe","' _n
    file w p2 _tab(6) `""value": `value_school_latrines',"' _n
    file w p2 _tab(6) `""score": `score_school_latrines',"'  _n
    file w p2 _tab(6) `""points": [0,3,6,10,15],"'  _n
    file w p2 _tab(6) `""scale_marks": [25,40,60,80,100]"' _n
    file w p2 _tab(5) "}" _n

    file w p2 _tab(4) "]" _n
    file w p2 _tab(3) "}," _n

    file w p2 _tab(3) "{" _n
    file w p2 _tab(4) `""label": "SANTÉ","' _n
    file w p2 _tab(4) `""points": `total_health',"'  _n
    file w p2 _tab(4) `""max_points": 40,"'  _n
    file w p2 _tab(4) `""stars": `stars_health',"' _n

    file w p2 _tab(4) `""items": ["' _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux d’accouchements\nassistés pendant l’année","'  _n
    file w p2 _tab(6) `""value": `value_assisted_births',"'  _n
    file w p2 _tab(6) `""score": `score_assisted_births',"'  _n
    file w p2 _tab(6) `""points": [0,5,10,15],"'  _n
    file w p2 _tab(6) `""scale_marks": [35,65,85,100]"' _n
    file w p2 _tab(5) "}," _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux de nourrissons\n0-11 mois ayant été vaccinés\navec le BCG, VAR, VAA, VPO3,\nDTC-Hep+Hib3 en ${year}","'  _n
    file w p2 _tab(6) `""value": `value_vaccines',"'  _n
    file w p2 _tab(6) `""score": `score_vaccines',"' _n
    file w p2 _tab(6) `""points": [0,3,5,7,15],"' _n
    file w p2 _tab(6) `""scale_marks": [55,65,75,90,100]"' _n
    file w p2 _tab(5) "}," _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux de CSPS ayant reçu\nun stock de gaz suffisant de la\nmunicipalité entre juin\net décembre ${year}","' _n
    file w p2 _tab(6) `""value": `value_csps',"' _n
    file w p2 _tab(6) `""score": `score_csps',"'  _n
    file w p2 _tab(6) `""points": [0,5,8,10],"' _n
    file w p2 _tab(6) `""scale_marks": [0,50,80,100]"' _n
    file w p2 _tab(5) "}" _n

    file w p2 _tab(4) "]" _n 
    file w p2 _tab(3) "}," _n

    file w p2 _tab(3) "{" _n
    file w p2 _tab(4) `""label": "EAU ET ASSAINISSEMENT","'  _n
    file w p2 _tab(4) `""points": `total_water_access',"'  _n
    file w p2 _tab(4) `""max_points": 18,"' _n
    file w p2 _tab(4) `""stars": `stars_water_access',"' _n

    file w p2 _tab(4) `""items": ["' _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux de la population avec\naccès à une source d’eau\npotable fonctionnelle à 1000m\npour 300 personnes/forage","' _n
    file w p2 _tab(6) `""value": `value_water_access',"' _n
    file w p2 _tab(6) `""score": `score_water_access',"' _n
    file w p2 _tab(6) `""points": [0,4,8,12,18],"' _n
    file w p2 _tab(6) `""scale_marks": [15,35,55,75,100]"' _n
    file w p2 _tab(5) "}" _n

    file w p2 _tab(4) "]" _n 
    file w p2 _tab(3) "}," _n

    file w p2 _tab(3) "{" _n
    file w p2 _tab(4) `""label": "ACTES DE NAISSANCES","' _n
    file w p2 _tab(4) `""points": `total_birth_certificates',"' _n
    file w p2 _tab(4) `""max_points": 12,"' _n
	file w p2 _tab(4) `""stars": `stars_birth_certificates',"' _n
	
    file w p2 _tab(4) `""items": ["' _n

    file w p2 _tab(5) "{" _n
    file w p2 _tab(6) `""label": "Taux d'actes de naissances\ndélivrés aux nouveau-nés\ncomparé aux naissance\nattendues","'  _n
    file w p2 _tab(6) `""value": `value_birth_certificates',"' _n
    file w p2 _tab(6) `""score": `score_birth_certificates',"' _n
    file w p2 _tab(6) `""points": [0,1,3,5,7,12],"' _n
    file w p2 _tab(6) `""scale_marks": [10,20,45,60,80,100]"' _n
    file w p2 _tab(5) "}" _n
    
    file w p2 _tab(4) "]" _n
    file w p2 _tab(3) "}" _n
    file w p2 _tab(2) "]" _n
    
    if `i' == `=_N' {
        file w p2 _tab(1) "}" _n
    }
    else {
        file w p2 _tab(1) "}," _n
    }
    
}

file w p2 "]" _n 
file close p2
