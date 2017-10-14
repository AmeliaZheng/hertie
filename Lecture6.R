# install.package("readr")

library(tidyverse)
library(readr)

url <- paste0("https://raw.githubusercontent.com/", "mhaber/HertieDataScience/master/", "slides/week6/data/")
pew <- read_csv(paste0(url,"pew.csv")) 
billboard <- read_csv(paste0(url,"billboard.csv")) 
weather <- read_tsv(paste0(url,"weather.txt"))

# Compute rate per 10,000
table1 %>% 
    dplyr::mutate(rate = cases / population * 10000)
#data(package = "tidyr")
# Compute cases per year
table1 %>% 
    dplyr::count(year, wt = cases)

# Exercise 1
cases <- table2 %>% 
    dplyr::filter(type == "cases") %>% 
    dplyr::pull(count)
country <- table2 %>% 
    dplyr::filter(type == "cases") %>% 
    dplyr::pull(country)
year <-  table2 %>% 
    dplyr::filter(type == "cases") %>% 
    dplyr::pull(year)
population <- table2 %>% 
    dplyr::filter(type = "population") %>% 
    dplyr::pull(count)
    

# gather() & spread()
pewTidy <- pew %>% 
    tidyr::gather(key = income, value = frequency, -religion)
table2 %>% 
    tidyr::spread(key = type, value = count)


# Billboard data
billboardTidy <- billboard %>% 
    tidyr::gather(key = week, value = rank, wk1:wk76, na.rm = TRUE)
billboardTidy2 <- billboardTidy %>% 
    dplyr::mutate(week = readr::parse_number(week), 
                  date = as.Date(date.entered) + 7 * (week - 1)) %>% 
    dplyr::select(-date.entered) %>% 
    dplyr::arrange(artist, track, week)


# seperate() & unite()
table3 %>% 
    tidyr::separate(rate, into = c("cases", "population"))
table3 %>% 
    tidyr::separate(rate, into = c("cases", "population"), sep = "/")
table3 %>% 
    tidyr::separate(year, into = c("century", "year"), sep = 2)
table5 %>% 
    tidyr::unite(new, century, year)
table5 %>% 
    tidyr::unite(new, century, year, sep = "")


# Missing value
stocks <- tibble( year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016), 
                  qtr = c( 1, 2, 3, 4, 2, 3, 4), 
                  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66) )
stocks %>% 
    tidyr::spread(year, return)
# use na.rm = T to turn explicit to implicit
stocks %>% 
    tidyr::spread(year, return) %>% 
    tidyr::gather(year, return, `2015`:`2016`, na.rm = T)
# use complete()) to turn implicit to explicit
stocks %>% 
    tidyr::complete(year, qtr)
# fill()
treatment <- tribble( 
    ~ person, ~ treatment, ~response, 
    "Derrick Whitmore", 1, 7, 
    NA, 2, 10, 
    NA, 3, 9, 
    "Katherine Burke", 1, 4 )
treatment %>% 
    tidyr::fill(person)
