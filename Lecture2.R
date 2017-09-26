library(ggplot2)
library(gapminder)

# Mapping
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap, 
                          y = lifeExp))
# Choosing a geom
p + geom_point()
p + geom_smooth()
p + geom_smooth(method = "lm")
p + geom_smooth() + geom_point()

# Adjusting the scales
p + geom_smooth() + geom_point() + scale_x_log10()
# Other scale trasformations: scale_x_sqrt() , scale_x_reverse()

#Labels and titles
p + geom_smooth() + geom_point() + scale_x_log10(labels = scales::dollar)
p + geom_point() + geom_smooth() + scale_x_log10(labels = scales::dollar) +
    labs(x = "GDP Per Capital", 
         y = "Life Expectancy in Years", 
         title = "Economic Growth and Life Expetancy", 
         subtitle = "Data points are contry-years", 
         caption = "Source: Gapminder." )

# Aesthetics mapping
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          fill = continent))
p + geom_point() + geom_smooth() + scale_x_log10()

# Aesthetic mappings per geom
p <- ggplot(data = gapminder, 
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(mapping = aes(color = continent)) +
    geom_smooth() +
    scale_x_log10()
# Specific arguements for geom_ function
# change size: geom_point(size = 0.8)
# change transparency: geom_point(alpha = 0.3)
# change color: geom_smooth(color = "orange")??? geom_point(mapping = aes(color = pop))

# Group
p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPercap))
p + geom_line(aes(group = country))

# Facet
p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPercap))
p + geom_line(aes(group = country)) + facet_wrap(~ continent)
p + geom_line(color = "gray70", aes(group = country)) +
    geom_smooth(size = 1.1, method = "loess", se = FALSE) +
    scale_y_log10(labels = scales::dollar) +
    facet_wrap(~ continent, ncol = 3) +
    labs(x = "Year",
         y = "GDP per capita",
         title = "GDP per capita on Five Continents")

# Statistical transformation
p <- ggplot(data = diamonds, 
            mapping = aes(x = cut))
p + geom_bar()
p + geom_bar(mapping = aes(y = ..prop.., group = 1))

# Position arguments
p <- ggplot(data = diamonds,
            mapping = aes(x = cut, fill = cut))
p + geom_bar()
# position = fill
p <- ggplot(data = diamonds,
            mapping = aes(x = cut, fill = clarity))
p + geom_bar(position = "fill")
# position = "dodge"
p <- ggplot(data = diamonds, 
            mapping = aes(x = cut, fill = clarity))
p + geom_bar(position = "dodge")
# position = "jitter"
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(position = "jitter")

# Coordinate systems
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
    geom_boxplot() + 
    coord_flip()