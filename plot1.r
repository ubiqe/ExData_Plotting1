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
png(filename="plot1.png")
hist(powerData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
