

# download zip file with raw data from url specified in README file and unzip it
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfilename <- "hpc.zip" 
datafilename <- "household_power_consumption.txt"
download.file(dataUrl,zipfilename)
unzip(zipfilename)

#read in data, zip and text file remain in working directory
hpc_raw <- read.table(datafilename, header = T, comment.char = "", na.strings = "?", sep = ";",colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#get subset for the desired dates
hpc_sub <- hpc_raw[with(hpc_raw, Date == "1/2/2007" | Date == "2/2/2007"), ] 

#create additional column with datetime as POSIXlt objects
hpc_clean <- within(hpc_sub, datetime <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S", tz = ""))

#display plot on screen device with parameters to resemble sample image 2 from README file
plot(hpc_clean$datetime,hpc_clean$Global_active_power,xlab ="", ylab = "Global Active Power (kilowatts)", col = "black", type = "l")

#copy screen device to png file
dev.copy(png,"plot2.png", width = 480, height = 480)
dev.off()