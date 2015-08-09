library(shiny)
library(ggplot2)

selectionModel <- function(data, xvar, yvar, method = lm) {
  ui <- fluidPage(
    fluidRow(
      column(width = 6,
        plotOutput("plot1", brush = brushOpts(id = "plot1_brush")),
        actionButton("toggle", "Toggle points"),
        actionButton("reset", "Reset"),
        actionButton("done", "Done")
      )
    )
  )

  server <- function(input, output, session) {
    vals <- reactiveValues(
      keeprows = rep(TRUE, nrow(data))
    )

    output$plot1 <- renderPlot({
      # Plot the kept and excluded points as two separate data sets
      keep    <- data[ vals$keeprows, , drop = FALSE]
      exclude <- data[!vals$keeprows, , drop = FALSE]

      ggplot(keep, aes_(xvar, yvar)) +
        geom_point() +
        geom_smooth(method = method, fullrange = TRUE, shape = 21, color = "black") +
        geom_point(data = exclude, shape = 21, fill = NA, color = "black", alpha = 0.25)
    })

    # Toggle points that are brushed, when button is clicked
    observeEvent(input$toggle, {
      res <- brushedPoints(data, input$plot1_brush, allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, res$selected_)
    })

    # Reset all points
    observeEvent(input$reset, {
      vals$keeprows <- rep(TRUE, nrow(data))
    })

    # When Done button is pressed, return selected rows
    observeEvent(input$done, {
      res <- list(
        selected = vals$keeprows
      )
      stopApp(res)
    })
  }

  runApp(shinyApp(ui, server), launch.browser = rstudioapi::viewer)
}

mpg$consump <- 1 / mpg$hwy
x <- selectionModel(mpg, ~ displ, ~ hwy, loess)
