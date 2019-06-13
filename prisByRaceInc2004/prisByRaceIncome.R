# This function uses a combination of 2004 US Census Household Income data and 2004 US prison pre-incarceration income data, and generates a tidy .CSV file for importing into Tableau for visualization and story boarding. 

# The function also returns 6 numbers in vector form: the expected number, and actual number of African American Males in prison, follwed by their ratio, then the next 3 numbers are the same but for Non-Hispanic Whites

# The data sources are noted in the code comments

# US census data compiled from https://www.census.gov/prod/2005pubs/p60-229.pdf Table A-1

prisByRaceIncome <- function(){

    # Define household income bins for data 
    labs <- c("0-25K","25-35K","35-50K","50-75K","75-100K","100K plus")

    # Distribution of incomes for African Americans by fraction of African American Population
    saldistAA <- c(.423,.141,.149,.148,.072,.067)

    # Distribution of incomes for Non-Hispanic Whites by fraction of Non-Hispanic White population
    saldistW <- c(.251,.112,.145,.191,.121,.18)

    # Populations for African Americans & Non-Hispanic Whites from 2004 Census Data
    aaPop <- 36121000
    wPop <- 194877000

    # Population Distribution of incomes by race
    aaSalDist <- aaPop*saldistAA
    wSalDist <- wPop*saldistW

    # Population Distribution of incomes ratio between Non-Hispanic Whites and African Americans
    poprat <- wSalDist/aaSalDist

    # Prison Income Data from https://www.prisonpolicy.org/reports/income.html Figure #6

    # Scale factor tell how many ruler increments correspond to 10% in height on Figure 6 chart. Here based on the zoom during the measurements 13 ruler increments corresponded to a height of 10%

    scaleFactor <- .10/13

    # Raw measurements for each bin of pre-incarceration income  in units of ruler increments
    xraw <- (c(2.3,4.5,10,10.3,9.2,10.9,12,15.2,13.2,13.8,13.8,5.4,9))*scaleFactor

    # max value of income for each bin
    max <- c(0,199,399,599,799,999,1199,1499,1999,2499,4999,7499,12499)

    # max valus of income for each bin the data will be transformed to
    transmax <- c(24999,34999,49999,74999,99999,150000)

    # transform the data from monthly income to yearly income
    source("expandBins.R")
    newPrisRatio <- expandBins(xraw,max,transmax,12)

    #Prison Population of Males taken from https://www.bjs.gov/content/pub/pdf/p04.pdf  Table 10

    actAApop <- 551300
    actWpop <- 449300

    # Calculating the expected ratio of African Americans to Non-Hispanic Whites based on income distribion in the census, and income distribution of prisoners

    # Population Distribution of African Americans and Non-Hispanic Whites combined
    ppopdist <- (actAApop+actWpop)*newPrisRatio

    # If we assume that the income ratio between African Americans and Non-White Hispanics is the same for the prison populaiton, as it is in the overall population, then that implies that if you are given some population of prisoners = C, 

    #where C = A + B. Where A = the number of African Americans, and B = the number of Non-Hispanic Whites.

    #But since we assume that the population ratio between the 2 is x, then you have B/A = x. We know x for each income bin as it was calculated using poprat. We can then eliminate one variable by substituting B = xA

    #which implies C = A +xA, or C = (1+x)A, we can call (1+x) the partial population reciprocal since

    # (1+x) = 1 + B/A = (B+A)/A

    # and 1/(1+x) = A/(A+B)

    # (1+x) the partial population reciprocal
    popratRecp <- poprat+1

    # Expected Income distribution of African American   prisoners by population of African Americans
    AAppop <- ppopdist/popratRecp

    # Expected Income distribution of Non-Hispanic White prisoners by population of Non-Hispanic Whites
    Wppop <- AAppop*poprat

    # Expected total number of African Americans in Prison
    expPopAA <- sum(AAppop)

    # Write data to CSV file

    # First combine data into Data Frame
    df <- data.frame(labs,aaSalDist,wSalDist,ppopdist,AAppop,Wppop)
    
    # Choose better names for columns
    colnames(df) <- (c("IncomeRange","AfrAmerPopByInc","NonHispWhitePopByInc","PrisonPopByInc","ExpAAPrisPop","ExpNHWhitePrisPop"))

    # write df to .csv file
    write.csv(df,"prisIncRace2004.csv")


    # Return the expected number, and actual number of African American Males in prison, follwed by their ratio, then the next 3 numbers are the same but for Non-Hispanic Whites

    c(expPopAA,actAApop,actAApop/expPopAA,sum(Wppop),actWpop,actWpop/sum(Wppop))

}
