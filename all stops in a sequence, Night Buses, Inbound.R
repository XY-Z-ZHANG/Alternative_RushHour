# create a variable to hold urls for the API contains the sequemce of stops for all the night buses
url_for_inb_Nbuses <- c("https://api.tfl.gov.uk/Line/n1/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n2/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n3/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n5/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n7/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n8/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n9/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n11/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n15/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n18/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n19/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n20/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n21/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n22/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n25/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n26/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n27/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n28/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n29/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n31/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n32/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n33/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n38/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n41/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n44/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n53/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n55/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n63/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n65/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n68/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n72/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n73/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n74/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n83/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n86/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n87/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n89/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n91/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n97/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n98/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n109/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n113/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n133/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n136/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n137/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n140/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n155/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n171/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n199/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n205/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n207/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n242/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n250/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n253/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n266/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n271/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n277/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n279/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n343/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n381/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n550/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n551/Route/Sequence/inbound?serviceTypes=Regular&excludeCrowding=true")

# pull the data from aboved listed urls
interim_batch <- lapply(url_for_inb_Nbuses, function(batch) {
  interim <- GET(batch)
  stop_for_status(interim)
  content(interim, as = "text", encoding = "UTF-8") %>% 
    fromJSON(flatten = FALSE)
})
interim_bat_inb <- interim_batch

# 
stop_point_sequences_inb <- lapply(interim_bat_inb, function(x) x$stopPointSequences)
stop_point_sequences_inb_df <- do.call(rbind, stop_point_sequences_inb)

#
colnames(stop_point_sequences_inb_df)

#
stopPoint_inb <- stop_point_sequences_inb_df %>% 
  select(lineId, stopPoint)
## check the structure of the data frame
str(stopPoint_inb)

# expand the "stopPoint" column
semi_inb_Nbuses <- unnest(stopPoint_inb, stopPoint)
## create a new colmn to indicate the direction and adjust its position
semi_inb_Nbuses <- semi_inb_Nbuses %>% 
  mutate(direction = "inbound")
semi_inb_Nbuses <- semi_inb_Nbuses %>% 
  select(lineId, parentId, stationId, icsId, topMostParentId, direction, everything())

# delete unnecessary columns
cln_Nbuses_inb_stops <- semi_inb_Nbuses %>% 
  select(-`$type`, -lines, -zone, -hasDisruption, -modes, -status)
## check the structure of the data frame
str(cln_Nbuses_inb_stops)

# clear unnecessery data in the global environment
rm(interim_batch, stop_point_sequences_inb_df, stop_point_sequences_inb, stopPoint_inb, semi_inb_Nbuses)

# export the data frame into csv by using the readr package in the tidyverse
write_csv(cln_Nbuses_inb_stops, file = "All Night Buses Inbound Stops Sequentially.csv")
