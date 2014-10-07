#This script works provided you have unzipped the dataset into your working directory

#Read the file into a data frame
dataPw<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")

#Find the row numbers with the 2 dates specified
dates<-dataPw$Date #work only on the Date column for speed
corrDates=grep("^1/2/2007|^2/2/2007", dates)

#Change the character columns into Date and Time objects
powerData<-dataPw[corrDates,]
powerData<-transform(powerData, Time=strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))
powerData<-transform(powerData, Date=as.Date(Date, format="%d/%m/%Y"))

#open png device and write the plot to it
png(filename="plot4.png")
par(mfrow=c(2,2))

#first subplot
plot(powerData$Time, powerData$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(powerData$Time, powerData$Global_active_power)

#second subplot
plot(powerData$Time, powerData$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(powerData$Time, powerData$Voltage)

#third subplot
plot(powerData$Time, powerData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(powerData$Time, powerData$Sub_metering_1, col="black")
lines(powerData$Time, powerData$Sub_metering_2, col="red")
lines(powerData$Time, powerData$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lt=1)

#fourth subplot
plot(powerData$Time, powerData$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(powerData$Time, powerData$Global_reactive_power)

dev.off()
