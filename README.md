# USPrisonData

This repository describes the data analyzed and the code used for presentation purposes in the following Tableau web story:

https://public.tableau.com/profile/sean.kalsi#!/vizhome/pris2004/pris2004

The purpose of the story is to demonstrate that income cannot be used as a significant contributor to the disproportionate representation of African Americans in US prisons.

The data that was used for the presentation was sourced from the folowing 3 sources:

US census data compiled is from: https://www.census.gov/prod/2005pubs/p60-229.pdf Table A-1

Prison Income Data is taken from: https://www.prisonpolicy.org/reports/income.html Figure #6

Prison Population of Males taken from: https://www.bjs.gov/content/pub/pdf/p04.pdf  Table 10

This data was copied by hand into the following R program which was then used to process the data:

prisByRaceIncome.R

This file produces the tidy .csv file prisIncRace2004.csv which was then uploaded into tableau.

The CodeBook file describes the analyis performed on the data.

The prisByRaceIncome2004 folder contains the R programs used for creating the data file that was uploaded to Tableau.