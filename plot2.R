plot2<-function()
{
        
        ##Calling this function will download household consumption data from an Electric Power consumption dataset
        ##load the data for Feb. 1, 2007 and Feb 2, 2007 and plot the Global Active Power in kilowatts with lines for each day
        ##and save it to a PNG file
        
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
        png(file = "plot2.png", width=480, height=480, units="px")
        
        plot(plotdata$Date, plotdata$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
        
        ##Close the PNG device
        dev.off()
}