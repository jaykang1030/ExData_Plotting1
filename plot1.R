file_name <- "household_power_consumption.txt"
url       <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file  <- "data.zip"

# Check if the data is downloaded and download when applicable
if (!file.exists("household_power_consumption.txt")) {
    download.file(url, destfile = zip_file)
    unzip(zip_file)
    file.remove(zip_file)
}

# load SQL query library
if (!"sqldf" %in% rownames(installed.packages())){
    install.packages("sqldf")
}
library(sqldf)
# open connections to data file
fi <- file(file_name)
# select sepecific date
df <- sqldf("select * from fi where Date == '1/2/2007' or Date == '2/2/2007'",
            file.format = list(header = TRUE, sep = ";"))
close(fi)

# create png file with specific width and height
png(file = "plot1.png", width = 480, height = 480, units = "px")
# create histogram
hist(df$Global_active_power,col = "red",
     xlab = "Global Active Power (kilowats)",
     ylab = "Frequency",
     main = "Global Active Power")
dev.off()  # Close the png file device