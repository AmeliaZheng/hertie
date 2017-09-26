library(hexbin)
library(tidyverse)
library(nycflights13)
str(flights)
str(diamonds)
str(mpg)

# Distributions of categorical data
diamonds %>% 
    ggplot() +
    geom_bar(mapping = aes(x = cut))

# Distributions of continuous data
diamonds %>% 
    ggplot() +
    geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
diamonds %>% 
    ggplot(mapping = aes(x = carat, colour = cut)) +
    geom_freqpoly(binwidth = 0.1)
diamonds %>% 
    ggplot(mapping = aes(x = carat)) +
    geom_histogram(binwidth = 0.01)


# Outliers
diamonds %>% 
    ggplot() +
    geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
    coord_cartesian(ylim = c(0, 50))

# Exercise 1
# Distribution of x, y, z
diamonds %>% 
    ggplot() +
    geom_histogram(mapping = aes(x = x), binwidth = 0.5)
diamonds %>% 
    ggplot() +
    geom_histogram(mapping = aes(x = y), binwidth = 0.5)
diamonds %>% 
    ggplot() +
    geom_histogram(mapping = aes(x = z), binwidth = 0.5)
# Distribution of price
diamonds %>% 
    ggplot() +
    geom_histogram(mapping = aes(x = price), binwidth = 0.5) +
    coord_cartesian(xlim = c(0, 5000))
# Distribution of carat
diamonds %>% 
    filter(carat == 0.99 |carat == 1) %>% 
    ggplot() +
    geom_bar(mapping = aes(x = carat))


# Dealing with unusual values
# Replace unusual values with missing values
diamonds2 <- diamonds %>% 
    mutate(y = ifelse(y < 3 | y > 20, NA, y))
diamonds2 %>% 
    ggplot(mapping = aes(x = x, y = y)) +
    geom_point()

# Covariation
diamonds %>% 
    ggplot(mapping = aes(x = price, y = ..density.. )) +
    geom_freqpoly(aes(color = cut), binwidth = 500)

# Boxplots
diamonds %>% 
    ggplot(mapping = aes(x = cut, y = price)) +
    geom_boxplot()
mpg %>% 
    ggplot(mapping = aes(x = class, y = hwy)) +
    geom_boxplot(aes(x = reorder(class, hwy, FUN = median),
                     y = hwy)) # + coord_flip()

# Exercise 3
flights %>% 
    mutate(cancelled = is.na(dep_time),
           sched_hour = sched_dep_time %/% 100,
           sched_min = sched_dep_time %% 100,
           sched_dep_time = sched_hour + sched_min/60) %>% 
    ggplot() +
    geom_boxplot(mapping = aes(y = sched_dep_time,
                               x = cancelled))

# Covariation between two categorical variables
diamonds %>% 
    ggplot() +
    geom_count(mapping = aes(x = cut, y = color))
# dplyr() with geom_tile:
diamonds %>% 
    count(color, cut) %>% 
    ggplot(mapping = aes(x = color, y = cut)) +
    geom_tile(mapping = aes(fill = n))

# Exercise 4
flights %>% 
    group_by(dest, month) %>% 
    summarise(ave_delay = mean(arr_delay), na.rm = T) %>% 
    ggplot(mapping = aes(x = factor(month), 
                         y = dest,
                         fill = ave_delay)) +
    geom_tile() +
    labs(x = "Month", y = "Destination", fill = "Departure Delay")

# Covariation between two continuous variables
diamonds %>% 
    ggplot() +
    geom_point(mapping = aes(x = carat, y = price), alpha = 0.1, size = 0.3)

diamonds %>% 
    ggplot() +
    geom_bin2d(mapping = aes(x = carat, y = price))

# hex()
diamonds %>% 
    ggplot() +
    geom_hex(mapping = aes(x = carat, y = price))
diamonds %>% 
    ggplot(mapping = aes(x = carat, y = price)) +
    geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))