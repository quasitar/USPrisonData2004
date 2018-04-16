#This file creates the plot from file plot1.png

#Gather sourece data remotely and unzip file into your default R directory

#create directory for the data if it does not already exist
if(!file.exists("data")){dir.create("data")}

#url where data is sourced
filUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download data
download.file(filUrl, destfile = "./data/hhDataset.zip")

#unzip data
unzip("./data/hhDataset.zip")

# Store raw data from file into data fram
dataRaw <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Only select the data for the day s we are interested in 
data <- data[dataRaw$Date == "1/2/2007" | dataRaw$Date == "2/2/2007",]

# Make Histogram, Be sure to set the axis range parameters to match the format of the example using the xaxp, yaxp parameters
hist(as.numeric(as.character(data$Global_active_power)), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", yaxp = c(0,1200,6), xaxp = c(0,6,3))

# Copy graphic to PNG file
dev.copy(png, file = "plot1.png")
dev.off()

