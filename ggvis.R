library(ggvis)
data("mpg", package = "ggplot2")

mpg %>%
  ggvis(~displ, ~hwy) %>%
  layer_points()

mpg %>%
  ggvis(~displ, ~hwy) %>%
  layer_points() %>%
  layer_smooths(span = input_slider(0.2, 1))

mpg %>%
  ggvis(~displ, ~hwy) %>%
  layer_points() %>%
  layer_smooths(span = waggle(0.2, 1))
