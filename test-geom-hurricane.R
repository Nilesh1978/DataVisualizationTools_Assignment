#Be sure to restart the session in order to be sure that
#to have a clean session
library(magrittr)
source("./geom-hurricane.R")

#get the storm observation from cleaned data
data_hurricane <- readr::read_csv(file = "./data/ebtrk_atlc_1988_2015.cleaned.txt")
data_hurricane$wind_speed <- as.factor(data_hurricane$wind_speed)

storm_observation_ike <- data_hurricane[data_hurricane$storm_id == "IKE-2008" & 
                                      data_hurricane$date == lubridate::ymd_hms("2008-09-11 18:00:00"),]

storm_observation_ike_next <- data_hurricane[data_hurricane$storm_id == "IKE-2008" & 
                                          data_hurricane$date == lubridate::ymd_hms("2008-09-12 06:00:00"),]

png("hurricane_ike_2_observations.png")
map_plot <- ggmap::get_map("Lousiana", zoom = 5, maptype = "toner-background") 

map_plot %>%
  ggmap::ggmap(extent = "device") +
  geom_hurricane(data = storm_observation_ike,
                 ggplot2::aes(x = longitude, y = latitude, 
                     r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                     color = wind_speed, fill = wind_speed),scale_radii = 0.9) +
  geom_hurricane(data = storm_observation_ike_next,
                 ggplot2::aes(x = longitude, y = latitude, 
                              r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                              color = wind_speed, fill = wind_speed),scale_radii = 0.9) +
  ggplot2::scale_color_manual(name = "Wind speed (kts)", 
                     values = c("red", "orange", "yellow")) + 
  ggplot2::scale_fill_manual(name = "Wind speed (kts)", 
                    values = c("red", "orange", "yellow"))
dev.off()

png("hurricane_ike_observation.png")
map_plot <- ggmap::get_map("Lousiana", zoom = 5, maptype = "toner-background") 
map_plot %>%
  ggmap::ggmap(extent = "device") +
  geom_hurricane(data = storm_observation_ike,
                 ggplot2::aes(x = longitude, y = latitude, 
                              r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                              color = wind_speed, fill = wind_speed)) +
  ggplot2::scale_color_manual(name = "Wind speed (kts)", 
                              values = c("red", "orange", "yellow")) + 
  ggplot2::scale_fill_manual(name = "Wind speed (kts)", 
                             values = c("red", "orange", "yellow"))
dev.off()