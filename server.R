library(shiny)
source("optdes.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$table1 <- renderTable(
     f.optdes(input$alpha,input$power,
               input$mT,input$mM,input$mP,
               input$vartotT,input$vartotM,input$vartotP,input$ICCT,input$ICCM,input$ICCP,input$varMP,
               input$c2T,input$c2MP,input$c1T,input$c1M,input$c1P,
               input$kT[1],input$kT[2],input$kMP[1],input$kMP[2],input$nT[1],input$nT[2],input$nMP[1],input$nMP[2],
               input$minimize)
     )
  
  })




