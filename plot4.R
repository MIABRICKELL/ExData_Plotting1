plot4<-function()
{
        
        ##Calling this function will download household consumption data from an Electric Power consumption dataset
        ##load the data for Feb. 1, 2007 and Feb 2, 2007 and create four different plots over the span of each day.
        ##and save it to a PNG file: Global Active Power, Voltage, Energy sub meterings, and global reactive power
        
        
        ##if the file does not exist then download and unzip it
        if(!file.exists("household_power_consumption.txt")){
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_household_power_consumption-1.zip")
                unzip("exdata_household_power_consumption-1.zip")
        }
        
        ##this will install the sqldf package only if not already installed
        if(!require("sqldf"))
        {
                install.packages("sqldf")
                library(sqldf)
        }    
        
        ##use the sqldf function to load just the data for (Feb 1, 2007 and Feb 2, 2007)
        
        ##create a connection to the file
        fi<-file("household_power_consumption.txt")
        
        ##filter and load the data
        plotdata<-read.csv.sql(sql="select * from fi where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")
        
        ##close the file connection
        close(fi)
        
        ##convert date to date/time
        plotdata$Date <- strptime(paste(plotdata$Date,plotdata$Time), "%d/%m/%Y %H:%M:%S")
        
        ##open a png file device
        png(file = "plot4.png", width=480, height=480, units="px", type="cairo")
        
        ##set the plot to be 2 Rows and 2 Columns
        par(mfrow = c(2, 2))
        
        ##create each plot
        with(plotdata, {
                #create Global Active Power Plot
                plot(Date, Global_active_power, type = "l", xlab="", ylab="Global Active Power")
                #create voltage plot
                plot(Date, Voltage, xlab="datetime", type = "l", ylab="Voltage")
                #create Energy sub metering plot
                plot(Date, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
                lines(Date,Sub_metering_2, col="red")
                lines(Date,Sub_metering_3, col="blue")
                legend("topright", pch=-1, lty=1, col = c("black", "blue", "red"), 
                        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=.95)
                #create Global Reactive power plot
                plot(Date, Global_reactive_power, type="l", xlab="datetime", lwd=.7)
        })
        
        ##Close the PNG device
        dev.off()
}