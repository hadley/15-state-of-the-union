library(ggvis)
data("mpg", package = "ggplot2")

mpg %>%
  ggvis(~displ, ~hwy) %>%
  layer_points() %>%
  layer_smooths()

# Interactive plots -------------------------------------------------------

mpg %>%
  ggvis(~displ, ~hwy) %>%
  layer_points() %>%
  layer_smooths(span = input_slider(0.2, 1))

mpg %>%
  ggvis(~displ, ~hwy) %>%
  layer_points() %>%
  layer_smooths(span = waggle(0.2, 1))

# Streaming data -----------------------------------------------------------

df <- data.frame(
  x = runif(20),
  y = runif(20),
  dir_x = sample(c(-1, 1), 20, replace = TRUE),
  dir_y = sample(c(-1, 1), 20, replace = TRUE),
  velocity = runif(20, 0, 0.01)
)
mtc1 <- reactive({
  invalidateLater(30, NULL);

  df$x <<- df$x + df$dir_x * df$velocity
  df$y <<- df$y + df$dir_y * df$velocity
  df$dir_x <<- ifelse(df$x > 1, -1, ifelse(df$x < 0, 1, df$dir_x))
  df$dir_y <<- ifelse(df$y > 1, -1, ifelse(df$y < 0, 1, df$dir_y))
  df
})
mtc1 %>% ggvis(x = ~x, y = ~y) %>%
  layer_points() %>%
  scale_numeric("x", domain = c(0, 1)) %>%
  scale_numeric("y", domain = c(0, 1)) %>%
  set_options(duration = 0)
