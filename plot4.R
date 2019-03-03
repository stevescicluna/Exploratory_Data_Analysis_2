# Assume .zip file has already been unzipped into R working directory
# Read in data from .rds files

# PM25 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification codes
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr
library(dplyr)

# Create subset of all coal-related SCC codes
coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coal2 <- SCC[coal,]

# Create subset of coal emissions
coalemissions <- NEI[(NEI$SCC %in% coal2$SCC), ]

# Create table summarising total coal emissions by year
coalemissions2 <- summarise(group_by(coalemissions, year), Emissions=sum(Emissions))

# Plot coalemissions2 - nothing fancy, just exploratory
plot(coalemissions2)
title(main = "US coal emissions - 1999 - 2008")

# Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

# Plot shows coal emissions have decreased from 1999 to 2008