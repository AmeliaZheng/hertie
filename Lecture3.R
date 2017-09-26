library(tidyverse)
library(nycflights13)

# filter()
filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
filter(flights, month == 11 | 12) #filter(flights, month %>% c(11, 12))

filter(flights, between(dep_time, 0, 600))
filter(flights, month %in% c(11, 12))
# x %in% y, will select every row every where x is part of the values of y

# filter() by default excludes FALSE and NA values
df <- tibble(x = c(1, NA, 3))
filter(df, x>1)
filter(df, is.na(x) | x > 1) #preserve missing value

# filter() Exercises
flights %>% filter(arr_delay >180)
flights %>% filter(!is.na(dep_delay), dep_delay <= 0, arr_delay > 180)
flights %>% filter(dest %in% c("IAH", "HOU"))
flights %>% filter(carrier %in% c("AA", "DL", "UA"))
flights %>% filter(between(month, 7, 9))


# arrange() -- select rows in a ascending order
# Use desc() to re=order in a descending order
arrange(flights, desc(arr_delay))

# arrange() Exercises
flights %>% arrange(dep_delay)
flights %>% arrange(desc(arr_delay))
flights %>% arrange(desc(distance))


# select() Exercises
# 3 distinct ways to select dep_time, dep_delay, arr_time, arr_delay
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep_"), starts_with("arr_"))
select(flights, matches("^(dep|arr)_(time|delay)$"))
# what does the one_of() function do?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, one_of(vars))


# mutate()
flights %>% 
    select(ends_with("delay"), distance, air_time) %>% 
    mutate(gain = arr_delay - dep_delay, 
           speed = distance / air_time *60)
# transmute() only to keep the new variables
transmute(flights, 
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / 60)

# mutate() Exercise
# new variable for dep_time and sched_dep_time
flights %>% 
    mutate(dep_time2 = dep_time %/% 100 * 60 + dep_time %% 100,
           sched_dep_time2 = sched_dep_time %/% 100 * 60 + sched_dep_time %% 100) %>% 
    select(dep_time, dep_time2, sched_dep_time, sched_dep_time2)
# arr_time and dep_time may be in different time zones
flights %>% 
    mutate(air_time2 = arr_time - dep_time, 
           air_time_diff = air_time2 - air_time) %>% 
    filter(air_time_diff != 0) %>% 
    select(air_time, air_time2, dep_time, arr_time, dest)
# 10 most delayed flights
flights %>% 
    mutate(dep_delay_rank = min_rank(-dep_delay)) %>% 
    arrange(dep_delay_rank) %>% 
    filter(dep_delay_rank <= 10)

# summarize()
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
flights %>% 
    group_by(year, month, day) %>% 
    summarise(delay = mean(dep_delay, na.rm = TRUE))
flights %>% 
    filter(!is.na(dep_delay), !is.na(arr_delay)) %>% 
    group_by(tailnum) %>% 
    summarise(delay = mean(arr_delay)) %>% 
    arrange(delay)

# summarize() Exercise
# cancelled flights
cancelled_delayee <- 
    flights %>% 
    mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>% 
    group_by(year, month, day) %>% 
    summarise(prop_cancelled = mean(cancelled),
              avg_dep_delay = mean(dep_delay, na.rm = TRUE))
# worst carrier
flights %>%
    filter(arr_delay > 0) %>%
    group_by(carrier) %>%
    summarise(average_arr_delay = mean(arr_delay, na.rm=TRUE)) %>%
    arrange(desc(average_arr_delay))