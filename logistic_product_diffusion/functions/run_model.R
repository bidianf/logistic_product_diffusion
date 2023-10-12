run_model <- function(df,sample_end,fcst_horizon,
                      countries_selected,threshold,model_name){
  

  df <- df %>%
    filter(country_code %in% countries_selected, 
           penetration>threshold,
           year<=sample_end) %>%
    group_by(country_code) %>%
    arrange(year) %>%
    mutate(percent_change=penetration/lag(penetration)-1) %>% 
    ungroup() 
  
  pen_model = do.call(model_name, list(df=df))

  for (country in countries_selected){
    dfc <- df %>% 
           filter(country_code == country) %>%
           arrange(year)
    for (i in 1:fcst_horizon){
      df1row<-tail(dfc,1)
      current_pen = as.numeric(df1row['penetration'])
      df1row['one_minus_pen'] = 1-current_pen/100
      fcst_pctg_change <- predict(pen_model$model_fit, newdata = df1row)
      df1row <- df1row %>%
                mutate(percent_change = fcst_pctg_change,
                       penetration = current_pen*(1+fcst_pctg_change),
                       year = year+1) %>%
                select(-c(one_minus_pen))
      dfc<-rbind(dfc,df1row) %>% arrange(year)
      df<-rbind(df,df1row)
    }
  }
  
df<- df %>% mutate(penetration = round(penetration,1))
list(forecasts = df %>% filter(year>sample_end) %>% select(-percent_change),
     training_and_forecasts = df %>% select(-percent_change),
     model_fit = pen_model$model_fit)
}






