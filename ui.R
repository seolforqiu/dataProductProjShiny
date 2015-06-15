library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("A/B Test"),
  
  sidebarPanel(
    h3('Inputs'),
    numericInput('ctrlClick', 'Converted in Control Group', 2000, min = 0, max = 99999999, step = 1),
    numericInput('trtClick', 'Converted in Treatment Group', 2000, min = 0, max = 99999999, step = 1),
    numericInput('ctrlTotal', 'Total Objects in Control Group', 10000, min = 0, max = 99999999, step = 1),
    numericInput('trtTotal', 'Total Objects in Treatment Group', 10000, min = 0, max = 99999999, step = 1),
    submitButton('Submit')
    ),
  
  mainPanel(
    p('Conversion Rate of Control'),
    verbatimTextOutput('ctrlConvRate'),
    p('Conversion Rate of Treatment'),
    verbatimTextOutput('trtConvRate'),
    plotOutput("mosaic"),
    verbatimTextOutput("prediction")
    )
  ))