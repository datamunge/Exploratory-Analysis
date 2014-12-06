########### Reading the data, converting to right data types (date, time) and subsetting it ##########################

#  Read the file, convert date column to type date and time to type time  ###
recs_read<-read.table("household_power_consumption.txt", na.string="?", header=TRUE, sep=";")

# Convert all values in date column to type date #
recs_read$Date<-as.Date(recs_read$Date,format = "%d/%m/%Y")

# Convert time values to type time #
recs_read$Time<-strptime(recs_read$Time,format = "%T")
recs_read$Time<-strftime(recs_read$Time,"%H:%M")

# subset to the required date range i.e. 02-01 - 02-02 #
my_records<-subset(recs_read,recs_read$Date >=as.Date("2007-02-01") & recs_read$Date <= as.Date("2007-02-02"))

#Plot  2 xaxt suppresses the automatic xlims, so we can add Thu, Fri, Sat

png(filename="plot2.png", width=480, height=480, bg="white")
plot(my_records$Global_active_power, type="l", ylab="Global Active Power(Kilowatts)",xaxt="n",ylim=c(0,6), xlab="")

# add labels
mtext("Thu", side=1, adj=0)
mtext("Sat", side=1, adj=1)
mtext("Fri", side=1)
dev.off()

