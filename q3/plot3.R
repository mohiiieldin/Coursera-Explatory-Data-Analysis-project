setwd("E:/Coursera data science specialization/4. Explatory data analysis/week4/project2")
library(dplyr)
SCC <- readRDS("Source_Classification_Code.rds") #Source Classification Codr
NEI <- readRDS("summarySCC_PM25.rds")  #National Emissions Inventory


#24510 is the code of baltimore city and i splited the data by the type and then by year 
Baltimore <- NEI %>% filter(fips=="24510") %>% group_by(type, year) %>% summarise( sum(Emissions) ) %>% as.data.frame()
#years and emissions will be the axis of the plots
years <- Baltimore[,2] 
emissions <- Baltimore[,3]

png(filename = "plot3.png",width = 700, height = 700, res = 150, type = "cairo")
library(ggplot2)
ggplot(Baltimore , aes(years,emissions)) + 
 geom_point() +
 geom_smooth(method = "lm" , se=FALSE , aes(col = ifelse(Baltimore$type == "POINT",T,F )),show.legend = FALSE) + #the ifelse test to make the point linear line in red 
 facet_wrap(.~ Baltimore$type) +
 scale_color_manual(values = c("green" , "red")) + #if point make it red and green if else
 ggtitle("emission across years splited by source type" ) +
 theme( plot.title = element_text(hjust = 0.5) )  + #adjusting the title to the middle
 scale_x_discrete(limits = c(1999,2002,2005,2008))  #setting the labels manually to fit the exact year
 
dev.off()