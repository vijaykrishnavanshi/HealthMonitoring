
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Patient Health Monitoring System"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      uiOutput("Users"),
      uiOutput("range_temps"),
      uiOutput("range_hb")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("tempPlot"),
      plotOutput("hbPlot")
    )
  )
))
