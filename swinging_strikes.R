source("start_env.R")

#query for swinging strikes

ss_query <- "
SELECT *
FROM data.data
WHERE details_description = 'Swinging Strike'
;
"
temp <- dbGetQuery(con, ss_query) %>%
  group_by(game_date) %>%
  mutate(is_ball = case_when(pitch_data_coordinates_p_x - 0.95 > 0 |
                              -0.95 - pitch_data_coordinates_p_x > 0 |
                              pitch_data_coordinates_p_z - pitch_data_strike_zone_top > 0 |
                              pitch_data_strike_zone_bottom - pitch_data_coordinates_p_z > 0 ~ "ball",
                              TRUE ~ "strike")) %>%
  tabyl(game_date, is_ball) 

temp2 <- temp %>% mutate(diff = ball - strike)

ggplot(data = temp2)+
  geom_point(aes(x = game_date, y = diff))
  

time_series <- ts(data = temp, start = decimal_date(ymd("2022-04-06")),
                  frequency = 365 / 365)

plot(time_series)
 




