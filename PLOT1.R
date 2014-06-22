
# pregunta 1

# crear un subdirectorio
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

SCC <- readRDS(file=paste0(filePath, fileName2))

# Convierte columna de años a un factor
NEI$year <- factor(NEI$year)

# Suma total de contaminacion 
total_pollution = tapply(NEI$Emissions, NEI$year, sum)

# grafico PNG
library(datasets)
png("plot1.png", width = 480, height = 480)
barplot(total_pollution, main ="Total United States PM2.5 Emissions", ylab = "PM2.5 in tons", col="red")
dev.off()