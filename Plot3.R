library(ggplot2)

# Load the data
NEI <- readRDS("c:/2018/ejemplos/pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("c:/2018/ejemplos/pm2.5/Source_Classification_Code.rds")

head(NEI)
head(SCC)

Total_emission_Baltimore <- subset(NEI, fips == "24510")
Emission_by_type_Baltimore <- aggregate(Total_emission_Baltimore$Emissions, by = list(type=Total_emission_Baltimore$type, year=Total_emission_Baltimore$year), FUN = sum)

Sys.setlocale(category = "LC_ALL", locale = "english")
qplot(year, x, data=Emission_by_type_Baltimore, color=type, geom=c("line"), xlab = "year", ylab = "Total PM2.5 Baltimore")
dev.copy(png, file = "plot3.png")
dev.off()

