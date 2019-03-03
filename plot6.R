# Assume .zip file has already been unzipped into R working directory
# Read in data from .rds files

# PM25 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification codes
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr
library(dplyr)

# Create subset for Baltimore - fips = 24510
baltimore <- subset(NEI, fips == "24510")

# Create subset for Los Angeles - fips = 06037
losangeles <- subset(NEI, fips == "06037")

# Create subset of all vehicle-related SCC codes
vehicles <- grepl("*Vehicles", SCC$EI.Sector)
vehicles2 <- SCC[vehicles,]

# Create subsets of vehicle emissions in Baltimore and Los Angeles
baltimorevehicles <- baltimore[(baltimore$SCC %in% vehicles2$SCC), ]
losangelesvehicles <- losangeles[(losangeles$SCC %in% vehicles2$SCC), ]

# Create tables summarising total Baltimore and Los Angeles vehicle emissions by year
baltimorevehicles2 <- summarise(group_by(baltimorevehicles, year), Emissions=sum(Emissions))
losangelesvehicles2 <- summarise(group_by(losangelesvehicles, year), Emissions=sum(Emissions))

# Set up for a side-by-side comparison of plots for Baltimore and Los Angeles
par(mfrow = c(1,2), mar = c(4,4,2,1))

# Plot baltimorevehicles2 - nothing fancy, just exploratory
plot(baltimorevehicles2)
title(main = "Baltimore vehicle emissions")

# Plot losangelesvehicles2 - nothing fancy, just exploratory
plot(losangelesvehicles2)
title(main = "Los Angeles vehicle emissions")

# Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot6.png", width = 480, height = 480)
dev.off()

# Plot shows Baltimore vehicle emissions have decreased from 1999 to 2008, while Los Angeles vehicle emissions have increased from 1999 to 2008