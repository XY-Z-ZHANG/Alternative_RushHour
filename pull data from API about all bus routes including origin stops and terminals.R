# create a variable and pull the data from APIs to the variable by using httr package
allroutes_including_tubes <- httr::GET("https://api.tfl.gov.uk/Line/Route?serviceTypes=Regular")
allroutes_for_buses <- httr::GET("https://api.tfl.gov.uk/Line/Mode/bus/Route?serviceTypes=Regular")
# to check if the data is correctly pulled
str(allroutes_including_tubes)
str(allroutes_including_tubes$content)
str(allroutes_for_buses)
str(allroutes_for_buses$content)

# convert the data to text and check if it is correctly converted
content_allroutes_inc_tubes <- httr::content(allroutes_including_tubes, as = "text")
str(content_allroutes_inc_tubes)
content_allroutes_for_buses <- httr::content(allroutes_for_buses, as = "text")
str(content_allroutes_for_buses)

# convert the data from json file into a readable R dataframe by using jsonlite package
# please note, the dataframe this chunk of code are not exportable because it contains lists
readable_allroutes_inc_tubes <- jsonlite::fromJSON(content_allroutes_inc_tubes)
View(readable_allroutes_inc_tubes)
readable_allroutes_for_buses <- jsonlite::fromJSON(content_allroutes_for_buses)
View(allroutes_for_buses)

# to check the structures of the readable dataframe
colnames(readable_allroutes_inc_tubes)
str(readable_allroutes_inc_tubes)
head(readable_allroutes_inc_tubes)
colnames(readable_allroutes_for_buses)
str(readable_allroutes_for_buses)
head(readable_allroutes_for_buses)

## extract certain column in the data fram and check if the extracted column is a vector
# num_of_ids <- readable_allroutes_for_buses[, 2]
# class(num_of_ids)
# is.vector(num_of_ids)

# expand the column as lists and named as "routeSection" into the readable_allroutes_for_buses
# the _ in the "names_sep = "_", appends the _ and the original column name to the conflicting column names from the nested data frames.
full_routesForbuses <- unnest(readable_allroutes_for_buses, cols = c(routeSections, serviceTypes), names_sep = "_")

# delete unnecessary columns
cln1_allBusroutes <- full_routesForbuses %>% 
  select(-`$type`, -disruptions, -lineStatuses, -`routeSections_$type`, -`serviceTypes_$type`, -serviceTypes_name, -crowding)

# rename columns to be more readable
all_Bus_routes <- cln1_allBusroutes %>% 
  rename(routes = name, 
         name = routeSections_name, 
         direction = routeSections_direction, 
         originStop = routeSections_originationName, 
         terminal = routeSections_destinationName, 
         originator = routeSections_originator, 
         destination = routeSections_destination,
         serviceType = routeSections_serviceType,
         vaildTo = routeSections_validTo,
         vaildFrom = routeSections_validFrom,
         URL = serviceTypes_uri
         )

# clean unneeded data frames
rm(cln1_allBusroutes)
rm(cln1_routeSection_buses)
rm(full_routesForbuses)

# export the data frame into csv by using the readr package in the tidyverse
write_csv(all_Bus_routes, file = "all bus routes.csv")

## use 
# unlist_allroutes_for_buses <- readable_allroutes_for_buses$routeSections
# class(unlist_allroutes_for_buses)
# str(unlist_allroutes_for_buses)
# combined_routeSections_buses <- bind_rows(lapply(unlist_allroutes_for_buses, 
#                                                  as.data.frame), 
#                                           .id = "group")

## delete unnecessary columns: $type
# cln1_routeSection_buses <- combined_routeSections_buses %>% 
#   select(-`$type`)
# View(cln1_routeSection_buses)

# semi_fin_allroutes_inc_tubes <- combined_allroutes_inc_tubes %>% 
#   rename(routes = group)

# rm1_semi <- semi_fin_allroutes_inc_tubes %>% 
#   select(-`$type`)

unlist2_allroutes_inc_tubes <- readable_allroutes_inc_tubes$serviceTypes
combined2_allroutes_inc_tubes <- bind_rows(lapply(unlist2_allroutes_inc_tubes, as.data.frame), 
                                          .id = "group")

semi_fin_service_types <- combined2_allroutes_inc_tubes %>% 
  rename(routes = group)

rm2_semi <- semi_fin_service_types %>% 
  select(-`$type`)

final_sub_routeSections <- final_sub_allroutes_inc_tube
rm(final_sub_allroutes_inc_tube)

final_sub_serviceTypes <- rm2_semi
rm(rm2_semi)
rm(semi_fin_service_types)
rm(unlist2_allroutes_inc_tubes)
rm(combined2_allroutes_inc_tubes)

edit2_allroutes <- readable_allroutes_inc_tubes %>% 
  select(-`routeSections`)

semi_allroutes <- readable_allroutes_inc_tubes %>% 
  select(-`routeSections`, `serviceTypes`)

rm(semi_allroutes)
rm(edit2_allroutes)

semi_allroutes <- readable_allroutes_inc_tubes %>% 
  select(-`routeSections`, -`serviceTypes`)

combined_allroutes_sub <- inner_join(final_sub_routeSections, final_sub_serviceTypes, 
                                     by = c("routes"))

unique_combined_allroutes_sub <- unique(combined_allroutes_sub)
rm(unique_combined_allroutes_sub)

line_status <- readable_allroutes_inc_tubes$lineStatuses
lookup_lineStatus <- bind_rows(lapply(line_status, as.data.frame), 
                                           .id = "group")

rm(line_status, lookup_lineStatus)

semi_allroutes <- readable_allroutes_inc_tubes %>% 
  select(-`routeSections`, -`serviceTypes`, -`lineStatuses`, -`disruptions`)

disprutions <- readable_allroutes_inc_tubes$disruptions
lookup_disruptions <- bind_rows(lapply(disprutions, as.data.frame), 
                               .id = "group")

rm(disprutions, lookup_disruptions)

