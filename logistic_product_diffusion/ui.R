sidebar <- dashboardSidebar(
  width = 300,
  sidebarMenu(
    
    selectizeInput(
      "countries_selected",
      "Select Countries",
      choices = all_countries,
      selected = c("ALB","ESP","ITA","USA") ,
      multiple = TRUE
    ),
    hr(),
    selectInput(
      "sample_end",
      "Training Data End",
      choices = training_dates,
      selected = max(training_dates)
    ),
    selectInput(
      "fcst_horizon",
      "Forecast horizon (years)",
      choices = 1:10,
      selected = 5
    ),
    hr(),
    selectInput(
      "regression_type",
      "S-curve model",
      choices = substr(dir("functions/models"), 1, nchar(dir("functions/models")) - 2),
      selected = "logistic"
    ),
    sliderInput(
      "lower_threshold",
      label = "Discard years with penetration below %", 
      value = 10,
      min = 0.0,
      max = 50,
      step = 1
    ), 
    tags$hr()
  )
  
)

body <- dashboardBody(
  fluidRow(box(plotOutput("penetration_plot"), width = 12)),
  fluidRow(box(dataTableOutput("forecasts_table"), width = 12))
)

header <- dashboardHeader(title = shiny::HTML("Technology Adoption  Model"), titleWidth = 300)

dashboardPage(header, sidebar, body)
