setwd("E:/Coursera data science specialization/4. Explatory data analysis/week4/project2")
SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Codr
NEI <- readRDS("summarySCC_PM25.rds")  #National Emissions Inventory

library(dplyr)
total_emmision_per_year <- NEI %>% group_by(year) %>% summarise(total_emmision_per_year = sum(Emissions)) %>% as.data.frame()

png( file = "plot1_base_plot.png" , width = 600 , height = 600,res = 140 ,type = "cairo") 
plot(total_emmision_per_year[,1], (total_emmision_per_year[,2])/1000 , type = "b" , pch =19 , xlab = "Years" , ylab = "Emmision" , main = "Emissions across years")
dev.off()



#just making a barplot for fun :
cols <- c("red","orangered","steelblue","green")
png( file = "plot1_barplot.png" , width = 600 , height = 600,res = 140 ,type = "cairo") 
barplot(height = total_emmision_per_year[,2]/1000 ,
        names.arg = total_emmision_per_year[,1] ,
        xlab = "Years" , ylab = "Emmision" ,
        main = "Emissions across years in US",
        ylim = c(0,8000),
        col = cols
        )

dev.off()