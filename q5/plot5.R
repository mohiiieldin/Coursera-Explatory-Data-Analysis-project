setwd("E:/Coursera data science specialization/4. Explatory data analysis/week4/project2")
library(dplyr)
SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Codr
NEI <- readRDS("summarySCC_PM25.rds")  #National Emissions Inventory

#any on-road vehicles is included 
Baltimore_total_emission_motor_vehicles <- NEI %>% filter(fips=="24510" & type == "ON-ROAD") %>% group_by(year) %>% summarise(sum(Emissions)) %>% as.data.frame()
years <- Baltimore_total_emission_motor_vehicles[,1]
emissions <- Baltimore_total_emission_motor_vehicles[,2]
png(filename = "plot5.png", width = 700, height = 600, res = 150, type = "cairo")
ggplot(Baltimore_total_emission_motor_vehicles , aes(years,emissions,fill = years,label = round( emissions,2))) +
  geom_bar(stat = "identity") +
  ggtitle("Baltimore total emission from motor vehicles") +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill = years),colour = "white" , fontface = "bold") +
  scale_x_discrete(limits = c(1999,2002,2005,2008) )
  
dev.off()   
