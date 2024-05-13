library(dplyr)
library(ggplot2)

##read data into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subsets Baltimore data by fips number
Baltimore <- subset(NEI, NEI$fips == "24510")

##subset data by the type variable
point_data <- subset(Baltimore, Baltimore$type == "POINT")
nonpoint_data <- subset(Baltimore, Baltimore$type == "NONPOINT")
onroad_data <- subset(Baltimore, Baltimore$type == "ON-ROAD")
nonroad_data <- subset(Baltimore, Baltimore$type == "NON-ROAD")

##sum up the emissions per year in each type
point_year <- cbind(aggregate(point_data["Emissions"], by = point_data["year"], sum),type = "POINT")
nonpoint_year <- cbind(aggregate(nonpoint_data["Emissions"], by = nonpoint_data["year"], sum), type = "NONPOINT")
onroad_year <- cbind(aggregate(onroad_data["Emissions"], by = onroad_data["year"],sum), type = "ON-ROAD")
nonroad_year <- cbind(aggregate(nonroad_data["Emissions"], by = nonroad_data["year"], sum), type = "NON-ROAD")

##collate the year data
yeardata <- rbind(point_year, nonpoint_year, onroad_year, nonroad_year)

##plot the data using ggplot2

plot3 <- ggplot(data = yeardata, aes(x = year, y = Emissions, color = type))+
            geom_line() +
            labs(title = "Baltimore PM2.5 Polution Types by Year", x = "Year", y = "Emissions (tons)") 

##print the plot to a png file
png(filename = "plot3.png")
print(plot3)
dev.off()      
