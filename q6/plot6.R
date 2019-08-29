setwd("E:/Coursera data science specialization/4. Explatory data analysis/week4/project2")
library(dplyr)
SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Codr
NEI <- readRDS("summarySCC_PM25.rds")  #National Emissions Inventory

#any on-road vehicles is included for both cities baltimore and los angelos
total_emission_motor_vehicles <- NEI %>% filter( (fips=="24510" | fips=="06037") & type == "ON-ROAD") %>% group_by(fips,year) %>% summarise(sum(Emissions)) %>% as.data.frame()

years <- total_emission_motor_vehicles[,2]
emissions <- total_emission_motor_vehicles[,3]
png(filename = "plot6.png", width = 700, height = 600, res = 150, type = "cairo")
ggplot(total_emission_motor_vehicles , aes(years,emissions)) +
  geom_point(shape =19) +
  geom_smooth(method = "lm" , se = FALSE) +
  facet_wrap(. ~ total_emission_motor_vehicles$fips) +
  ggtitle("Baltimore total emission from motor vehicles") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_discrete(limits = c(1999,2002,2005,2008))

dev.off()   
