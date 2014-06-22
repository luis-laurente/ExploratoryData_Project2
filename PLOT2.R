# Pregunta 2
# 
if (!file.exists("data")) {
        dir.create("data")
}

# descarga documentos
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

# datos Baltimore 
Baltimore <- subset(NEI, fips == "24510")

# Convierte columnas en factor
Baltimore$year <- factor(Baltimore$year)

# suma total de contaminacion 
total_pollution = tapply(Baltimore$Emissions, Baltimore$year, sum)

# grafico PNG
library(datasets)
png("plot2.png", width = 480, height = 480)
barplot(total_pollution, main ="Total PM2.5 Emission in Baltimore City, MD", ylab = "PM2.5 in tons", col="blue")
dev.off()