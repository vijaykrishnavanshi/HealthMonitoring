
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library("RSQLite")

shinyServer(function(input, output) {
  # function to connect with the database
  connect <- reactive({
    dbConnect(drv = RSQLite::SQLite(), dbname = "cons.db")
  })
  
  # function to get current selected user from the database
  currentUser <- reactive({
    return (input$selectedUser)
  })
  
  #function to get the table from the database
  getTable <- reactive({
    con = connect()
    return(dbGetQuery( con, paste('select * from',currentUser()) ))
  })
  
  # render UI for user selection
  output$Users <- renderUI({
    
    con = connect()
    
    if(is.null(con))
    {
      return(NULL);
    }
    
    listedUsers = dbListTables(con)
    ptn = '^user_*'
    #ptn = 'dummy'
    ndx = grep(ptn, listedUsers, perl=T)
    listedUsers = listedUsers[ndx]
    selectInput("selectedUser",
                "Select User:",
                choices = listedUsers)
  })
  
  output$range_temps <- renderUI({
    #get table
    
    df <- getTable()
    sliderInput("bins_temp",
                "Time Range for Temprature:",
                min = min(df$Time),
                max = max(df$Time),
                value = c(min(df$Time),max(df$Time)),
                step = 1)
  })
  
  output$range_hb <- renderUI({
    #get table
    df <- getTable()
    sliderInput("bins_hb",
                "Time Range for Heart Beat:",
                min = min(df$Time),
                max = max(df$Time),
                value = c(min(df$Time),max(df$Time)),
                step = 1)
  })
  
  output$tempPlot <- renderPlot({
    df <- getTable()
    plot(df$Time[input$bins_temp[1]:input$bins_temp[2]],df$Temp[input$bins_temp[1]:input$bins_temp[2]],
         xlab = "Time", ylab = "Temperature", type = 'l')
  })
  
  output$hbPlot <- renderPlot({
    df <- getTable()
    plot(df$Time[input$bins_hb[1]:input$bins_hb[2]],df$Heart_Beat[input$bins_hb[1]:input$bins_hb[2]],
         xlab = "Time",ylab = "Heart Beat", type = 'l')
  })
  
  
})
