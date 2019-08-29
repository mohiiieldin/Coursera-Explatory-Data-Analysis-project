setwd("E:/Coursera data science specialization/4. Explatory data analysis/week4/project2")
library(dplyr)
SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Codr
NEI <- readRDS("summarySCC_PM25.rds")  #National Emissions Inventory

#grepping the coal sources first :
index_coal <- grep("[cC]oal" , SCC$Short.Name ) 
SCC_coal <- SCC[index_coal,c("SCC","Short.Name")]
#then filtering it to coal combustion only as there coal non combustion related rows
index_coal_comb <- grep("[cC]omb" , SCC_coal$Short.Name)
NEI_coal_comb <- SCC[index_coal_comb,"SCC"]

total_emission_from_coal_combustion <- NEI %>% filter(SCC %in% NEI_coal_comb) %>% group_by(year) %>% summarise(sum(Emissions)) %>% as.data.frame()
years <- total_emission_from_coal_combustion[,1]
emissions <- total_emission_from_coal_combustion[,2]

line_colors <- c("steelblue","red","steelblue","steelblue")

png(filename = "plot4.png",
    width =600, height = 600, units = "px", pointsize = 12,
    res = 130,type ="cairo")

library(ggplot2)
ggplot(total_emission_from_coal_combustion , aes(years,emissions/100)) +
  geom_point(shape =19) +
  geom_line(size =1.1 , col =line_colors ) +
  ggtitle("total emission of coal combustion-related sources") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylab("emissions") +
  scale_x_discrete(limits = c(1999,2002,2005,2008))

dev.off()   
