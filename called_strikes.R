source("start_env.R")

before_abs <- "
SELECT game_date, details_description, pitch_data_strike_zone_top,
pitch_data_strike_zone_bottom, details_type_description,
pitch_data_coordinates_p_x, pitch_data_coordinates_p_z
FROM data.data
WHERE game_date < '2022-05-18'
AND details_description = 'Called Strike'
ORDER BY game_date
;"

before <- dbGetQuery(con, before_abs)
plot_pitches(before)
before_outliers <- before %>% 
  filter(pitch_data_coordinates_p_x > 0.97 | pitch_data_coordinates_p_x < -0.97 | 
           pitch_data_coordinates_p_z > 3.5 | pitch_data_coordinates_p_z < 1.5)
plot_pitches(before_outliers)


after_abs <- "
SELECT *
FROM data.data
WHERE game_date >= '2022-05-18'
AND details_description = 'Called Strike'
ORDER BY game_date
;"

after <- dbGetQuery(con, after_abs)
plot_pitches(after)

after_outliers <- after %>% 
  filter(pitch_data_coordinates_p_x > 0.97 | pitch_data_coordinates_p_x < -0.97 | 
           pitch_data_coordinates_p_z > 3.5 | pitch_data_coordinates_p_z < 1.5)
plot_pitches(after_outliers)



dbDisconnect(con)
