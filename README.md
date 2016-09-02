# DIME-infographics
This repository contains code to automate the creation of infographic posters for DIME team's scorecard evaluation in Burkina Faso.

## Data Source
Data for the infographic indicators were collected via interviews with key informants in the municipalities, schools, and district sanitation offices. Responses were recorded using SurveyCTO. The raw survey exports are copied to the [`data/raw`](data/raw) folder and include the following `csv` files:

 - [`CEB 2014_WIDE.csv`](data/raw/CEB 2014_WIDE.csv)
 - [`Directeur Ecole 2014_WIDE.csv`](data/raw/Directeur Ecole 2014_WIDE.csv)
 - [`Directeur Formation Sanitaire 2014_WIDE.csv`](data/raw/Directeur Formation Sanitaire 2014_WIDE.csv)
 - [`District Sanitaire 2014_WIDE.csv`](data/raw/District Sanitaire 2014_WIDE.csv)
 - [`Municipalite 2014_WIDE.csv`](data/raw/Municipalite 2014_WIDE.csv)
 
## Construction of the Infographic Posters
We use [Stata 13 MP](http://www.stata.com/) to clean the data, calculate the indicators, and create JSON-formatted text files describing the layout of the posters. The latter are then read by a short Java script that uses the [Processing Development Environment](https://processing.org/) to build the infographic images.

### Stata Files
Below are brief descriptions of each of the Stata do-files. We've made liberal use of comments throughout the do-files to explain the program structure/flow.

 - [`00_master.do`](00_master.do): this is the master do-file, it sets project globals and runs all component Stata files.
 - [`01_clean.do`](01_clean.do): this file cleans and merges the raw survey data and outputs it as [`merged.dta`](data/dta/merged.dta) in the [`data/dta`](data/dta) folder.
 - [`02_calculate_scores.do`](02_calculate_scores.do): this file calculates the indicators values for the infographic posters and outputs [`poster1.dta`](data/dta/poster1.dta) and [`poster2.dta`](data/dta/poster2.dta) to the [`data/dta`](data/dta) folder.
 - [`03_create_JSON.do`](03_create_JSON.do): this file converts the indicator data sets to JSON-formatted text, outputting [`poster1.json`](data/json/poster1.json) and [`poster2.json`](data/json/poster2.json) to the [`data/json`](data/json) folder.

### Java Files
The [`poster1.pde`](poster1/poster1.pde) and [`poster2.pde`](poster2/poster2.pde) sketchbook files process the JSON files exported by Stata and create the infographic poster PDFs stored in [`poster1/pdf`](poster1/pdf) and [`poster2/pdf`](poster2/pdf).

## Instructions for Replication

  1. Clone the repository to your local directory.
  2. Download and install the [Processing Development Environment](https://processing.org/download/?processing).
  3. Open and run [`00_master.do`](00_master.do). This will process the raw data and create [`poster1.json`](data/json/poster1.json) and [`poster2.json`](data/json/poster2.json).
  4. Open and run [`poster1.pde`](poster1/poster1.pde). This will create the infographic posters for poster design #1.
  5. Open and run [`poster2.pde`](poster2/poster2.pde). This will create the infographic posters for poster design #2.

## Examples

### Poster 1
![ABSOUYA Slide](https://github.com/boyercb/DIME-infographics/blob/master/poster1/pdf/ABSOUYA.pdf)

### Poster 2
![ABSOUYA Slide](https://github.com/boyercb/DIME-infographics/blob/master/poster2/pdf/ABSOUYA.pdf)
