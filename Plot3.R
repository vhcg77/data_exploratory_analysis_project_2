# Load the data
NEI <- readRDS("c:/2018/ejemplos/pm2.5/summarySCC_PM25.rds")
SCC <- readRDS("c:/2018/ejemplos/pm2.5/Source_Classification_Code.rds")

head(NEI)
head(SCC)

# Find index where text "Coal" appears in the SCC dataframe
indexes <- grepl("Coal", SCC$EI.Sector)

# Pick up the SCC values where text "Coal" appears
SCC_values <- SCC$SCC[indexes]
SCC_values <- strsplit(as.character(SCC_values), " \\(")

# Select rows where PM2.5 source is coal
Coal_emission <- NEI[is.element(NEI$SCC, SCC_values),]

# We compute the total emission by year where PM2.5 source is coal
Coal_emission_by_year <- aggregate(Coal_emission$Emissions, by = list(year=Coal_emission$year), FUN = sum)


Sys.setlocale(category = "LC_ALL", locale = "english")
plot(Coal_emission_by_year$year, Coal_emission_by_year$x, xlab = "Year", ylab = "Coal PM2.5 Emissions", pch = 20)
dev.copy(png, file = "plot3.png")
dev.off()
