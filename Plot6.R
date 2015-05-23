# import data to R from folder "exdata-data-NEI_data"
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Index of vehicle related sources
index_SCC <- unique(grep("Vehicles", 
                          SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
# Subset of EI.sectors that are vehicle related
VehicleSources <- 
        SCC[SCC$EI.Sector %in% index_SCC,]["SCC"]

# Find total annual vehicle related emissions across US
NEI_annual_vehicle_emmission_in_Baltimore_LosAngeles <- 
        aggregate(Emissions ~ year+fips, 
                  data = subset
                  (NEI,SCC %in% VehicleSources$SCC & (fips == "24510" | fips == "06037")), sum)

# Add city name to data frame
NEI_annual_vehicle_emmission_in_Baltimore_LosAngeles$CityName <- 
        ifelse(NEI_annual_vehicle_emmission_in_Baltimore_LosAngeles$fips == "06037", 
       "Los Angeles", "Baltimore")

# # Create plot6 
png(filename = "plot6.png",
    width = 480, height = 480)
g <- ggplot(NEI_annual_vehicle_emmission_in_Baltimore_LosAngeles, 
            aes(year, Emissions))
g <- g + geom_point(aes(color = CityName)) +
        labs(title = "Emissions from vehicle related sources
             in Baltimore and Los Angeles") + 
        labs(x = "Year", y = "Vehicle related emissions (in Tons)")
print(g)
dev.off()

