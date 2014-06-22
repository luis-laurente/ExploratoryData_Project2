
# Pregunta 4:

if (!file.exists("data")) {
        dir.create("data")
}

# descargar documentos
filePath <- "./data/"
fileZipName <- "exdata-data-NEI_data.zip"
fileName1 <- "summarySCC_PM25.rds"
fileName2 <- "Source_Classification_Code.rds"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

ZipFile <- paste0(filePath, fileZipName)        # path to zipped data file
if (!file.exists(ZipFile)) {
        download.file(fileUrl, destfile = ZipFile, method ="curl")
        unzip(ZipFile, exdir=filePath)
        dateDownloaded <- date()
}

# PM2.5 
NEI <- readRDS(paste0(filePath, fileName1))   
# Source Classification Code Table:
SCC <- readRDS(file=paste0(filePath, fileName2))


containsCoal <- grep("*[Cc][Oo][Aa][Ll]",SCC$Short.Name)
subSCC <- SCC[containsCoal,c(1,2,3)]


library(plyr)
coaldata = join(NEI, subSCC, by="SCC", type = "inner")                                         

# Convierte columna de años a factor
coaldata$year <- factor(coaldata$year)

# suma total de contaminacion
total_pollution = tapply(coaldata$Emissions, coaldata$year, sum)

# grafico PNG
library(datasets)
png("plot4.png", width = 480, height = 480)
barplot(total_pollution, main ="Total United States PM2.5 Emissions from Coal", 
        ylab = "PM2.5 in tons", col="black")
dev.off()