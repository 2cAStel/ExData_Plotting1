if (!file.exists("household_power_consumption.txt")) { 
	unzip('exdata_data_household_power_consumption.zip')
}

powerconsumption <- tbl_df(read.table('household_power_consumption.txt',header = T, sep =';'))
powerconsumption1<- powerconsumption %>% 
	mutate(Date = dmy(Date),Time = hms(Time)) %>%
	select(1:2)
powerconsumption2<-tbl_df(sapply(powerconsumption[,3:9],as.numeric))

powerconsumption <- bind_cols(powerconsumption1,powerconsumption2) %>%
	filter(Date==dmy('01-02-2007')|Date==dmy('02-02-2007')) %>% 
	mutate(completedate = Date+Time)

png('plot3.png', width = 480, height = 480, units = "px")
with(powerconsumption,{
	plot(completedate, Sub_metering_1, type = 'l', ylab='Energy sub metering', xlab='') 
	lines(completedate, Sub_metering_2, col='red') 
	lines(completedate, Sub_metering_3, col='blue')
	legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty = c(1,1,1))
})
dev.off()