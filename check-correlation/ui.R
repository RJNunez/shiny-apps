#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shinythemes)
library(tidyverse)
library(shiny)
library(MASS)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("superhero"),

    # Application title
    titlePanel("Be Wary of your Correlation"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            # -- Input 1
            numericInput("obs", "Sample Size:", min=2, max=1000000, value=10),
            
            # -- Input 2
            numericInput("itr", "Simulations:", min=1, max=1000, value=100),
            
            # -- Input 3
            numericInput("corr", "Correlation:", min = -1, max = 1, value = 0)
            
            # -- Input 4
            # actionButton("action", "Start Animation"),
            # p("Click the button to start the animation (This may take a while)")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            
            # -- Showing Panel 1
            tabsetPanel(
                
                tabPanel("Correlation",
                         plotOutput("distPlot"),
                         h4("Description"),
                         "This app is simply to show that the sample correlation coefficient may
                         not be the equal to the true population correlation coefficient when the 
                         sample size is small. In fact, it may be the case that the sample correlation
                         coefficient is very different from the truth. To show this, let X and Y be 
                         jointly normally distributed random variables centered at zero, with unit 
                         variance and correlation rho which is to be chosen by the user. The Sample 
                         Size input determines the number of observations to be drawn from the multivariate
                         normal distribution. The higher this number is, the closer the sample correlation
                         coefficient will be to the truth. The Simulations input determines the amount of 
                         times the experiment is to be repeated. The experiment is defined as randomly
                         sampling from the random variables X and Y, computing the sample correlation
                         coefficient and then comparing it to the truth. For example, let Simulations = 500
                         and Sample Size = 100, then the app will generate 100 random draws for X and Y 
                         respectively, compute the sample correlation coefficient and save it. Then it will
                         repeat this 499 more times for a total of 500, each iteration with a different 
                         random sample. Finally, each data point in the figure below correspond to the sample
                         correlation coefficient obtained at the corresponding simulation. The red-dash line 
                         correspond to the true (population) correlation coefficient.")
            
            )
                
            
        )
    )
))
















