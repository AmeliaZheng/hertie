library(tidyverse)
library(readxl)
library(DBI)
library(RMySQL) #This need to be installed
library(httr)
library(jsonlite)
library(haven)

# read.table(): not recommended
potatoes <- read.csv(file = "data/potatoes.csv",
                     sep = ",", header = TRUE)

# readr functions
potatoes <- read_csv("data/potatoes.csv")
    # use skip = n to skip first n lines
    # use comment = "#" to drop all lines that start with #
    # use col_names = FALSE to not treat the first row as heading
    # use col_names = c("x", "y", "z"))
properties <- c("area", "temp", "size", "storage", 
                "method", "texture", "flavor", "moistness")
potatoes <- read_delim("data/potatoes.txt", delim = "\t", 
                       col_names = properties)
potatoes <- read_tsv("data/potatoes.txt",
                     col_types = "cccccccd",
                     col_names = properties)

# readxl() function
excel_sheets(path = "data/urbanpop.xlsx")
pop1 <- read_excel("data/urbanpop.xlsx", sheet = 1)
pop2 <- read_excel("data/urbanpop.xlsx", sheet = 2)
pop3 <- read_excel("data/urbanpop.xlsx", sheet = 3)
# alternatively
pop <- lapply(excel_sheets(path = "data/urbanpop.xlsx"),
              read_excel, path = "data/urbanpop.xlsx")

# import data from databases
host <- "courses.csrrinzqubik.us-east-1.rds.amazonaws.com"
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = host,
                 port = 3306,
                 user = "student",
                 password = "datacamp") # get connection
tables <- dbListTables(con)
users <- dbReadTable(con, "users")
# Alternatively, lapply
tableNames <- dbListTables(con)
tables <- lapply(tableNames, dbReadTable, conn = con)

# Exercise 2
filter(tables[[1]], message == "awesome! thanks!")
filter(tables[[2]], id == "87")
filter(tables[[3]], id == "5")

# Importing data from the web
url <- paste0("https://raw.githubusercontent.com/", 
              "mhaber/HertieDataScience/master/", 
              "slides/week5/data/potatoes.csv")
potatoes <- read_csv(url)
# Download files
url <- paste0("https://raw.githubusercontent.com/", 
              "mhaber/HertieDataScience/master/", 
              "slides/week5/data/potatoes.csv")
download.file(url, "data/urbanpop.xlsx", mode = "wb")
urbanpop <- read_excel("data/urbanpop.xlsx")

# httr()
url <- "http://www.example.com/"
resp <- GET(url)
content <- content(resp, as = "raw")
head(content)

# jsonlite
url <- paste0("http://mysafeinfo.com/api/", 
              "data?list=englishmonarchs&format=json")
jsonData <- fromJSON(url)
str(jsonData)
# Convert back to JSON
myJson <- toJSON(iris)
iris2 <- fromJSON(myJson)
head(iris2)


# Importing data from other statistical software
# read_sas()
sales <- read_sas("data/sales.sas7bdat")
str(sales)
# read_dta()
sugar <- read_dta("data/sugar.dta")
sugar$Date <- as.Date(as_factor(sugar$Date))
# read_sav()
personality <- read_sav("data/personality.sav")