
# Peer Assessment #2 
# NOAA Storm Data Project

suppressPackageStartupMessages(library(dplyr))
source("../src/toNumeric.R")

repdata.data.StormData <- read.csv("../data/repdata-data-stormData.csv",stringsAsFactors=FALSE)
propertyDamage <- mapply(toNumeric, repdata.data.StormData$PROPDMG, repdata.data.StormData$PROPDMGEXP)
stormData <- bind_cols(repdata.data.StormData, data.frame(propertyDamage=propertyDamage))
economicData <- filter(stormData, propertyDamage > 0)
top5ByState <- top_n(economicData, 5, STATE)
eventTypes <- unique(top5ByState$EVTYPE)
summary <- group_by(top5ByState, EVTYPE) %>% summarize(totalPropDamage=n()*mean(propertyDamage))
sortedSummary <- arrange(summary, desc(totalPropDamage))
png(filename="../graphs/plot1.png", width=480, height=360)
par(xaxt="n", mar=c(5,4,1,1))
plot(1:length(sortedSummary$EVTYPE), log10(sortedSummary$totalPropDamage), type="h", xlab="", ylab="log10(Property Damage)",axes=FALSE, mar=c(10,4,1,1), cex.axis=0.5)
axis(side=1, at=1:length(sortedSummary$EVTYPE))
text(1:length(sortedSummary$EVTYPE), par("usr")[3] - 0.2, offset=0, labels = sortedSummary$EVTYPE, srt = 45, pos = 2, xpd = TRUE, adj=0, cex=0.5)
axis(side=2, at=seq(0, 10, by=2), las=2)
dev.off()

