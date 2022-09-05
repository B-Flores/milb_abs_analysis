source("start_env.R")

# percentage of balls swung on over time

balls_query <- "
SELECT *
FROM data.data
WHERE details_description = 'Swinging Strike'
OR details_description = 'Ball'
OR details_description = 'Foul'
;
"
balls <- dbGetQuery(con, balls_query) %>%
  group_by(game_date) %>%
  mutate(is_ball = case_when(pitch_data_coordinates_p_x - 0.95 > 0 |
                               -0.95 - pitch_data_coordinates_p_x > 0 |
                               pitch_data_coordinates_p_z - pitch_data_strike_zone_top > 0 |
                               pitch_data_strike_zone_bottom - pitch_data_coordinates_p_z > 0 ~ "ball",
                             TRUE ~ "strike")) %>%
  filter(is_ball == "ball") %>%
  tabyl(game_date, details_description) %>%
  clean_names() 

swing_percent <- balls %>%
  mutate(swing_rat = (swinging_strike + foul) / ball) %>%
  select(swing_rat)

avg <- mean(swing_percent$swing_rat)
sd <- sd(swing_percent$swing_rat)

swing_percent <- swing_percent %>% filter(swing_rat < avg + 2 * sd,
                                          swing_rat > avg - 2 * sd)

swing_percent <- rowid_to_column(swing_percent,"index")
sp1 <- swing_percent %>% filter(index < 37)
sp2 <- swing_percent %>% filter(index >= 37)

plot(x = sp1$index, y = sp1$swing_rat,
     xlab = "Day", ylab = "Swing Percent")

abline(lm(swing_rat ~ index,data=sp1),col='blue')

plot(x = sp2$index, y = sp2$swing_rat,
     xlab = "Day", ylab = "Swing Percent")

abline(lm(swing_rat ~ index,data=sp2),col='blue')

