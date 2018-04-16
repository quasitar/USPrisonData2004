#This file creates the plot from file plot3.png

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

# create line plots
plot(t,as.numeric(as.character(data$Sub_metering_1)), type = "l", xlab = "", ylab = "Energy sub metering")
points(t,as.numeric(as.character(data$Sub_metering_2)), col = "red", type = "l")
points(t,as.numeric(as.character(data$Sub_metering_3)), col = "blue", type = "l")
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1)

# Copy graphic to PNG file
dev.copy(png, file = "plot3.png")
dev.off()

