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

# Create subset of all vehicle-related SCC codes
vehicles <- grepl("*Vehicles", SCC$EI.Sector)
vehicles2 <- SCC[vehicles,]

# Create subset of vehicle emissions in Baltimore
baltimorevehicles <- baltimore[(baltimore$SCC %in% vehicles2$SCC), ]

# Create table summarising total Baltimore vehicle emissions by year
baltimorevehicles2 <- summarise(group_by(baltimorevehicles, year), Emissions=sum(Emissions))

# Plot baltimorevehicles2 - nothing fancy, just exploratory
plot(baltimorevehicles2)
title(main = "Baltimore vehicle emissions - 1999 - 2008")

# Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot5.png", width = 480, height = 480)
dev.off()

# Plot shows Baltimore vehicle emissions have decreased from 1999 to 2008