#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggpubr)
library(expm)
source("build_TD_Matrix.R")
source("VB.R")
source("strip_probability.R")
source("findAj.R")

session$onSessionEnded(stopApp)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Toeplitz Matrix"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput(
                inputId = "n",
                label = "Dimension of Matrix",
                value = 5, 
                min = 3,
                max = 100
            ),
            numericInput(
                inputId = "a1",
                label = "sub-diagonal",
                value = 0.5, 
                min = 0,
                max = 1
            ),
            numericInput(
                inputId = "c1",
                label = "super-diagonal",
                value = 0.3, 
                min = 0,
                max = 1
            ),
            numericInput(
                inputId = "b",
                label = "diagonal",
                value = 0.6, 
                min = 0,
                max = 1
            ),
            numericInput(
                inputId = "k",
                label = "Take power",
                value = 1, 
                min = 1,
                max = 10000
            ),
            numericInput(
                inputId = "nrow",
                label = "row number",
                value = 1, 
                min = 0,
                max = 1000
            ),numericInput(
                inputId = "ncol",
                label = "column numberl",
                value = 1, 
                min = 0,
                max = 1000
            ),
            numericInput(
                inputId = "row_normalize",
                label = "row to normalize",
                value = 1, 
                min = 0,
                max = 1000
            )

        ),

        # Show a plot of the generated distribution
        mainPanel(
            uiOutput('matrix'),
            #uiOutput('time_power'),
            uiOutput('vb'),
            #uiOutput('time_vb')
            uiOutput('strip_data')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    matrix_data <- reactive({
        start_time <- Sys.time()
        matrix <- build_TD_Matrix(input$n,
                                  input$a1,
                                  input$a1,
                                  input$b,
                                  input$c1,
                                  input$c1
        )
        matrix <- matrix %^% input$k
        end_time <- Sys.time()
        time_diff <- format(end_time - start_time)
        
        return(tibble(
            matrix = matrix,
            time = time_diff
        ))
    })
    
    strip_data <- reactive({
                strip_probability(input$c1, 
                                   input$a1, 
                                   input$b,
                                   input$n,
                                   input$k,
                                   input$row_normalize
        )
    })
    
    vb_data <- reactive({
        start_time <- Sys.time()
        vb_value <- VB(
            input$k, 
            input$n, 
            input$nrow, 
            input$ncol, 
            input$c1, 
            input$a1, 
            input$b
        )
        end_time <- Sys.time()
        time_diff_vb <- format(end_time - start_time)
        
        return(tibble(
            vb = vb_value,
            time = time_diff_vb
        ))
    })
    output$matrix <- renderTable({
        
        matrix_data()$matrix
        
    })
    # output$time_power <- renderText({
    #     
    #     paste("Time required for calculation",matrix_data()$time[1])
    # })
    output$vb <- renderText({
        
        paste("value using algorithm of the",input$k,
              "th power in row", input$nrow,
              "and column", input$ncol, "is",
              vb_data()$vb)
    })
    # output$time_vb <- renderText({
    #     
    #     paste("Time required for calculation",vb_data()$time)
    # })
    
    output$strip_data <- renderTable({
        
        strip_data()
        
    })
    # output$time_power <- renderText({
    #     
    #     paste("Time required for calculation",matrix_data()$time[1])
    # })
}

# Run the application 
shinyApp(ui = ui, server = server)
