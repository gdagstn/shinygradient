library(shiny)
library(shinyXYpad)

ui <- fluidPage(
  
  titlePanel("RGB Gradient Palette Mixer"),
  
  fluidRow(offset = 0, style='padding-left:15px;',
           "Inspired by Inigo Quilez's ", a("video", href = "https://www.youtube.com/shorts/TH3OTy5fTog"), ".",br(),
           br(),
           "Move the XY sliders to control different parameter of indepenent cosine waves for each RGB channel.",
           br(),
           br(),
           HTML("<b>Brightness/Contrast</b>: controls the brightness (height of wave) and contrast (amplitude)"),br(),
           HTML("<b>Change/Shift</b>: controls the rate of change (frequency) and how it is shifted (delay)"),br(),
           br()
  ),
  
  fluidRow(
    column(
      3, 
      XYpadInput(
        "xy1", label = "R Brightness/Contrast", pointRadius = 5, 
        x = "Bright.", y = "Cont.", 
        value=list(x=0.5,y=0.5),
        bgColor="rgba(255,0,0,0.2)",
        xmin=0, xmax=1,
        ymin=0, ymax=1,
        coordsColor = "black", xyColor = "red", 
        xySize = 12, xyStyle = "oblique"
      )
    ),
    column(
      3, 
      XYpadInput(
        "xy2", label = "G Brightness/Contrast", pointRadius = 5, 
        x = "Bright.", y = "Cont.", 
        value=list(x=0.5,y=0.5),
        bgColor="rgba(0,255,0,0.2)",
        xmin=0, xmax =1,
        ymin=0, ymax=1,
        coordsColor = "black", xyColor = "green", 
        xySize = 12, xyStyle = "oblique"
      )
    ),
    column(
      3, 
      XYpadInput(
        "xy3", label = "B Brightness/Contrast", pointRadius = 5, 
        x = "Bright.", y = "Cont.", 
        value=list(x=0.5,y=0.5), 
        bgColor="rgba(0,0,255,0.2)",
        xmin=0, xmax =1,
        ymin=0, ymax=1,
        coordsColor = "black", xyColor = "blue", 
        xySize = 12, xyStyle = "oblique"
      )
    ),
  ),
  br(),
  fluidRow(
    column(
      3, 
      XYpadInput(
        "xy4", label = "R Change/Shift", pointRadius = 5, 
        x = "Change", y = "Shift", 
        value=list(x=0.5,y=0.5),
        bgColor="rgba(255,0,0,0.2)",
        xmin=0, xmax =1,
        ymin=0, ymax=1,
        coordsColor = "black", xyColor = "red", 
        xySize = 12, xyStyle = "oblique"
      )
    ),
    column(
      3, 
      XYpadInput(
        "xy5", label = "G Change/Shift", pointRadius = 5, 
        x = "Change", y = "Shift", 
        value=list(x=0.5,y=0.5),
        bgColor="rgba(0,255,0,0.2)",
        xmin=0, xmax =1,
        ymin=0, ymax=1,
        coordsColor = "black", xyColor = "green", 
        xySize = 12, xyStyle = "oblique"
      )
    ),
    column(
      3, 
      XYpadInput(
        "xy6", label = "B Change/Shift", pointRadius = 5, 
        x = "Change", y = "Shift", 
        value=list(x=0.5,y=0.5),
        bgColor="rgba(0,0,255,0.2)",
        xmin=0, xmax =1,
        ymin=0, ymax=1,
        coordsColor = "black", xyColor = "blue", 
        xySize = 12, xyStyle = "oblique"
      )
    ),
  ),
  br(),
  actionButton("randomize", "randomize"),
  fluidRow(
    column(2),
    column(8,
           sliderInput("N", label = "Number of colors", value = 25, min = 3, max = 50, step = 1)
    )
  ),
  fluidRow(
    offset = 0, style='padding-left:15px;',
    column(12, plotOutput("scale")),
    "Resulting colors (hex codes):",
    column(12, textOutput("colors"))
  )
)


colorX = function(x, A, B, C, D) {
  mat = matrix(A + B*cos(2*pi*(C*x + D)),ncol=3)
  mat[mat < 0] = abs(mat[mat < 0])
  mat[mat > 1] = 1
  rgb(mat)
}

server <- function(input, output, session){
  
  A = reactive({A = c(input$xy1$x, input$xy2$x, input$xy3$x)})
  B = reactive({B = c(input$xy1$y, input$xy2$y, input$xy3$y)})
  C = reactive({C = c(input$xy4$x, input$xy5$x, input$xy6$x)})
  D = reactive({D = c(input$xy4$y, input$xy5$y, input$xy6$y)})
  
  reactive({print(A())})
  
  cols = reactive({sapply(seq_len(input$N)/input$N, function(x) colorX(x, A(), B(), C(), D()))})
  
  observeEvent(input[["randomize"]], {
    updateXYpadInput(session, "xy1", label = "R Brightness/Contrast", 
                     pointRadius = 5, value=list(x=runif(1, 0, 1), 
                                                 y=runif(1, 0, 1)),
    
    )
    updateXYpadInput(session, "xy2", label = "G Brightness/Contrast", 
                     pointRadius = 5, value=list(x=runif(1, 0, 1), 
                                                 y=runif(1, 0, 1)),
                    
    )
    updateXYpadInput(session, "xy3", label = "B Brightness/Contrast", 
                     pointRadius = 5, value=list(x=runif(1, 0, 1), 
                                                 y=runif(1, 0, 1)),
                     
    )
    updateXYpadInput(session, "xy4", label = "R Change/Shift", 
                     pointRadius = 5, value=list(x=runif(1, 0, 1), 
                                                 y=runif(1, 0, 1)),
                     
    )
    updateXYpadInput(session, "xy5", label = "G Change/Shift", 
                     pointRadius = 5, value=list(x=runif(1, 0, 1), 
                                                 y=runif(1, 0, 1)),
                     
    )
    updateXYpadInput(session, "xy6", label = "B Change/Shift", 
                     pointRadius = 5, value=list(x=runif(1, 0, 1), 
                                                 y=runif(1, 0, 1)),
                     
    )
    }
  )

  output$scale <- renderPlot({

    plot(x = seq_len(input$N)/input$N, y = rep(-1, input$N), pch = 15, cex = 10, 
         col = cols(), xlab = NA, ylab = NA,
         ylim = c(-1,1.5))
    
    x = seq_len(input$N*100)/input$N
    
    lines(x = x, 
          y = A()[1] + B()[1]*cos(2*pi*(C()[1]*x + D()[1])),
          col = "red")
    lines(x = x, 
          y = A()[2] + B()[2]*cos(2*pi*(C()[2]*x + D()[2])),
          col = "green")
    lines(x = x, 
          y = A()[3] + B()[3]*cos(2*pi*(C()[3]*x + D()[3])),
          col = "blue")
  }, res = 96)
  
  output$colors <- renderText(cols())
}



shinyApp(ui, server)
