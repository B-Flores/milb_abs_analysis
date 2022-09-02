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
 

# percentage of balls swung on over time

balls_query <- "
SELECT *
FROM data.data
WHERE details_description = 'Swinging Strike'
OR details_description = 'Ball'
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
  mutate(swing_rat = swinging_strike / (ball + swinging_strike)) %>%
  filter(swing_rat > 0.1125, swing_rat < 0.2) %>%
  select(swing_rat) 

swing_percent <- rowid_to_column(swing_percent,"index")
sp1 <- swing_percent %>% filter(index < 37)
sp2 <- swing_percent %>% filter(index >= 37)

plot(x = sp1$index, y = sp1$swing_rat,
     xlab = "Day", ylab = "Swing Percent")

abline(lm(swing_rat ~ index,data=sp1),col='red')

plot(x = sp2$index, y = sp2$swing_rat,
     xlab = "Day", ylab = "Swing Percent")

abline(lm(swing_rat ~ index,data=sp2),col='red')
# lin_mod <- lm(index ~ swing_rat, data = swing_percent) 
# plot(lin_mod)  
  

ggplot(data = swing_percent) +
  geom_point(aes(x = game_date, y = swing_rat))

model <- ts(data = swing_percent, start = 1,
            end = 111)
plot(model)
