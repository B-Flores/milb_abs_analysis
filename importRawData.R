source("start_env.R")
library(DBI)

con <- dbConnect(RMySQL::MySQL(),
                  dbname = "data",
                  host = "localhost",
                  port = 3306,
                  user = "root",
                  password = key_get("DB_PWD"))

dbDisconnect(con)


# Initialize mySQL dataframe with field.types & overwrite = true
reno <- as_tibble(importData(season = 2022, team = "Reno Aces"))

dbWriteTable(con, name = "data", value = reno, 
             row.names = FALSE,
             field.types = TYPES,
             overwrite = TRUE)

#################################################################
import_and_store <- function(year, home_team){
  temp <- as_tibble(importData(season = year, team = home_team))
  
  dbWriteTable(con, name = "data", value = temp, 
               row.names = FALSE,
               append = TRUE)
}
# query <- "
# SELECT *
# FROM data.data
# ;"
# 
# dbcomp <- dbGetQuery(con, query)

# sac <- as_tibble(importData(season = 2022, team = "Sacramento River Cats"))
# lv <- as_tibble(importData(season = 2022, team = "Las Vegas Aviators"))
# tac <- as_tibble(importData(season = 2022, team = "Tacoma Rainiers"))
# alb <- as_tibble(importData(season = 2022, team = "Albuquerque Isotopes"))
# rr <- as_tibble(importData(season = 2022, team = "Round Rock Express"))
# okc <- as_tibble(importData(season = 2022, team = "Oklahoma City Dodgers"))
# elp <- as_tibble(importData(season = 2022, team = "El Paso Chihuahuas"))


start <- Sys.time()
#import_and_store(year = 2022, home_team = "Sacramento River Cats")
import_and_store(year = 2022, home_team = "Las Vegas Aviators")
import_and_store(year = 2022, home_team = "Tacoma Rainiers")
import_and_store(year = 2022, home_team = "Albuquerque Isotopes")
import_and_store(year = 2022, home_team = "Round Rock Express")
import_and_store(year = 2022, home_team = "Oklahoma City Dodgers")
import_and_store(year = 2022, home_team = "El Paso Chihuahuas")
end <- Sys.time()
duration <- end - start
duration
