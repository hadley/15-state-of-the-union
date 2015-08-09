# devtools::install_url("https://rforge.net/src/contrib/Acinonyx_3.0-0.tar.gz")
library(Acinonyx)

x <- rnorm(1e6)
y <- rnorm(1e6)/4 + x

iplot(x, y)
ihist(x)

mean(selected())
