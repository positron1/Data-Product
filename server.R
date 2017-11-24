library(shiny)
library(ggplot2)
library(e1071)
library(caret)
library(randomForest)

TrainModel <- function(training) {
  Control <- trainControl(method = "cv", number = 5)
  model <- train(price~., data = training,
                 method = "rf",
                 trControl = Control)
  return(model)
}

PredictPrice <- function(model, inputs) {
  prediction <- predict(model, newdata = inputs)
  prediction<-round(prediction)
  return(prediction)
}


shinyServer(
  function(input, output) {
    
    set.seed(1234)
    
    dat<-diamonds[sample(nrow(diamonds),500),]
    dat<-subset(dat,select=c(carat,cut,color,clarity,price))
    variables = reactiveValues(if_trained=FALSE)
    training<-dat
    levels(training$cut)<-c(1,2,3,4,5)
    levels(training$color)<-c(1,2,3,4,5,6,7)
    levels(training$clarity)<-c(1,2,3,4,5,6,7,8)
    
    plots<-reactiveValues(g1=NULL,g2=NULL,g3=NULL)
      
    output$plot1 <- renderPlot({
      if(input$radio1==1)
        plots$g1<-qplot(carat,price,data=dat, xlab="Carat",ylab = "Price($)",color=cut)+ 
          facet_wrap(~cut)
      if(input$radio1==2)
        plots$g1<-qplot(carat,price,data=dat, xlab="Carat",ylab = "Price($)",color=color)+ 
          facet_wrap(~color)
      if(input$radio1==3)
        plots$g1<-qplot(carat,price,data=dat, xlab="Carat",ylab = "Price($)",color=clarity)+ 
          facet_wrap(~clarity)
      
      plots$g1+plots$g2+plots$g3
      
      })#end of renderPlot
    
    observeEvent(input$train, {
      if(variables$if_trained==FALSE){
      withProgress(message = 'Training in progress...',
                   {model1<-TrainModel(training)})
      variables$if_trained<-TRUE
      output$text1<-renderText("Training finished")}
      else{output$text1<-renderText("The model has been trained.")}
    })
    
    observeEvent(input$price, {
      if(variables$if_trained==TRUE){
        myModel<-model1
        myInputs<-data.frame(carat=input$Weight,cut=as.factor(input$Cut),color=as.factor(input$Color),
                             clarity=as.factor(input$Clarity))
        prediction1<-PredictPrice(myModel,myInputs)
        output$text1<-renderText(paste("Predicted price: ",prediction1, "$"))
        plots$g2<-geom_vline(xintercept = input$Weight,linetype="dashed")
        plots$g3<-geom_hline(yintercept = prediction1,linetype="dashed")
      }
      
      else{
        output$text1<-renderText("Please train a model first.")
      }
      
    })
  }
)