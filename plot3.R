# Week 1, assignment 1
# The following code recreates plot3 for assignment 1 and saves it as a PNG
# in the working directory


if (exists("pwrConsSubset") != TRUE){
      wdir <- getwd()
      
      pwrConsData <- read.csv(paste0(wdir, "/household_power_consumption.txt"), 
                              sep = ";",
                              header = TRUE,
                              stringsAsFactors = FALSE,
                              na.strings = "?")
      
      # subset data
      pwrConsSubset <- subset(pwrConsData, 
                              Date %in% c("1/2/2007", "2/2/2007"))
      
      
      # generate datetime column
      pwrConsSubset$Date <- as.Date(pwrConsSubset$Date, format = "%d/%m/%Y")
      datetime <- paste(as.Date(pwrConsSubset$Date), pwrConsSubset$Time)
      
      pwrConsSubset$Datetime<- as.POSIXct(datetime)
      
}

png(filename = "plot3.png", width = 504, height = 504, units = "px", 
    type = "windows")

# generate histogram
with(pwrConsSubset, plot(Datetime, Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col = "black"))

with(pwrConsSubset, lines(Datetime, Sub_metering_2,
           col = "red"))

with(pwrConsSubset,lines(Datetime, Sub_metering_3,
           col = "blue"))

legend("topright", names(pwrConsSubset[, 7:9]), lty = 1, 
       col = c("black", "red", "blue"))

# turn off PNG device
dev.off()