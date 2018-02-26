
# Load the data
NEI <- readRDS("c:/2018/ejemplos/pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("c:/2018/ejemplos/pm2.5/Source_Classification_Code.rds")

head(NEI)
head(SCC)

# We compute the total emission by year
Total_emission_by_year <- aggregate(NEI$Emissions, by = list(year=NEI$year), FUN = sum)

Sys.setlocale(category = "LC_ALL", locale = "english")
plot(Total_emission_by_year$year, Total_emission_by_year$x, xlab = "Year", ylab = "Total PM2.5 Emissions", pch = 20)
dev.copy(png, file = "plot1.png")
dev.off()
