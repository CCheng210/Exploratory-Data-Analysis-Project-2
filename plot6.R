library(dplyr)
library(ggplot2)

##read data into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset NEI data from Baltimore and LA
Baltimore <- subset(NEI, NEI$fips == "24510")
LA <- subset(NEI, NEI$fips == "06037")

##merge SCC data into Baltimore and LA data set using SCC columns
BaltimoreSCC <- merge(Baltimore, SCC)
LASCC <- merge(LA, SCC)

##filter out motor vehicle data
vehicleBalt <- BaltimoreSCC[grep("Vehicle", BaltimoreSCC$SCC.Level.Two),]
vehicleLA <- LASCC[grep("Vehicle", LASCC$SCC.Level.Two),]

##aggregate emissions across years
yearlyemissionsBalt <- aggregate(vehicleBalt["Emissions"],vehicleBalt["year"],sum)
yearlyemissionsLA <- aggregate(vehicleLA["Emissions"], vehicleLA["year"],sum)

##plot the plots
png(filename = "plot6.png", width = 960, units = "px")

par(mfrow= c(1, 2))
plot(yearlyemissionsBalt, type = "b", main = "Yearly Vehicle Emissions in Baltimore", xlab  = "Year", 
     ylab = "Emissions (tons)", ylim=c(100, 7400),pch = 19, lwd = 2, col = "purple")
plot(yearlyemissionsLA,type = "b", main = "Yearly Vehicle Emissions in LA", xlab = "Year", 
     ylab = "Emissions (tons)", ylim=c(100, 7400) , pch = 19, lwd = 2, col = "forestgreen")

dev.off()