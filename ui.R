library(shiny)

shinyUI(
  navbarPage("Diamond Pricing",
    tabPanel("Use the App",
    
    plotOutput('plot1'),
    
    hr(),
    
    fluidRow(
      column(2,
             radioButtons("radio1", h3("Choose classification:"),
                          choices = list("Cut" = 1, "Color" = 2,
                                         "Clarity" = 3),selected = 1)
             
      ),
      column(3, 
             selectInput("Cut",h4("Choose cut"),choices = list("Fair"=1,"Good"=2,"Very Good"=3,
                                                               "Premium"=4,"Ideal"=5)),
             selectInput("Color",h4("Choose color"),choices = list("D"=1,"E"=2,"F"=3,
                                                               "G"=4,"H"=5,"I"=6,"J"=7))
              ),
      column(3,
             selectInput("Clarity",h4("Choose clarity"),choices = list("I1"=1,"SI2"=2,"SI1"=3,"VS2"=4,
                                                                       "VS1"=5,"VVS2"=6,"VVS1"=7,"IF"=8)),
             numericInput("Weight",h4("Choose carat(0.3~3)"),value = 1,min=0.3,max=3,step = 0.02)
             
      ),
             
      column(3,    
             h3(textOutput("text1")),
             actionButton(
               inputId = "train",
               label = "Train my model"
             ),
             actionButton(
               inputId = "price",
               label = "Price my diamond"
             )
             
      )
      
    )
  ),
  tabPanel("Tutorial",
           includeMarkdown("tutorial.rmd")
)
  )
)
  