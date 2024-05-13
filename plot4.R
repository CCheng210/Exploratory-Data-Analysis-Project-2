library(dplyr)
library(ggplot2)

##read data into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##separate the SCC data related to coal combustion
coal <- SCC[grep("Coal",SCC$SCC.Level.Three),]
coal <- coal[-grep("Industrial Processes - Mining", coal$EI.Sector),]
coal <- coal[-grep("Industrial Processes - Oil & Gas Production", coal$EI.Sector),]

##merge NEI and coal based on SCC numbers
coalemissions <- merge(coal, NEI)

##aggregate emissions based on year
yearlyemissions <- aggregate(coalemissions["Emissions"], coalemissions["year"], sum )

##plots data in a png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
plot(yearlyemissions, type = "b", main = "Total PM2.5 Emissions By Coal Combustion in USA", xlab = "Year",
     ylab = "Emissions (tons)", pch = 19, lwd = 2, col = "green")
dev.off()