library(shiny)
library(plotly)

# Create an interactive web page with a sidebar containing input fields and a main panel containing the results

shinyUI(fluidPage(

    # Application title
    titlePanel("Change in global temperature using the Cowtan-Way global temperature data set"),

    # Sidebar with start and end years between 1850 and 2020
    sidebarLayout(
        sidebarPanel(
            numericInput("startdate", "Start Year", 1850, min = 1850),
            numericInput("enddate", "End Year", 2020, min = 1851)
        ),

        # Trend, time series graph with regression line, and regression output.
        mainPanel(
            h3("Trend per 100 years (ºC)"),
            textOutput("trend"),
            h3("Change in global temperature over time"),
            plotlyOutput("tempPlot"),
            h3("Regression fit"),
            verbatimTextOutput("sum")
        )
    )
))
