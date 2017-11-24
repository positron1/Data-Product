---
title       : Diamond Pricing
subtitle    : Developing Data Products Final Project
author      : Yue Yang
job         : Student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction
This is an shiny app created for the final project of Coursera course "Developing Data Products". It is a predictor for diamond prices. Simply specify the properties of the diamond that you are interested in and the app will tell you the most likely price you need pay for such a diamond based on known price information from the diamond market.

To use the app, please go to:  
https://positron1.shinyapps.io/shiny_project/

To look at the soure code, please go to:  
https://github.com/positron1/Data-Product

--- .class #id 
## What dataset has been used to buid the model?
The dataset used to train the predicting model is the "diamonds" dataset. it is a huge dataset containing the prices and other attributes of almost 54,000 diamonds. Too make the training more efficient, 500 samples are randomly selected from the "diamonds" dataset to form the training set, and the kept attributes are "carat","cut","color","clarity" and "price".


```r
head(training,4)
```

```
## # A tibble: 4 x 5
##   carat     cut color clarity price
##   <dbl>   <ord> <ord>   <ord> <int>
## 1  0.91   Ideal     G     SI2  3985
## 2  0.43 Premium     D     SI1   830
## 3  0.32   Ideal     D     VS2   808
## 4  0.33   Ideal     G     SI2   463
```

--- .class #id 

## How the predicting model is trained?
The "random forrest" method has been used to train the predicting model, where the "price" is trained against other 4 attributes of the diamonds. The training function and the predicting function are listed below:

```r
TrainModel <- function(training) {
  Control <- trainControl(method = "cv", number = 5)
  model <- train(price~., data = training, method = "rf", trControl = Control)
  return(model)}

PredictPrice <- function(model, inputs) {
  prediction <- predict(model, newdata = inputs)
  prediction<-round(prediction)
  return(prediction)}
```

--- .class #id 

## How to use the App?
Before using the predictor, the user needs to train the predicting model by clicking "Train my model". After the training is finished, the user needs to specify the 4 properties of the diamond, which are the cut, color, clarity, and the carat(weight). After specifying these parameters, click "Price my diamond" to display the predicted price for the diamond.  

Ready to try? Please click the link below:  
https://positron1.shinyapps.io/shiny_project/

