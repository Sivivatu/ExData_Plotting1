#Import the dataset
power <- read.table('household_power_consumption.txt', header = T, sep = ';')

#convert the date fields and subset between 2007-02-01 and 2007-02-02
power$Date <- as.Date(power$Date, format='%d/%m/%Y')
power <- power[power$Date>="2007-02-01" & power$Date<="2007-02-02", ]
power$Time <- paste(power$Date, power$Time, sep = ' ')
power$Time <- strptime(power$Time, format = '%Y-%m-%d %H:%M:%S')
# power$Time <- as.POSIXct(power$Time, format="%H:%M:%S")

#replace all missing values with a blank and convert to numeric
power$Global_active_power <- as.numeric(gsub('?', '', power$Global_active_power))
power$Global_reactive_power <- as.numeric(gsub('?', '', power$Global_reactive_power))
power$Voltage <- as.numeric(gsub('?', '', power$Voltage))
power$Global_intensity <- as.numeric(gsub('?', '', power$Global_intensity))
power$Sub_metering_1 <- as.numeric(gsub('?', '', power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(gsub('?', '', power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(gsub('?', '', power$Sub_metering_3))

#code to generate the 4 lattice plots separated by the comments below
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#plot 1
plot(power$Time, power$Global_active_power, type = 'l', ylab= 'Global Active Power (kilowatts)', xlab = '')
#plot2
plot(power$Time, power$Voltage, type = 'l', ylab= 'Voltage', xlab = 'datetime')
#plot3
plot(power$Time, power$Sub_metering_1, type = 'l', ylab= 'Energy Sub Metering', xlab = '')
lines(power$Time, power$Sub_metering_2, col = 'red')
lines(power$Time, power$Sub_metering_3, col = 'blue')
legend('topright',c('Sub_Metering_1','Sub_Metering_2','Sub_Metering_3'),col=c(1,2,4), lwd = 1)
#plot 4
plot(power$Time, power$Global_reactive_power, type = 'l', ylab= 'Global_reactive_power', xlab = 'datetime')
dev.off()