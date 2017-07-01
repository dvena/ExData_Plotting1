# Week 1, assignment 1
# The following code recreates plot1 for assignment 1 and saves it as a PNG
# in the working directory


if (exists("pwrConsSubset") != TRUE){
    wdir <- getwd()
    
    pwrConsData <- read.csv(paste0(wdir, "/household_power_consumption.txt"), 
                              sep = ";",
                              header = TRUE,
                              stringsAsFactors = FALSE,
                              na.strings = "?")
    
    # code "?" as missing data and convert to NA
    pwrConsData[pwrConsData == "?"] <- NA
    
    # convert date and time column classes
    pwrConsData[,"Date"] = format(as.Date(pwrConsData[, "Date"], format = "%d/%m/%Y"), "%d/%m/%Y")
    pwrConsData[, "Time"] = format(strptime(pwrConsData[, "Time"], format = "%H:%M:%S"), 
                                   "%H:%M:%S")
    
    pwrConsData[,3:length(pwrConsData)] <- as.matrix(lapply(names(pwrConsData[,3:length(pwrConsData)]), function(x) 
        pwrConsData[, x] = as.numeric(pwrConsData[, x])))
    
    # subset data from 2007-02-01 to 2007-02-02
    pwrConsSubset <- subset(pwrConsData, 
                           Date %in% c("01/02/2007", "02/02/2007"))

}



# Open PNG device

png(filename = "plot1.png", width = 504, height = 504, units = "px", 
    type = "windows")

# generate histogram
hist(pwrConsSubset[, "Global_active_power"], 
     #yaxt = 'n',
     xlim = c(0,6),
     #ylim = c(0, 1500),
     xaxt = 'n',
     #yaxt = 'n',
     breaks = 16,
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")
axis(side = 1, at = seq(0,6,2), labels = seq(0,6,2))
#axis(2, at=axTicks(2), labels=axTicks(2)/10)

# turn off PNG device
dev.off()
