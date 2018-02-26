# Load the data
NEI <- readRDS("c:/2018/ejemplos/pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("c:/2018/ejemplos/pm2.5/Source_Classification_Code.rds")

head(NEI)
head(SCC)

# Find index where text "Mobile Sources" appears in the SCC dataframe
indexes <- grepl("Mobile Sources", SCC$SCC.Level.One)

# Pick up the SCC values where text "Mobile Sources" appears
SCC_values <- SCC$SCC[indexes]
SCC_values <- strsplit(as.character(SCC_values), " \\(")

# Select rows where PM2.5 source is Mobile Sources and this come from Baltimore and California
Vehicle_emission <- NEI[is.element(NEI$SCC, SCC_values),]
Vehicle_emission_Baltimore <- subset(Vehicle_emission, fips == "24510")
Vehicle_emission_California <- subset(Vehicle_emission, fips == "06037")

# We compute the total emission by year where PM2.5 source is MObile Sources
Vehicle_emission_by_year_Baltimore <- aggregate(Vehicle_emission_Baltimore$Emissions, by = list(year=Vehicle_emission_Baltimore$year), FUN = sum)
Vehicle_emission_by_year_California <- aggregate(Vehicle_emission_California$Emissions, by = list(year=Vehicle_emission_California$year), FUN = sum)


Sys.setlocale(category = "LC_ALL", locale = "english")
plot(Vehicle_emission_by_year_Baltimore$year, Vehicle_emission_by_year_Baltimore$x, xlab = "Year", ylab = "Vehicle PM2.5 Emissions", pch = 20, ylim = c(500, 20000))
points(Vehicle_emission_by_year_California$year, Vehicle_emission_by_year_California$x, xlab = "Year", ylab = "Vehicle PM2.5 Emissions", pch = 24)
dev.copy(png, file = "plot6.png")
dev.off()
