Reproducible Research: Peer Assessment 1
==============================================================


## Loading and preprocessing the data


Download and place the data file in your local R directory. Then read the data into a dataframe.


```r
df <- read.csv("activity.csv")
```

Please note this work makes use of the 'dplyr', and 'lubridate packages.

## What is mean total number of steps taken per day?

The mean number of steps was 10766 per day. The median is 10765.


```r
library(dplyr)
```


```r
stepSum <- group_by(df,date)
sumdat <- summarize_all(stepSum,sum)
summary(sumdat$steps)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##      41    8841   10765   10766   13294   21194       8
```

Here is a distribution of the total number of steps taken in all days.


```r
hist(sumdat$steps,breaks = 10)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

![Sample panel plot](instructions_fig/hist1.png) 


## What is the average daily activity pattern?



```r
daily <- df %>%
group_by(interval) %>%
  summarize(mstep = mean(steps,na.rm=TRUE))
plot(daily,type = "l", ylab = "Avg Number of Steps")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png)


![Sample panel plot](instructions_fig/plot1.png)

5 minute interval with maximum number of steps is 08:35.



```r
daily$interval[daily$mstep == max(daily$mstep)]
```

```
## [1] 835
```


## Imputing missing values


First we examine how the NA's are distributed. It turns out that they are confined to particular days. And those days have NA's for each interval value.


```r
nadf <- df[is.na(df$steps),]
nasum <- group_by(nadf,date)
count(nasum,steps)
```

```
## # A tibble: 8 x 3
## # Groups:   date [8]
##   date       steps     n
##   <fct>      <int> <int>
## 1 2012-10-01    NA   288
## 2 2012-10-08    NA   288
## 3 2012-11-01    NA   288
## 4 2012-11-04    NA   288
## 5 2012-11-09    NA   288
## 6 2012-11-10    NA   288
## 7 2012-11-14    NA   288
## 8 2012-11-30    NA   288
```

We can choose to replace the NA's with their average value for each time interval.


```r
repvals <- daily$mstep
```


Then we will define a new dataframe for replacing the NA's and replace all NA's with thier replacement values.


```r
newdf <- df
newdf$steps[is.na(newdf$steps)] <- repvals
```

Then we will recalculate the mean and the distribution of total steps by day. The mean value did not change, and the median rose to 10766. By imputing additional mean values we effectively narrowed the distribution and made it more normal.


```r
stepSum2 <- group_by(newdf,date)
sumdat2 <- summarize_all(stepSum2,sum)
summary(sumdat2$steps)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##      41    9819   10766   10766   12811   21194
```


The distribution is similar, but since we effectively added more mean values is it narrower.


```r
hist(sumdat2$steps,breaks = 10)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png)

![Sample panel plot](instructions_fig/hist2.png) 

## Are there differences in activity patterns between weekdays and weekends?

First start by creating factor variable to denote which days are weekdays and weekends.



```r
library(lubridate)
```

```r
fdays <- wday(newdf$date)
fdays[fdays == 1 | fdays == 7] <- 8
fdays[fdays < 8] <- 1
fdays <-  factor(fdays,labels=c("Weekday","Weekend"))
newdf$daytype <- fdays
```

Then group by interval, and day type and complare the plots.


```r
ddf <- newdf %>%
  group_by(interval,daytype) %>%
  summarize(mstep = mean(steps,na.rm=TRUE))

par(mfrow=c(2,1),mar = c(4, 4, 2, 2))
plot(ddf$interval[ddf$daytype == "Weekday"],ddf$mstep[ddf$daytype == "Weekday"],type = "l", ylab = "Average Steps", xlab = "Interval", main = "Weekdays", col = "red")
plot(ddf$interval[ddf$daytype == "Weekend"],ddf$mstep[ddf$daytype == "Weekend"],type = "l", ylab = "Average Steps", xlab = "Interval", main = "Weekends", col = "blue")
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png)

![Sample panel plot](instructions_fig/plot2.png) 

There appears to be more activity past the morning hours on weekends. 
