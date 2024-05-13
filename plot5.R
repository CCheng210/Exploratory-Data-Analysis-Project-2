library(dplyr)
library(ggplot2)

##read data into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset NEI data from Baltimore
Baltimore <- subset(NEI, NEI$fips == "24510")

##merge SCC data into Baltimore data set using SCC columns
BaltimoreSCC <- merge(Baltimore, SCC)

##filter out motor vehicle data
vehicle <- BaltimoreSCC[grep("Vehicle", BaltimoreSCC$SCC.Level.Two),]

##aggregate emissions across years
yearlyemissions <- aggregate(vehicle["Emissions"],vehicle["year"],sum)

##plots data in png file
png(filename = "plot5.png")
plot(yearlyemissions, type = "b", main = "Yearly Vehicle Emissions in Baltimore", xlab  = "Year", 
     ylab = "Emissions (tons)", pch = 19, lwd = 2, col = "purple")
dev.off()
