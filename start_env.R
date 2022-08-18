if (!requireNamespace('pacman', quietly = TRUE)){
  install_packages('pacman')
}
pacman::p_load_current_gh("billpetti/baseballr")
pacman::p_load(tidyverse, stringr,lubridate, ggplot2, 
               purrr, plyr, janitor, keyring, DBI, RMySQL)

con <- dbConnect(RMySQL::MySQL(),
                 dbname = "data",
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = key_get("DB_PWD"))

importData <- function(season , team){
  
  game_packs <- as_vector(mlb_schedule(season = season,
                                       level_ids = "11") %>%
                            filter(teams_home_team_name == team) %>%
                            filter(date < today()) %>%
                            select(game_pk))
  
  # Upon comparing data from each ballpark, we should not include:
  #   base, replacedPlayer.id, replacedPlayer.link
  # also cleans column names using janitor package (turns "." into "_") 
  
  pbp <- map_df(game_packs, mlb_pbp) %>%
    select(-base, -replacedPlayer.id, -replacedPlayer.link) %>%
    clean_names()
  
  return(pbp)
  
}

import_and_store <- function(year, home_team){
  temp <- as_tibble(importData(season = year, team = home_team))
  
  dbWriteTable(con, name = "data", value = temp, 
               row.names = FALSE,
               append = TRUE)
}

plot_pitches <- function(data){
  homeplate <- data.frame(x = c(-0.85, 0.85, 0.85, 0, -0.85, -0.85),
                          z = c(-.5, -.5, -1.25, -2, -1.25, -.5))
  ggplot()+
    geom_path(data = homeplate, aes(x=x, y=z)) +
    geom_rect(aes(xmin = -4,
                  xmax = 4,
                  ymin = -2.25,
                  ymax = 5),
              alpha = 0.66) +
    geom_rect(aes(xmin = -2,
                  xmax = 2,
                  ymin = 0,
                  ymax = 4),
              fill = "white")+
    geom_rect(aes(xmin = -0.95,
                  xmax = 0.95,
                  ymin = 1.5,
                  ymax = 3.47),
              color = "black", alpha = 0.4) +
    coord_equal()+
    xlim(-2,2) +
    ylim(0,4) +
    xlab("feet from home plate")+
    ylab("feet above the ground")+
    geom_point(data = data, 
               aes(x=pitch_data_coordinates_p_x, y=pitch_data_coordinates_p_z,
                   color = details_type_description, alpha = 0.4))+
    scale_size(range = c(0.005,2.5))
  #facet_wrap(~matchup.batSide.code)+
  #  scale_size(range = c(0.01,3))+
  #scale_color_manual(values = c('red','blue','green','orange',"purple"))
}











