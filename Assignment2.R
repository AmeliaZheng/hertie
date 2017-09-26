library(ggplot2)

# plot1
ggplot(data = mpg, mapping = aes(drv, hwy)) + 
    geom_boxplot(mapping = aes(color = class))

# plot2
ggplot(data = mpg, mapping = aes(displ, hwy)) + 
    geom_point(size = 0.3) + 
    facet_wrap(~ manufacturer)

# plot3
ggplot(data = diamonds, mapping = aes(x = cut, fill = color)) +
    geom_bar(aes(y =..count../10000), position="stack") +
    labs(y = "prop")

# plot4
ggplot(data = mpg, mapping = aes(cty, hwy)) +
    geom_point(position = "jitter", size = 0.3)