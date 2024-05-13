library(dplyr)

##read data into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##sum up the emissions by year
YearEmissions <- aggregate(NEI["Emissions"], by = NEI["year"],sum)

##plot the aggregates into a png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(YearEmissions, type = "b", main = "Total PM2.5 Emissions by Year in USA", xlab = "Year",
     ylab = "Emissions (tons)", pch = 19, lwd = 2, col = "blue")
dev.off()