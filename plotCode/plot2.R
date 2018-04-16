#This file creates the plot from file plot2.png

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
data <- dataRaw[dataRaw$Date == "1/2/2007" | dataRaw$Date == "2/2/2007",]

# combine date and time in to Posix time
t <- strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")

# create line plot
plot(t,as.numeric(as.character(data$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


# Copy graphic to PNG file
dev.copy(png, file = "plot2.png")
dev.off()

