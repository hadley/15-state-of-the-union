library(rggobi)

mystery <- read.csv("mystery.csv")
g <- ggobi(mystery)

d <- displays(g)[[1]]
ggobi_display_get_tour_projection(d)
