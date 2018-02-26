
# Load the data
NEI <- readRDS("c:/2018/ejemplos/pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("c:/2018/ejemplos/pm2.5/Source_Classification_Code.rds")

head(NEI)
head(SCC)

Total_emission_Baltimore <- subset(NEI, fips == "24510")
Total_emission_by_year_Baltimore <- aggregate(Total_emission_Baltimore$Emissions, by = list(year=Total_emission_Baltimore$year), FUN = sum)

Sys.setlocale(category = "LC_ALL", locale = "english")
plot(Total_emission_by_year_Baltimore$year, Total_emission_by_year_Baltimore$x, xlab = "Year", ylab = "Total PM2.5 Emissions Baltimore", pch = 20)
dev.copy(png, file = "plot1.png")
dev.off()
