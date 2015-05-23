# import data to R from folder "exdata-data-NEI_data"
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Calculate annual total emissions from PM2.5
NEI_annual_total_emmission <- 
        aggregate(Emissions ~ year + type, data = subset(NEI,fips == "24510"), 
                  sum)

# Create plot3 
png(filename = "plot3.png",
    width = 480, height = 480)
g <- ggplot(NEI_annual_total_emmission, aes(year, Emissions))
g + geom_point(aes(color = type),size = 4, alpha = 1/2) + 
        labs(title = "Total emissions by type in Baltimore City") + 
        labs(x = "Year", y = "Total emissions")
dev.off()

