library(shiny)

# abtest <- function(contTable) {
#   chisq.test(contTable,simulate.p.value = FALSE)
# }

contTBuild <- function(ctrlClick, trtClick, ctrlTotal, trtTotal)
{
  contTable <- data.frame(row.names = c("Control", "Treatment"), Converted = c(ctrlClick,trtClick), Nonconverted= c(ctrlTotal-ctrlClick, trtTotal-trtClick))
}

abtest <- function(contTable) {
  #contTable <- data.frame(row.names = c("Control", "Treatment"), Converted = c(ctrlClick,trtClick), Nonconverted= c(ctrlTotal-ctrlClick, trtTotal-trtClick))
  chisqtest <- chisq.test(contTable,simulate.p.value = FALSE)
  
  if (chisqtest$p.value <= 0.05){
    print("Treatment group is significantly (alpha = 0.05) different from control group")
  }else{
    print("Treatment group is not significantly (alpha = 0.05) different from control group")
  }
}


shinyServer(
  function(input, output){
    output$ctrlConvRate <- renderPrint({input$ctrlClick/input$ctrlTotal})
    output$trtConvRate <- renderPrint({input$trtClick/input$trtTotal})   
    output$mosaic <- renderPlot({
      mosaicplot(
        contTBuild(
          input$ctrlClick, 
          input$trtClick, 
          input$ctrlTotal,
          input$trtTotal
        ), 
        main="Contingency Analysis of Conversion by Treatment", 
        ylab = "Conversion", 
        xlab = "Group",
        color = TRUE 
        )
    })
    output$prediction <- renderPrint(
      {abtest(
        contTBuild(
          input$ctrlClick, 
          input$trtClick, 
          input$ctrlTotal, 
          input$trtTotal
          )
        )
       }
      )
    }
  )