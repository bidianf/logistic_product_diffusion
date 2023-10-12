shinyServer(function(input, output, session) {
  
  
  
  reactive_model <- reactive({
    run_model(df=df,
        sample_end=input$sample_end,
        fcst_horizon=input$fcst_horizon,
        countries_selected = input$countries_selected,
        threshold=input$lower_threshold,
        model_name=input$regression_type)
  })
  


  
  
 
  
  output$forecasts_table <- renderDataTable({
    reactive_model()$forecasts %>% 
    pivot_wider(names_from=country_code,values_from=penetration) 
  }, rownames=FALSE, options = list(lengthChange = FALSE, pageLength = 100))
  
  
  output$penetration_plot <- renderPlot({
    plot_penetration(reactive_model()$training_and_forecasts, 
                     input$sample_end, 
                     input$countries_selected)
  })
 
 
})
