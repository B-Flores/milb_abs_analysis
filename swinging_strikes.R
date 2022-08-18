source("start_env.R")

#query for swinging strikes

ss_query <- "
SELECT *
FROM data.data
WHERE details_description = 'Swinging Strike'
;
"
ss <- dbGetQuery(con, ss_query)
before_abs <- ss %>%
  filter(game_date < '2022-05-18')
after_abs <- ss %>%
  filter(game_date >= '2022-05-18')

swing_at_ball_before <- before_abs %>%
  filter(pitch_data_coordinates_p_x > 0.95 | pitch_data_coordinates_p_x < -0.95 | 
           pitch_data_coordinates_p_z > 3.47 | pitch_data_coordinates_p_z < 1.5)

swing_at_ball_after <- after_abs %>%
  filter(pitch_data_coordinates_p_x > 0.95 | pitch_data_coordinates_p_x < -0.95 | 
           pitch_data_coordinates_p_z > 3.47 | pitch_data_coordinates_p_z < 1.5)
