library(shiny)

ui <- fluidPage(
  
  titlePanel("RGB Gradient Palette Mixer"),
  
  fluidRow(offset = 0, style='padding-left:15px;',
    "Inspired by Inigo Quilez's ", a("video", href = "https://www.youtube.com/shorts/TH3OTy5fTog"), "."
  ),
  
  fluidRow(
    column(3, 
           "A",
           sliderInput("A1", label = "A1", value = 0.5, min = 0, max = 1),
           sliderInput("A2", label = "A2", value = 0.5, min = 0, max = 1),
           sliderInput("A3", label = "A3", value = 0.5, min = 0, max = 1)
    ),
    column(3, 
           "B",
           sliderInput("B1", label = "B1", value = 0.5, min = 0, max = 1),
           sliderInput("B2", label = "B2", value = 0.5, min = 0, max = 1),
           sliderInput("B3", label = "B3", value = 0.5, min = 0, max = 1)
    ),
    column(3,
           "C",
           sliderInput("C1", label = "C1", value = 0.5, min = 0, max = 1),
           sliderInput("C2", label = "C2", value = 0.5, min = 0, max = 1),
           sliderInput("C3", label = "C3", value = 0.5, min = 0, max = 1)
    ),
    column(3,
           "D",
           sliderInput("D1", label = "D1", value = 0.5, min = 0, max = 1),
           sliderInput("D2", label = "D2", value = 0.5, min = 0, max = 1),
           sliderInput("D3", label = "D3", value = 0.5, min = 0, max = 1)
    ),
    column(3,
           
           sliderInput("N", label = "Number of colors", value = 10, min = 3, max = 100, step = 1)
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
  mat[mat < 0] = 0
  mat[mat > 1] = 1
  rgb(mat)
}

server <- function(input, output, session) {

  A = reactive({c(input$A1, input$A2, input$A3)})
  B = reactive({c(input$B1, input$B2, input$B3)})
  C = reactive({c(input$C1, input$C2, input$C3)})
  D = reactive({c(input$D1, input$D2, input$D3)})

  cols = reactive({sapply(seq_len(input$N)/input$N, function(x) colorX(x, A(), B(), C(), D()))})
  
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

shinyApp(ui = ui, server = server)

