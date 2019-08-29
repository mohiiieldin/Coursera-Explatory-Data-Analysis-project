setwd("E:/Coursera data science specialization/4. Explatory data analysis/week4/project2")

SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Codr
NEI <- readRDS("summarySCC_PM25.rds")  #National Emissions Inventory

library(dplyr)
Baltimore <- NEI %>% filter(fips=="24510") %>% group_by(year) %>% summarise( sum(Emissions) ) %>% as.data.frame()
years <- Baltimore[,1]
emissions <- Baltimore[,2]

png(filename = "plot2.png" , width = 600, height = 600, res = 130, type = "cairo")
plot(years , emissions , main = " Baltimore City emissions across the years" , xlab = "years" , ylab = "Emissions",type = "b" , pch = 19)
#yes it decreased although there was a spike increse in 2005 but it decreased again in 2008 
dev.off()