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

##################################################################################################
# Plot 1 
# Read the global_active_power and draw a histogram.
gba<-my_records$Global_active_power

# Create a png file
png(filename="plot1.png", width=480, height=480, bg="white")
# Draw the histogram
hist(gba,col="red", main="Global Active Power", xlab ="Global Active Power(kilowatts)", ylab="Frequency",ylim=c(0,1200))
# close the output device (file)
dev.off()