# Pregunta 3:


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

Baltimore$year <- factor(Baltimore$year)
Baltimore$type <- factor(Baltimore$type)

# grafico PNG
library(datasets)
library(ggplot2)
png("plot3.png", width = 480, height = 480)

# Sum emissions using stat identity and create facets for each pollution source
#
qplot(year, Emissions, data=Baltimore, geom="bar", stat='identity', facets=type~., 
      main="Total PM2.5 Emissions in Baltimore City, MD", ylab="PM2.5 Emissions in tons")
dev.off()

# qplot(year, Emissions, data=Baltimore, geom="bar", stat='identity')           # ggplot2 version of Question 2