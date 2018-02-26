# Load the data
NEI <- readRDS("c:/2018/ejemplos/pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("c:/2018/ejemplos/pm2.5/Source_Classification_Code.rds")

head(NEI)
head(SCC)

# Find index where text "Coal" appears in the SCC dataframe
indexes <- grepl("Mobile Sources", SCC$SCC.Level.One)

# Pick up the SCC values where text "Coal" appears
SCC_values <- SCC$SCC[indexes]
SCC_values <- strsplit(as.character(SCC_values), " \\(")

# Select rows where PM2.5 source is coal
Vehicle_emission <- NEI[is.element(NEI$SCC, SCC_values),]
Vehicle_emission_Baltimore <- subset(Vehicle_emission, fips == "24510")

# We compute the total emission by year where PM2.5 source is coal
Vehicle_emission_by_year_Baltimore <- aggregate(Vehicle_emission_Baltimore$Emissions, by = list(year=Vehicle_emission_Baltimore$year), FUN = sum)


Sys.setlocale(category = "LC_ALL", locale = "english")
plot(Vehicle_emission_by_year_Baltimore$year, Vehicle_emission_by_year_Baltimore$x, xlab = "Year", ylab = "Vehicle PM2.5 Emissions in Baltimore", pch = 20)
dev.copy(png, file = "plot5.png")
dev.off()
