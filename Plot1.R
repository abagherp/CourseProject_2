# removing all variables in R
rm(list = setdiff(ls(), lsf.str()))

# Setting the working directory
setwd("/Users/alibagherpour/Documents/LearnR/ExploratoryDataAnalysis/CourseProject_2")

# import data to R from folder "exdata-data-NEI_data"
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Calculate annual total emissions from PM2.5
NEI_annual_total_emmission <- aggregate(Emissions ~ year, data = NEI, sum)

png(filename = "plot1.png",
    width = 480, height = 480)
# Create plot1 
with(NEI_annual_total_emmission, plot(year, Emissions,pch=20,
                                      xlab="Year",
                                      ylab=expression(
                                              paste("Total ", PM[2.5], " emission")),
                                      xlim = c(1998,2008)))

# Add a title
title(main = expression(paste("Emissions from ", PM[2.5], 
                              " in the United States from 1999 to 2008"))) 
dev.off()

