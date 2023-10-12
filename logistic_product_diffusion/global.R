library(dplyr, warn.conflicts = FALSE, quietly = TRUE)
library(stringr, warn.conflicts = FALSE, quietly = TRUE)
library(tidyr, warn.conflicts = FALSE, quietly = TRUE)
library(ggplot2, warn.conflicts = FALSE, quietly = TRUE)
library(tibble, warn.conflicts = FALSE, quietly = TRUE)
library(modelr, warn.conflicts = FALSE, quietly = TRUE)
library(shiny, warn.conflicts = FALSE, quietly = TRUE)
library(shinydashboard, warn.conflicts = FALSE, quietly = TRUE)
library(DT, warn.conflicts = FALSE, quietly = TRUE)

rm(list=ls())

# Loads all required functions 
for(fil in dir("./functions", full.names = TRUE, recursive = TRUE))
  source(fil)

df <- read.csv("internet_users.csv", header =  TRUE) %>%
  na.omit() %>%
  pivot_longer(cols=starts_with('X'),
               names_to = 'year',
               names_prefix = 'X',
               values_to = 'penetration') %>%
  mutate(year=as.numeric(year)) %>%
  rename(country_name=1, country_code=2) %>%
  select(country_code, year, penetration)

all_countries <- df %>% 
  distinct(country_code) %>% 
  pull() 

training_dates <- df %>% 
  distinct(year) %>% 
  arrange(by=year) %>%  
  pull()



