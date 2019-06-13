### Introduction

This file describes the data analyzed for presentation in the following Tableau web story:

https://public.tableau.com/profile/sean.kalsi#!/vizhome/pris2004/pris2004

### Data Sources

The data that was used for the tableau presentation was sourced from the following 3 sources:

US census data compiled from https://www.census.gov/prod/2005pubs/p60-229.pdf Table A-1

Prison Income Data from https://www.prisonpolicy.org/reports/income.html Figure #6

Prison Population of Males taken from https://www.bjs.gov/content/pub/pdf/p04.pdf  Table 10

This data was copied by hand into the following R program which was then used to process the data:

`prisByRaceIncome.R`

The program has an output as well, and it returns 6 numbers: the expected number and the actual number of African American Males in prison, followed by their ratio, then the next 3 numbers are the same but for Non-Hispanic Whites.

This file produces the tidy .csv file `prisIncRace2004.csv` which was then uploaded into tableau.

`prisIncRace2004.csv` file size is 4KB


### Data Code Book

The `prisIncRace2004.csv` file contains 7 columns and six rows.

Each of the 6 rows has data that corresponds to the population data for each of the 6 income ranges.

$0-$25,000
$25,000-$35,000
$35,000-$50,000
$50,000-$75,000
$75,000-$100,000
$100,000+

This table structure is a bit unorthodox due to the fact that it was used for presentation purposes only. The data in the `prisByRaceIncome.R` was aggregated by eye from the references, and my analysis did not deal with the raw data that the references were sourced from.

There are a total of 7 columns. 

`Income Range`: Contains values for each of the 6 income ranges specified above.

`Afr Amer Pop By Inc`: The US Population of African Americans in 2004 for the specified income range. 

`Non Hisp White Pop By Inc`: The US Population of Non Hispanic Whites in 2004 for the specified income range.

`Prison Pop By Inc`: The population of prisoners in 2004 by pre-incarcertion income.

`Exp AA Pris Pop`: The estimated expected number of African American males in the Prison Population for each income range.

`Exp NH White Pris Pop`: The estimated expected number of Non Hispanic White males in the Prison Population for each income range.

`ratioWtoAA`: Contains the ratio of Non Hispanic Whites to African Americans in the US population for each income range in 2004.



### Cleaning Process

Due to the fact that the pre-incarceration income data was originally binned by monthly income, it was necessary to convert that to annual income. The program `expandBins.R` was used for that purpose.

The comments in the `prisByRaceIncome.R` code talk more about the method for creating the new bins.

