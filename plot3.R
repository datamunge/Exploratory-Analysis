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


#Plot 3
#  Get the first plot and make sure it stays within the ylim specified. Use xpd=FALSE to make this happen.
png(filename="plot3.png", width=480, height=480, bg="white")
barplot(my_records$Sub_metering_1,lwd = 1, xpd=FALSE,ylim=c(0,30),ylab="Energy sub metering")

# Add the legend. For the --- line use the ASCII  character 95 for the pch variable
legend("topright",pch=95, col=c("black", "red", "blue"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot the next two plots with add= TRUE to add on to the first plot
 barplot(my_records$Sub_metering_2, add=TRUE,col="red", border=NA)
 barplot(my_records$Sub_metering_3, add=TRUE,col="blue",border=NA)
# Box it and label it
box()
mtext("Thu", side=1, adj=0)
mtext("Sat", side=1, adj=1)
mtext("Fri", side=1)
dev.off()
