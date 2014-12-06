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


# Plot 4
# Lets do four plots together ####  Sub Plot 1 #########

png(filename="plot4.png", width=480, height=480, bg="white")

# Set the canvas for four plots by setting the mfrow parameter and the margins with the mar parameter
par(mfrow = c(2,2))
par(mar=c(4,4,1,1))

plot(my_records$Global_active_power, type="l", ylab="Global Active Power(Kilowatts)",xaxt="n",ylim=c(0,6), xlab="")

# add labels
mtext("Thu", side=1, adj=0)
mtext("Sat", side=1, adj=1)
mtext("Fri", side=1)

############# Sub Plot 2 #############

plot(my_records$Voltage, type="l",lwd = 1, xaxt="n", ylim=c(234, 246), ylab="Voltage", xlab="datetime")
mtext("Thu", side=1, adj=0)
mtext("Sat", side=1, adj=1)
mtext("Fri", side=1)

############# Sub Plot 3 #############
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

#############Sub Plot 4 #############
plot(my_records$Global_reactive_power, type="l",lwd = 1, xaxt="n", ylim=c(0, 0.5), ylab="Global_reactive_power", xlab="datetime")
mtext("Thu", side=1, adj=0)
mtext("Sat", side=1, adj=1)
mtext("Fri", side=1)

dev.off()