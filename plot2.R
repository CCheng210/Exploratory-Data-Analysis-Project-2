library(dplyr)

##read data into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subsets Baltimore data by fips number
Baltimore <- subset(NEI, NEI$fips == "24510")

##aggregates the data by year
BaltYearEmissions <- aggregate(Baltimore["Emissions"], by = Baltimore["year"],sum)

##plots data in a png file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(BaltYearEmissions, type = "b", main = "Total PM2.5 Emissions by Year in Baltimore", xlab = "Year",
     ylab = "Emissions (tons)", pch = 19, lwd = 2, col = "red")
dev.off()