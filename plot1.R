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
# create a histogramm of Global active power on screen device
hist(hh_subset_data$Global_active_power,col="red",main="Global Active Power", xlab = "Global Active Power (kilowatts)")
# copy histogramm from screen into 480x480 png device 
dev.copy(png, filename = "plot1.png", width = 480, height = 480, units = "px" )
dev.off()
