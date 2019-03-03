# Assume .zip file has already been unzipped into R working directory
# Read in data from .rds files

# PM25 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification codes
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr
library(dplyr)

# Create table of total emissions for each year
yeartotal <- summarise(group_by(NEI, year), sum(Emissions))

# Plot yeartotal - nothing fancy, just exploratory
plot(yeartotal)
title(main = "US emissions - 1999 - 2008")

# Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

# Plot shows total emissions decreased from 1999 to 2008