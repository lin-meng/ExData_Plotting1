# Created by Meng Lin
# Created on June 5, 2015
# Purpose: examine how household energy usage varies over 2007-2-1 to 2007-2-2
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

# Start PNG device to plot the Global Active Power over the two days to plot2.png
png(filename="plot2.png", height=480, width=480, bg="white")

plot(datetime, Global_active_power, type='l', xlab = ' ', ylab = 'Global Active Power (kilowatts)')

dev.off()
