# import data to R from folder "exdata-data-NEI_data"
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Index of coal related sources
CoalCombustionSources <- 
        SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal",]["SCC"]

# Find total annual coal related emissions across US
NEI_annual_total_emmission <- 
        aggregate(Emissions ~ year, 
                  data = subset(NEI,SCC %in% CoalCombustionSources$SCC), sum)

# Create plot4 
png(filename = "plot4.png",
    width = 480, height = 480)
g <- ggplot(NEI_annual_total_emmission, aes(year, Emissions))
g + geom_point() + 
        labs(title = "Emissions from coal combustion-related sources across US") + 
        labs(x = "Year", y = "Coal combustion-related emissions (Tons)")
dev.off()

