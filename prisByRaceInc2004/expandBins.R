# This funtion is desiged to expand a set of vector bin values from their initial bin interval, to a larger interval.

# For example this is good to use if you want to transfrom data that is initially binned in 7-day groups, to bins that are in 21 day groups. 

# The function will output a new vector of binned values of length equal to newIntMax

# It takes 4 inputs

# xraw is the input vector of bin values to be scaled
# oldIntMax is the max value in each bin for the xraw bins
# newIntMax is the max value in each bin for the new transformed bins
# sMult is a scaler multiplier to multiply the input bin values

expandBins <- function(xraw, oldIntMax, newIntMax, sMult){
  
  
    # create fudge to help ensure that the sum of all binned values gets conserved when we transform the group.
    xfudge <- (1-sum(xraw))/length(xraw)
    x <- xraw + xfudge

    # create interpolated bin values for each intermediate integer based on the data from the input bin values 
    for(i in 1:length(oldIntMax)) {
       if(i==1) xnew <- rep(x[i]/(1*sMult),1*sMult)
       else xnew <- c(xnew,rep(x[i]/(sMult*(oldIntMax[i]-oldIntMax[i-1])),sMult*(oldIntMax[i]-oldIntMax[i-1])))

    }

    # combine the intermediate bin values to the desired bin width for the transformed bin values 
    for(i in 1:length(newIntMax)) {
      if(i==1) xtrans <- sum(xnew[1:newIntMax[i]])
      else xtrans <- c(xtrans,sum(xnew[(newIntMax[i-1]+1):newIntMax[i]]))
    }

    # return transfromed bin vector
    xtrans

}
