library(cranvas)
n <- 1e5
df <- qdata(data.frame(x = rnorm(n), y = rnorm(n)))
brush(df, "color") <- "red"
brush(df, "alpha") <- 1
brush(df, "style") <- list(color = "red", linewidth = 1, linetype = NULL)

qscatter(x, y, data = df, alpha = 0.05)
qhist(x, data = df)

mean(df$.brushed)
