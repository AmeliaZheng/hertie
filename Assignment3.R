library(tidyverse)
library(nycflights13)

flights %>%
    filter(dep_delay > 0) %>% 
    group_by(carrier, distance) %>%
    summarise(avg_carrier = mean(dep_delay, na.rm = T)) %>% 
    arrange(avg_carrier)
# Correct
flights %>% 
    group_by(carrier) %>%
    summarise(ave_dep_delay = mean(dep_delay),
              ave_dist = mean(distance)) %>%
    mutate(result = ave_dep_delay / ave_dist, na.rm = T) %>% 
    arrange(result, carrier)

flights %>% 
    filter(year == 2013, month == 9, day == 18) %>% 
    arrange(dep_time)

flights %>% 
    filter(month == 9) %>% 
    group_by(origin) %>% 
    summarise(avg_dep_delay = mean(dep_delay, na.rm = T)) %>% 
    arrange(desc(avg_dep_delay))

flights %>% 
    filter(carrier == "UA") %>% 
    summarise(avg_dep_delay = mean(dep_delay, na.rm = T))

flights %>% 
    filter(month == 9, dep_time < 500)

flights %>% 
    filter(dep_delay >= 60, dep_delay-arr_delay > 45)

flights %>%
    group_by(tailnum) %>%
    summarise(prop_on_time = sum(arr_delay <= 30 & !is.na(arr_delay))/n(),
              mean_arr_delay = mean(arr_delay, na.rm=TRUE),
              flights = n()) %>%
    arrange(desc(mean_arr_delay))

flights %>% 
    filter(dep_delay > 120) %>% 
    group_by(origin) %>% 
    summarise(n())

flights %>% 
    group_by(dest) %>% 
    summarise(dest_carrier = n_distinct(carrier)) %>% 
    arrange(desc(dest_carrier))

flights %>% 
    group_by(dest) %>% 
    summarise(sd_dist = sd(distance)) %>% 
    arrange(desc(sd_dist))