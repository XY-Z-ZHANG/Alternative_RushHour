#
url_for_oub_Nbuses <- c("https://api.tfl.gov.uk/Line/n1/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n2/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n3/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n5/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n7/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n8/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n9/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n11/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n15/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n18/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n19/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n20/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n21/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n22/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n25/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n26/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n27/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n28/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n29/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n31/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n32/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n33/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n38/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n41/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n44/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n53/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n55/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n63/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n65/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n68/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n72/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n73/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n74/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n83/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n86/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n87/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n89/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n91/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n97/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n98/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n109/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n113/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n133/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n136/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n137/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n140/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n155/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n171/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n199/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n205/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n207/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n242/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n250/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n253/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n266/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n271/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n277/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n279/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n343/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n381/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n550/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true",
                        "https://api.tfl.gov.uk/Line/n551/Route/Sequence/outbound?serviceTypes=Regular&excludeCrowding=true")

# use the same method when pull inbound data
## generate a function to get data from multiple API urls at once
interim_batch_oub <- lapply(url_for_oub_Nbuses, function(batch2) {
  interim2 <- GET(batch2)
  stop_for_status(interim2)
  content(interim2, as = "text", encoding = "UTF-8") %>% 
    fromJSON(flatten = FALSE)
})
interim_bat_oub <- interim_batch_oub
## check the structure of this data list
colnames(interim_batch_oub)

# extract the "StopPointSequences" data frame from the "interim_batch_oub
stop_point_sequences_oub <- lapply(interim_bat_oub, function(x) x$stopPointSequences)
stop_point_sequences_oub_df <- do.call(rbind, stop_point_sequences_oub)
## check the structure of the data frame
str(stop_point_sequences_df)

# extract the data this project needs, which lies in the "stopPoint" column and use the lineId column as identifier
stopPoint_oub <- stop_point_sequences_oub_df %>% 
  select(lineId, stopPoint)
## check the structure of the data frame
str(stopPoint_oub)

# expand the "stopPoint" column
semi_oub_Nbuses <- unnest(stopPoint_oub, stopPoint)
## create a new colmn to indicate the direction and adjust its position
semi_oub_Nbuses <- semi_oub_Nbuses %>% 
  mutate(direction = "outbound")
semi_oub_Nbuses <- semi_oub_Nbuses %>% 
  select(lineId, parentId, stationId, icsId, topMostParentId, direction, everything())

# delete unnecessary columns
cln_Nbuses_oub_stops <- semi_oub_Nbuses %>% 
  select(-`$type`, -modes, -lines, -status, -zone)

# clear unnecessery data in the global environment
rm(interim_batch_oub, semi_oub_Nbuses, stop_point_sequences_oub, stop_point_sequences_oub_df, stopPoint_oub)

# export the data into a csv file
write_csv(cln_Nbuses_oub_stops, file = "All Night Buses Outbound Stops Sequentially.csv")

# merge outbound and inbound data frames
inbANDoub_Nbuses <- bind_rows(cln_Nbuses_inb_stops, cln_Nbuses_oub_stops) %>% 
  arrange(lineId, direction) %>% 
  mutate(lineId = toupper(lineId))
## check the structure of the data frame
str(inbANDoub_Nbuses)

# export the merged data into a csv file
write_csv(inbANDoub_Nbuses, file = "All Night Buses Stops Sequentially.csv")