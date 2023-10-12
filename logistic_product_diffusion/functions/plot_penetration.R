plot_penetration <- function(pen_rate,
                             sample_end,
                             countries_selected,
                             desc = "Penetration"){
  
  fig <- pen_rate %>% 
    filter(year <= sample_end) %>% 
    select(year, country_code, penetration) %>% 
    ungroup() %>% 
    filter(country_code %in% countries_selected) 

  forecast <- pen_rate %>%  ungroup() %>% 
    filter(country_code %in% countries_selected) %>%  filter(year>= sample_end)
  

  ymax <- max(fig %>% select(penetration) %>% pull() %>% max() + 5, 75)
  xmax <- pen_rate$year %>% max()
  xmin <- pen_rate$year %>% min()
  sample_end <- as.numeric(sample_end)
  
 
  fig <- ggplot(fig, aes(y=penetration, x=year, color=country_code)) 
  
  
  fig <- fig +
    geom_vline(xintercept = sample_end, linetype=3, na.rm=TRUE) +
    geom_line(data = forecast, mapping = aes(x=year, y=penetration, color=country_code), linetype=2, inherit.aes = FALSE, na.rm=TRUE) +
    geom_point(data = forecast, mapping = aes(x=year, y=penetration, color=country_code), size=2, inherit.aes = FALSE, na.rm=TRUE) +
    geom_line() + 
    theme_bw() +
    scale_x_continuous(breaks = c(xmin,sample_end, xmax)) + 
    scale_y_continuous(limits = c(0,ymax)) +
    xlab("Year") + 
    ylab("Penetration") +
    ggtitle(desc)
  print(fig)
}
