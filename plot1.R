plot1<-function()
{
        ##Calling this function will download household consumption data from an Electric Power consumption dataset
        ##load the data for Feb. 1, 2007 and Feb 2, 2007 and create a histogram of Global Active Power in kilowatts
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
        
        ##open a png file device
        png(file = "plot1.png", width=480, height=480, units="px")
        
        ##createa histogram with red bars of the global active power in kilowatts
        hist(plotdata$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
        
        ##close the PNG device
        dev.off()
}