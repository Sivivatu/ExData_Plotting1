#Import the dataset
power <- read.table('household_power_consumption.txt', header = T, sep = ';')

#convert the date fields and subset between 2007-02-01 and 2007-02-02
power$Date <- as.Date(power$Date, format='%d/%m/%Y')
power <- power[power$Date>="2007-02-01" & power$Date<="2007-02-02", ]
power$Time <- paste(power$Date, power$Time, sep = ' ')
power$Time <- strptime(power$Time, format = '%Y-%m-%d %H:%M:%S')

#replace all missing values with a blank and convert to numeric
power$Global_active_power <- as.numeric(gsub('?', '', power$Global_active_power))
power$Global_reactive_power <- as.numeric(gsub('?', '', power$Global_reactive_power))
power$Voltage <- as.numeric(gsub('?', '', power$Voltage))
power$Global_intensity <- as.numeric(gsub('?', '', power$Global_intensity))
power$Sub_metering_1 <- as.numeric(gsub('?', '', power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(gsub('?', '', power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(gsub('?', '', power$Sub_metering_3))

png("plot3.png", width = 480, height = 480)
plot(power$Time, power$Sub_metering_1, type = 'l', ylab= 'Energy Sub Metering', xlab = '')
lines(power$Time, power$Sub_metering_2, col = 'red')
lines(power$Time, power$Sub_metering_3, col = 'blue')
legend('topright',c('Sub_Metering_1','Sub_Metering_2','Sub_Metering_3'),col=c(1,2,4), lwd = 1)
dev.off()
