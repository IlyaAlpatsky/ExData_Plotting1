# load data archive from given URL
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
# unzip data archive
con <- unz(temp, "household_power_consumption.txt")
#read data from file, create datetime collumn and unlink conections
hh_data <- read.csv2(file=con, header=TRUE, sep=";",na.strings = "?",dec = ".")
hh_data <- within(hh_data, Datetime <- as.POSIXlt(paste(Date, Time),format = "%d/%m/%Y %H:%M:%S"))
unlink(temp)
unlink(con)
#create subset for choosen daterange 
startDate = as.POSIXct("2007-02-01");
endDate = as.POSIXct("2007-02-03");
hh_subset_data <- subset(hh_data,(hh_data$Datetime >= startDate) & (hh_data$Datetime<endDate))
# create a plot Energy sub metering 1 by datetime line with respect to x-label, y-label and main title
plot(hh_subset_data$Datetime,hh_subset_data$Sub_metering_1, col="black",main="",xlab="",ylab = "Energy sub metering",type="l")
# create plots for Energy sub metering 2 and 3 by datetime
lines(hh_subset_data$Datetime,hh_subset_data$Sub_metering_2, col="red")
lines(hh_subset_data$Datetime,hh_subset_data$Sub_metering_3, col="blue")
# crete a legend (unfortunately box was sized wrongly so I used workaround with additional blank symbols)
legend("topright",legend=c("Sub_metering_1             ","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty=1)
# copy histogramm from screen into 480x480 png device 
dev.copy(png, filename = "plot3.png", width = 480, height = 480, units = "px" )
dev.off()