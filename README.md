# DIME-infographics
This repository contains code to automate the creation of infographic posters for DIME team's scorecard evaluation in Burkina Faso.

## Data Source
Data for the infographic indicators were collected via interviews with key informants in the municipalities, schools, and district sanitation offices. Responses were recorded using SurveyCTO. The raw survey exports are copied, by year, to the [`data/raw`](data/raw) folder. Exports must include the following `csv` files files (shown for the 2014/2015 year below):

 - [`CEB 2014_WIDE.csv`](data/raw/2014/CEB 2014_WIDE.csv)
 - [`Directeur Ecole 2014_WIDE.csv`](data/raw/2014/Directeur Ecole 2014_WIDE.csv)
 - [`Directeur Formation Sanitaire 2014_WIDE.csv`](data/raw/2014/Directeur Formation Sanitaire 2014_WIDE.csv)
 - [`District Sanitaire 2014_WIDE.csv`](data/raw/2014/District Sanitaire 2014_WIDE.csv)
 - [`Municipalite 2014_WIDE.csv`](data/raw/2014/Municipalite 2014_WIDE.csv)

In addition, data about the availability of potable water is derived from government sources. This is normally in the form of an Excel spreadsheet, but, for the purposes of this project, it should be converted to a `csv` file and copied, by year, to the [`data/raw`](data/raw) folder (example from 2014/2015 below): 

 - [`Access Potable Water 2014.csv`](data/raw/2014/Access Potable Water 2014.csv)

## Construction of the Infographic Posters
We use [Stata 13 MP](http://www.stata.com/) to clean the data, calculate the indicators, and create JSON-formatted text files describing the layout of the posters. The latter are then read by a short Java script that uses the [Processing Development Environment](https://processing.org/) to build the infographic images.

### Stata Files
Below are brief descriptions of each of the Stata do-files. We've made liberal use of comments throughout the do-files to explain the program structure/flow.

 - [`00_master.do`](00_master.do): this is the master do-file, it sets project globals and runs all component Stata files.
 - [`01_clean.do`](01_clean.do): this file cleans and merges the raw survey data and outputs it as [`merged.dta`](data/dta/2014/merged.dta) in the [`data/dta`](data/dta) folder.
 - [`02_calculate_scores.do`](02_calculate_scores.do): this file calculates the indicators values for the infographic posters and outputs [`poster1.dta`](data/dta/2014/poster1.dta) and [`poster2.dta`](data/dta/2014/poster2.dta) to the [`data/dta`](data/dta) folder.
 - [`03_create_JSON.do`](03_create_JSON.do): this file converts the indicator data sets to JSON-formatted text, outputting [`poster1.json`](data/json/2014/poster1.json) and [`poster2.json`](data/json/2014/poster2.json) to the [`data/json`](data/json) folder.

### Java Files
The [`poster1.pde`](poster1/poster1.pde) and [`poster2.pde`](poster2/poster2.pde) sketchbook files process the JSON files exported by Stata and create the infographic poster PDFs stored in [`poster1/pdf`](poster1/pdf) and [`poster2/pdf`](poster2/pdf).

## Instructions for Replication

  1. Clone the repository to your local directory.
  2. Download and install the [Processing Development Environment](https://processing.org/download/?processing).
  3. Open and run [`00_master.do`](00_master.do). This will run all other do-files and process the raw data and create [`poster1.json`](data/json/poster1.json) and [`poster2.json`](data/json/poster2.json).
  4. If you are using [Stata 13](http://www.stata.com/) you will need to open the json files at this point ([`poster1.json`](data/json/2014/poster1.json) and [`poster2.json`](data/json/2014/poster2.json)) and replace the character `Ã‰` with the character `É` and save both with UTF-8 encoding (Stata 14 supports Unicode). 
  5. Open and run [`poster1.pde`](poster1/poster1.pde). This will create the infographic posters for poster design #1.
  6. Open and run [`poster2.pde`](poster2/poster2.pde). This will create the infographic posters for poster design #2.

## Instructions for Creating New Posters

  1. Create new folders for year `X` in the [`data/raw`](data/raw) folder and add all the raw data source files for year `X` (see above).
  2. Open [`00_master.do`](00_master.do). Update the `year` global macro to `X`; update the `national_average` global to the average rate of admission to the CEP for year `X`. Then run.
  3. If there are duplicate observations they will be written to `duplicates.xlsx` in the [`data/etc`](data/etc) folder. You can mark which to keep (e.g. the most recent submission) in the `replacements.xlsx` file. You will need to re-run [`00_master.do`](00_master.do).
  4. If there have been any changes in the names of variables you can update them in either the [`01_clean.do`](01_clean.do) file or the [`02_calculate_scores.do`](02_calculate_scores.do).
  5. If you are using [Stata 13](http://www.stata.com/) you will need to open the json files at this point ([`poster1.json`](data/json/2014/poster1.json) and [`poster2.json`](data/json/2014/poster2.json)) and replace the character `Ã‰` with the character `É` and save both with UTF-8 encoding (Stata 14 supports Unicode by default). 
  6. Open [`poster1.pde`](poster1/poster1.pde). Update the year variable to `X` and run. This will create the infographic posters for poster design #1.
  7. Open [`poster2.pde`](poster2/poster2.pde). Update the year variable to `X` and run. This will create the infographic posters for poster design #2.


## Example Posters

### Poster 1
![Banfora](poster1/poster1_example.png)

### Poster 2
![Banfora](poster2/poster2_example.png)
