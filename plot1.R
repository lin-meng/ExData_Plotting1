# Created by Meng Lin
# Created on June 5, 2015
# Purpose: Plot household energy usage from 2007-2-1 to 2007-2-2
# Last executed on June 6, 2015
Sys.time()

# Clear the workspace
rm(list=ls(all=TRUE))

# Set the working directory
setwd("E:/Extra/R")

# Get the header for the subset of the data
dfheader <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)

# Get the subset of the data from 2007-2-1 to 2007-2-2
# Based on the initial investigation of the dataset, 2880 data points were found from 2007-2-1 to 2007-2-2
df <- read.table('household_power_consumption.txt', skip = grep("1/2/2007", readLines('household_power_consumption.txt'))-1, nrows=2880, header = FALSE, sep =';')

# Assign header to the subset
colnames( df ) <- unlist(dfheader)

# Combine the Date and Time variables of the subset as datetime variable
df$datetime <- do.call(paste, c(df[c("Date", "Time")], sep = "T"))

# Convert the datetime variable to the actual date and time format
df$datetime =strptime(df$datetime, "%d/%m/%YT%H:%M:%S")

# Check the subset and make sure it is ready to be plotted
summary(df)

# Attach the data
attach(df)

# Start PNG device to plot the histogram of the Global Active Power to plot1.png
png(filename="plot1.png", height=480, width=480, bg="white")

hist(Global_active_power, col='red', main="Global Active Power", xlab = 'Global Active Power (kilowatts)')

dev.off()
