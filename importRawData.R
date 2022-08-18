source("start_env.R")

# field.types argument for initializing database
# for reproduction, set dbWriteTable function for 
# append = FALSE and overwrite = TRUE, as well as 
# field.type = TYPES
TYPES <- list(game_pk = "Int(10)", 
              game_date = "Date",
              index = "Int(10)", 
              start_time = "varchar(100)",
              end_time = "varchar(100)", 
              is_pitch = "Boolean", 
              type = "varchar(100)",
              play_id = "varchar(100)", 
              pitch_number = "Int(10)", 
              details_description = "varchar(100)", 
              details_event = "varchar(100)",
              details_away_score = "Int(10)", 
              details_home_score = "Int(10)",
              details_is_scoring_play = "Boolean", 
              details_has_review = "Boolean",
              details_code = "varchar(4)", 
              details_ball_color = "varchar(100)",
              details_is_in_play = "Boolean", 
              details_is_strike = "Boolean",
              details_is_ball = "Boolean", 
              details_call_code = "varchar(100)",
              details_call_description = "varchar(100)", 
              count_balls_start = "Int(10)",
              count_strikes_start = "Int(10)", 
              count_outs_start = "Int(10)",
              player_id = "Int(10)", 
              player_link = "varchar(100)", 
              pitch_data_strike_zone_top = "double(5,2)", 
              pitch_data_strike_zone_bottom = "double(5,2)",
              details_from_catcher = "boolean",
              pitch_data_coordinates_x = "double(10,2)",
              pitch_data_coordinates_y = "double(10,2)",
              hit_data_trajectory = "varchar(100)", 
              hit_data_hardness = "varchar(100)",
              hit_data_location = "Int(10)", 
              hit_data_coordinates_coord_x = "double(10,2)",
              hit_data_coordinates_coord_y = "double(10,2)",
              action_play_id = "varchar(100)",
              details_event_type = "varchar(100)",
              details_runner_going = "boolean",
              position_code = "Int(10)", 
              position_name = "varchar(100)",
              position_type = "varchar(100)", 
              position_abbreviation = "varchar(100)",
              batting_order = "Int(10)", 
              at_bat_index = "Int(10)",
              result_type = "varchar(100)", 
              result_event = "varchar(100)",
              result_event_type = "varchar(100)", 
              result_description = "varchar(100)",
              result_rbi = "Int(10)", 
              result_away_score = "Int(10)",
              result_home_score = "Int(10)", 
              about_at_bat_index = "Int(10)",
              about_half_inning = "varchar(100)", 
              about_inning = "Int(10)",
              about_start_time = "varchar(100)", 
              about_end_time = "varchar(100)",
              about_is_complete = "boolean", 
              about_is_scoring_play = "boolean",
              about_has_review = "boolean", 
              about_has_out = "boolean",
              about_captivating_index = "Int(10)",
              count_balls_end = "Int(10)", 
              count_strikes_end = "Int(10)",
              count_outs_end = "Int(10)", 
              matchup_batter_id = "Int(10)",
              matchup_batter_full_name = "varchar(100)",
              matchup_batter_link = "varchar(100)", 
              matchup_bat_side_code = "varchar(100)",
              matchup_bat_side_description = "varchar(100)",
              matchup_pitcher_id = "Int(10)", 
              matchup_pitcher_full_name = "varchar(100)",
              matchup_pitcher_link = "varchar(100)", 
              matchup_pitch_hand_code = "varchar(100)",
              matchup_pitch_hand_description = "varchar(100)", 
              matchup_splits_batter = "varchar(100)",
              matchup_splits_pitcher = "varchar(100)", 
              matchup_splits_men_on_base = "varchar(100)",
              batted_ball_result = "varchar(100)", 
              home_team = "varchar(100)", 
              home_level_id = "Int(10)",
              home_level_name = "varchar(100)", 
              home_parent_org_id = "Int(10)",
              home_parent_org_name = "varchar(100)", 
              home_league_id = "Int(10)",
              home_league_name = "varchar(100)", 
              away_team = "varchar(100)",
              away_level_id = "Int(10)", 
              away_level_name = "varchar(100)",
              away_parent_org_id = "Int(10)", 
              away_parent_org_name = "varchar(100)",
              away_league_id = "Int(10)", 
              away_league_name = "varchar(100)",
              batting_team = "varchar(100)", 
              fielding_team = "varchar(100)",
              last_pitch_of_ab = "boolean", 
              pfx_id = "varchar(100)",
              details_trail_color = "varchar(100)", 
              details_type_code = "varchar(100)",
              details_type_description = "varchar(100)", 
              pitch_data_start_speed = "double(10,2)",
              pitch_data_end_speed = "double(10,2)", 
              pitch_data_zone = "Int(10)",
              pitch_data_type_confidence = "double(10,2)", 
              pitch_data_plate_time = "double(10,2)",
              pitch_data_extension = "double(10,2)", 
              pitch_data_coordinates_a_y = "double(10,2)",
              pitch_data_coordinates_a_z = "double(10,2)",
              pitch_data_coordinates_pfx_x = "double(10,2)",
              pitch_data_coordinates_pfx_z = "double(10,2)",
              pitch_data_coordinates_p_x = "double(10,2)",
              pitch_data_coordinates_p_z = "double(10,2)",
              pitch_data_coordinates_v_x0 = "double(10,2)",
              pitch_data_coordinates_v_y0 = "double(10,2)",
              pitch_data_coordinates_v_z0 = "double(10,2)",
              pitch_data_coordinates_x0 = "double(10,2)",
              pitch_data_coordinates_y0 = "double(10,2)",
              pitch_data_coordinates_z0 = "double(10,2)",
              pitch_data_coordinates_a_x = "double(10,2)",
              pitch_data_breaks_break_angle = "double(10,2)",
              pitch_data_breaks_break_length = "double(10,2)",
              pitch_data_breaks_break_y = "Int(10)",
              pitch_data_breaks_spin_rate = "Int(10)",
              pitch_data_breaks_spin_direction = "Int(10)",
              hit_data_launch_speed = "double(10,2)",
              hit_data_launch_angle = "double(10,2)",
              hit_data_total_distance = "double(10,2)",
              injury_type = "varchar(100)",
              umpire_id = "varchar(100)",
              umpire_link = "varchar(100)",
              is_base_running_play = "boolean",
              is_substitution = "boolean",
              about_is_top_inning = "boolean",
              matchup_post_on_first_id = "Int(10)",
              matchup_post_on_first_full_name = "varchar(100)",
              matchup_post_on_first_link = "varchar(100)",
              matchup_post_on_second_id = "Int(10)",
              matchup_post_on_second_full_name = "varchar(100)",
              matchup_post_on_second_link = "varchar(100)",
              matchup_post_on_third_id = "Int(10)",
              matchup_post_on_third_full_name = "varchar(100)",
              matchup_post_on_third_link = "varchar(100)",
              pitch_data_strike_zone_width = "double(10,2)",
              pitch_data_strike_zone_depth = "double(10,2)")


# Initialize mySQL dataframe with field.types & overwrite = true
reno <- as_tibble(importData(season = 2022, team = "Reno Aces"))

#dbSendQuery below fixed the following error: 
#Error in .local(conn, statement, ...) : 
#could not run statement: Loading local 
#data is disabled; this must be enabled on 
#both the client and server sides

dbSendQuery(con, "SET GLOBAL local_infile = true;")
dbWriteTable(con, name = "data", value = reno, 
             row.names = FALSE,
             field.types = TYPES,
             overwrite = TRUE)

###################### TEST QUERY ########################

query <- "
SELECT game_date
FROM data.data
WHERE pitch_data_strike_zone_width = 19.00
;"

dbcomp <- dbGetQuery(con, query)




# sac <- as_tibble(importData(season = 2022, team = "Sacramento River Cats"))
# lv <- as_tibble(importData(season = 2022, team = "Las Vegas Aviators"))
# tac <- as_tibble(importData(season = 2022, team = "Tacoma Rainiers"))
# alb <- as_tibble(importData(season = 2022, team = "Albuquerque Isotopes"))
# rr <- as_tibble(importData(season = 2022, team = "Round Rock Express"))
# okc <- as_tibble(importData(season = 2022, team = "Oklahoma City Dodgers"))
# elp <- as_tibble(importData(season = 2022, team = "El Paso Chihuahuas"))

start <- Sys.time()
#import_and_store(year = 2022, home_team = "Reno Aces")
import_and_store(year = 2022, home_team = "Sacramento River Cats")
import_and_store(year = 2022, home_team = "Las Vegas Aviators")
import_and_store(year = 2022, home_team = "Tacoma Rainiers")
import_and_store(year = 2022, home_team = "Albuquerque Isotopes")
import_and_store(year = 2022, home_team = "Round Rock Express")
import_and_store(year = 2022, home_team = "Oklahoma City Dodgers")
#import_and_store(year = 2022, home_team = "El Paso Chihuahuas")
# elPasoGames <- mlb_schedule(season = 2022, level_ids = "11") %>%
#   filter(teams_home_team_name == "El Paso Chihuahuas") %>%
#   filter(date < today()) %>%
#   select(game_pk)
# 
# elPasoGames <- as_vector(elPasoGames)
# 
# elPaso_pbp <- map_df(elPasoGames, mlb_pbp) 
#   
# %>%
#   select(-base, -replacedPlayer.id, -replacedPlayer.link) %>%
#   clean_names()

end <- Sys.time()
duration <- end - start
 

dbDisconnect(con)