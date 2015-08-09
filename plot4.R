# Note: This file is part of course project of Coursera MOOC
# Exploratory Data Analysis. Identical readdata function has been copy-pasted
# to all four scripts to make the scripts self-contained and ease reviewing.

# This repository doesn't contain household_power_consumption.txt used as
# data for the plots (it's about 20 MB zipped). If you want to get it, please
# see the instruction in README.md.

readdata <- function() {
    read.csv("household_power_consumption.txt",
             header = FALSE,
             col.names = c("Date", "Time", "Global_active_power",
                           "Global_reactive_power", "Voltage", "Global_intensity",
                           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             sep = ";",
             na.strings = "?",
             colClasses = c("character", "character", "numeric", "numeric",
                            "numeric", "numeric", "numeric", "numeric",
                            "numeric"),
             nrows = 2880,  # We assume particular layout of file to extract
             skip = 66637)  # required dates.
}

parsetime <- function(d) {
    strptime(paste(d$Date, d$Time), "%d/%m/%Y %H:%M:%S")
}

d <- readdata()
t <- parsetime(d)

png("plot4.png")
par(mfrow = c(2, 2))
plot(t, d$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
plot(t, d$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
plot(t, d$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
lines(t, d$Sub_metering_2, col="red")
lines(t, d$Sub_metering_3, col="blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n",
       col = c("black", "red", "blue"),
       lwd = 1)
plot(t, d$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()
