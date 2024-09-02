library(dplyr)
library(readr)
library(purrr)

assign_headers_PP <- function(PP_noHeaderPath, columnFORpp) {
  df <- read_csv(PP_noHeaderPath, col_names = FALSE)
  names(df) <- columnFORpp
  return(df)
}

PP_noHeaderPath <- c(
  "C:\\Users\\zephy\\Downloads\\without headers\\City of Westminster.csv",
  "C:\\Users\\zephy\\Downloads\\without headers\\City of London.csv",
  "C:\\Users\\zephy\\Downloads\\without headers\\Croydon.csv",
  "C:\\Users\\zephy\\Downloads\\without headers\\Harrow.csv",
  "C:\\Users\\zephy\\Downloads\\without headers\\Barnet.csv"
)

columnFORpp <- c(
  "unique_id",
  "price_paid",
  "deed_date",
  "postcode",
  "property_type",
  "new_build",
  "estate_type",
  "saon",
  "paon",
  "street",
  "locality",
  "town",
  "district",
  "county",
  "transaction_category",
  "linked_data_uri")

data_list <- lapply(PP_noHeaderPath, assin_headers_PP, columnFORpp = columnFORpp)
head(data_list)

combined_PP <- bind_rows(data_list)

aggregate_PP <- combined_PP %>% 
  group_by(postcode) %>% 
  summarise(
    ids_property = paste(unique(unique_id), collapse = ", "),
    total_price = sum(price_paid, na.rm = TRUE),
    average_price = mean(price_paid, na.rm = TRUE),
    num_properties = n(),
    property_types = paste(unique(property_type), collapse = ", "),
    new_builds = sum(new_build == "Y", na.rm = TRUE),
    streets = paste(unique(street), collapse = ", "),
    districts = paste(unique(district), collapse = ", "),
    firstline = paste(unique(saon), collapse = ", "),
    secondline = paste(unique(paon), collapse = ", ")
  )

write_csv(aggregate_PP, file = "Price Paid data in City, Westminster, Croydon, Harrow, and Barnet in 2023.csv")

rm(data_list, columnFORpp, PP_noHeaderPath, assin_headers_PP)