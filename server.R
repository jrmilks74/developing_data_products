library(shiny)
library(plotly)

shinyServer(function(input, output) {
    
    # Data set of average annual global temperature
    
    Cowtan_Way <- read.table("https://www-users.york.ac.uk/~kdc3/papers/coverage2013/had4_krig_annual_v2_0_0.txt", header = FALSE)
    names(Cowtan_Way) <- c("year", "temperature", "total_uncertainty", "coverage_uncertainty", "ensemble_uncertainty")

    # Create graph of temperature data and linear regression fit
    
    output$tempPlot <- renderPlotly({
        CW <- subset(Cowtan_Way, year >= input$startdate & year <= input$enddate)
        fit <- lm(temperature~year, data = CW)
        xlab <- list(title = "Year")
        ylab <- list(title = "Temperature Anomaly (ºC)")
        plot_ly(CW, x = ~year, y = ~temperature, type = "scatter", mode = "lines", name = "Temperature") %>%
            layout(xaxis = xlab, yaxis = ylab) %>%
            add_lines(x = ~year, y = fitted(fit), name = "Trend")
    })
    
    # Raw output of the linear regression analysis
    
    output$sum <- renderPrint({
        CW <- subset(Cowtan_Way, year >= input$startdate & year <= input$enddate)
        fit <- lm(temperature~year, data = CW)
        summary(fit)
    })
    
    # Calculate the linear trend between the start and end points
    
    output$trend <- renderText({
        CW <- subset(Cowtan_Way, year >= input$startdate & year <= input$enddate)
        fit <- lm(temperature~year, data = CW)
        100*fit$coefficients[2]
    })

})
