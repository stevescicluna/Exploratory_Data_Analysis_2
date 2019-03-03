# Assume .zip file has already been unzipped into R working directory
# Read in data from .rds files

# PM25 data
NEI <- readRDS("summarySCC_PM25.rds")

# Classification codes
SCC <- readRDS("Source_Classification_Code.rds")

# Load dplyr
library(dplyr)

# Load ggplot2
library(ggplot2)

# Create subset for Baltimore - fips = 24510
baltimore <- subset(NEI, fips == "24510")

# Summarise Baltimore emissions by type and year
baltimore2<-summarise(group_by(filter(baltimore), year,type), Emissions = sum(Emissions))

# Use ggplot2 to summarise Baltimore emissions by type by year - nothing fancy, just exploratory
qplot(year, Emissions, data = baltimore2, facets = . ~ type) + labs(title = "Baltimore emissions by type and year")


# Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

# Plot shows "point" emissions increased between 1999 and 2008