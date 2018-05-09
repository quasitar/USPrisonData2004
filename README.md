# USPrisonData

This repository describes the data analyzed for presentation in the following Tableau web story:

https://public.tableau.com/profile/sean.kalsi#!/vizhome/pris2004/pris2004

### Data Sources

The data that was used for the tableau presentation was sourced from the following 3 sources:

US census data compiled from: https://www.census.gov/prod/2005pubs/p60-229.pdf Table A-1

Prison Income Data from: https://www.prisonpolicy.org/reports/income.html Figure #6

Prison Population of Males taken from: https://www.bjs.gov/content/pub/pdf/p04.pdf  Table 10

This data was copied by hand into the following R program which was then used to process the data:

`prisByRaceIncome.R`

The program has an output as well, and it returns 6 numbers: the expected number and the actual number of African American Males in prison, followed by their ratio, then the next 3 numbers are the same but for Non-Hispanic Whites.

This file produces the tidy .csv file `prisIncRace2004.csv` which was then uploaded into tableau.

`prisIncRace2004.csv` file size is 4KB