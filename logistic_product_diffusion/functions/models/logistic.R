#Regression of percentage change in penetration on (1-penetration)
#Input: data frame with columns "penetration" (on a 0-100 scale) and "percent_change"
#Returns: model data and model fit

logistic <- function(df){
  
  model.data <- df %>%
    mutate(one_minus_pen = 1 - penetration/100) %>% 
    add_predictions(lm(., formula = percent_change ~ one_minus_pen - 1), var = "pred") 
  
  list(model_data = model.data, model_fit = lm(model.data, formula = percent_change ~ one_minus_pen - 1))
  
}