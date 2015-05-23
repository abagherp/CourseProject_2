# import data to R from folder "exdata-data-NEI_data"
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Index of vehicle related sources
index_SCC <- unique(grep("Vehicles", 
                          SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
VehicleSources <- 
        SCC[SCC$EI.Sector %in% index_SCC,]["SCC"]

# Find total annual vehicle related emissions across US
NEI_annual_vehicle_emmission_in_Baltimore <- 
        aggregate(Emissions ~ year+fips, 
                  data = subset
                  (NEI,SCC %in% VehicleSources$SCC & fips == "24510"), sum)


# # Create plot5 
png(filename = "plot5.png",
    width = 480, height = 480)
g <- ggplot(NEI_annual_vehicle_emmission_in_Baltimore, aes(year, Emissions))
g <- g + geom_point() + 
        labs(title = "Emissions from vehicle related sources in Baltimore City") + 
        labs(x = "Year", y = "Vehicle related emissions (in Tons)")
print(g)
dev.off()

