if (!file.exists("household_power_consumption.txt")) { 
	unzip('exdata_data_household_power_consumption.zip')
}

powerconsumption <- tbl_df(read.table('household_power_consumption.txt',header = T, sep =';'))
powerconsumption1<- powerconsumption %>% 
	mutate(Date = dmy(Date),Time = hms(Time)) %>%
	select(1:2)
powerconsumption2<-tbl_df(sapply(powerconsumption[,3:9],as.numeric))
powerconsumption <- bind_cols(powerconsumption1,powerconsumption2) %>%
	filter(Date==dmy('01-02-2007')|Date==dmy('02-02-2007'))

png('plot1.png', width = 480, height = 480, units = "px")
with(powerconsumption,hist(Global_active_power,col='red', xaxp = c(0,6,3), yaxp = c(0,1200,6),main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)'))
dev.off()