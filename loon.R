if (!identical(.Platform$GUI, "RStudio")) {
  stop("Run this from the console!")
}

library(loon)

n <- 1e3
df <- data.frame(x = rnorm(n), y = rnorm(n))

l_plot(df$x, df$y, linkingGroup = "df")
l_hist(df$x, linkingGroup = "df")
