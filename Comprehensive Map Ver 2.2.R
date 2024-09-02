library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(scico)
library(viridis)
library(htmltools)

# Load and prepare data
## read coordinates of bus stops
coord_Nbustops <- st_as_sf(inbANDoub_Nbuses, coords = c("lon", "lat"), crs = 4326)
## read all London wards, LSOAs, locations for transactions, and company information
wards <- st_read("/Users/xuanyi/Library/CloudStorage/OneDrive-Personal/Documents/My Goldsmiths/Final Thesis and Project/Project - Rush hour 2/Alternative Rush Hour/Support Files/London Wards, 2021, EPSG 4236/London Ward, 2021, EPSG 4236.shp")
lsoas <- st_read("/Users/xuanyi/Library/CloudStorage/OneDrive-Personal/Documents/My Goldsmiths/Final Thesis and Project/Project - Rush hour 2/Alternative Rush Hour/Support Files/London LSOA, 2021, EPSG 4236/London LSOA, 2021.shp")
deprivation <- st_read("/Users/xuanyi/Library/CloudStorage/OneDrive-Personal/Documents/My Goldsmiths/Final Thesis and Project/Project - Rush hour 2/Alternative Rush Hour/Support Files/London 2011 LSOA with 2019 ID Survey/London 2011  LSOA with 2019 ID survey.shp")
locations <- st_read("/Users/xuanyi/Library/CloudStorage/OneDrive-Personal/Documents/My Goldsmiths/Final Thesis and Project/Project - Rush hour 2/Alternative Rush Hour/Support Files/Locations that has a transaction in 2023, sort by postcodes/In shapes/Buildings that has transactions in 2023 in City, West End, St. James, Edgware, and Croydon.shp")
company_UK <- coord_comp_HIGUK
company_OS <- coord_comp_HIG

# Remove duplicate bus stops based on stationId
coord_Nbustops_unique <- coord_Nbustops %>% 
  distinct(stationId, .keep_all = TRUE)

# For wards
wards_aggr <- wards %>%
  mutate(
    bus_stop_count = lengths(st_intersects(., coord_Nbustops_unique)),
  ) %>% 
  select(-WD24NMW) %>% 
  rename(ward_name = WD24NM, ward_code = WD24CD) %>% 
  mutate(bus_stop_count = as.numeric(bus_stop_count))

# For LSOAs
lsoas_aggr <- lsoas %>%
  mutate(
    bus_stop_count = lengths(st_intersects(., coord_Nbustops_unique)),
  ) %>% 
  rename(lsoa_name = LSOA21NM, lsoa_code = LSOA21CD) %>% 
  mutate(bus_stop_count = as.numeric(bus_stop_count))

# for deprivations
deprivation_aggr <- deprivation %>% 
  select(-MSOA11CD, -MSOA11NM,
         -LAD11CD, -LAD11NM,
         -RGN11CD, -RGN11NM,
         -ID_LSOA.na, -ID_Local.A, -ID_Local_1,
         -ID_Index_2, -ID_Income, -ID_Incom_2,
         -ID_Employm, -ID_Emplo_2,
         -ID_Educati, -ID_Educa_2,
         -ID_Health, -ID_Healt_2,
         -ID_Crime.S, -ID_Crime.D,
         -ID_Barrier, -ID_Barri_2,
         -ID_Living, -ID_Livin_2) %>% 
  rename(usual_residents = USUALRES,
         household_residents = HHOLDRES,
         communal_esta_residents = COMESTRES,
         population_density = POPDEN,
         numf_households = HHOLDS,
         aver_household_size = AVHHOLDSZ,
         LSOA_code = LSOA11CD,
         LSOA_name = LSOA11NM) %>% 
  rename(IMD_score = ID_Index.o,
         IMD_rank = ID_Index_1,
         IMD_rank_inc = ID_Incom_1,
         IMD_rank_emp = ID_Emplo_1,
         IMD_rank_edu = ID_Educa_1,
         IMD_rank_hea = ID_Healt_1,
         IMD_rank_cri = ID_Crime.R,
         IMD_rank_hou = ID_Barri_1,
         IMD_rank_liv = ID_Livin_1
  )

# for transacttions
## create a function to expand unreadable abbreviations
expand_property_type <- function(abbr) {
  case_when(
    abbr == "F" ~ "Flat",
    abbr == "T" ~ "Terraced",
    abbr == "O" ~ "Other",
    abbr == "S" ~ "Semi-detached",
    abbr == "D" ~ "Detached",
    TRUE ~ abbr  # This will keep any unmatched abbreviations as they are
  )
}
# claen the location data
locations_aggr <- locations %>% 
  select(-layer, -layer_2, -path, -path_2, -admin_coun) %>% 
  mutate(PP_propert = sapply(strsplit(PP_propert, ", "), function(x) {
    paste(sapply(x, expand_property_type), collapse = ", ")
  })) %>% 
  rename(PP_ids = PP_ids_pro,
         PP_postcode = PP_postcod,
         total_price = PP_total_p,
         average_price = PP_average,
         num_properties = PP_num_pro,
         property_type = PP_propert,
         new_built_count = PP_new_bui,
         street = PP_streets,
         boroughs = PP_distric,
         first_line = PP_firstli,
         second_line = PP_secondl
  ) %>% 
  mutate(total_price = as.numeric(total_price),
         average_price = as.numeric(average_price),
         new_built_count = as.numeric(new_built_count),
         has_new_builds = new_built_count > 0) %>% 
  relocate(has_new_builds, .after = new_built_count) %>% 
  st_zm()

# custom intervals for colour pallettes
max_bustops_wards <- max(wards_aggr$bus_stop_count, na.rm = TRUE)
breaks_wards <- seq(0, max_bustops_wards, by = 4)
colors_wards <- viridis(n = length(breaks_wards) - 1, option = "viridis")

max_bustops_lsoas <- max(lsoas_aggr$bus_stop_count, na.rm = TRUE)
break_lsoas <- seq(0, max_bustops_lsoas, by = 2)
colors_lsoa <- viridis(n = length(break_lsoas) - 1, option = "viridis")

max_busstops_deprivation <- max(deprivation_aggr$IMD_rank_inc, na.rm = TRUE)
breaks_deprivation <- seq(0, max_busstops_deprivation, by = 5000)
color_deprivation <- rev(scico(n = length(breaks_deprivation), palette = "vik"))

max_busstops_price <- max(locations_aggr$average_price, na.rm = TRUE)
breaks_price <- seq(0, max_busstops_price, by = 7000000)
colors_price <- viridis(n = length(breaks_price) - 1, option = "plasma")

# create a application using shiny application
ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      html, body {height: 100%;}
      #map {height: calc(100vh - 50px) !important;}
      #controls {
        position: absolute;
        top: 10px;
        right: 10px;
        padding: 10px;
        background: white;
        z-index: 1000;
        border-radius: 5px;
        box-shadow: 0 0 15px rgba(0,0,0,0.2);
      }
    "))
  ),
  titlePanel("How London's Night Bus Service Is a Portal to Observe the City"),
  div(id = "controls",
      radioButtons(inputId = "view",
                   label = "Select Portal:",
                   choices = c("Wards", "LSOAs", "Deprivation Index by Income", "Price Paid to Live", "Price Paid to Work (under construction)", "Plain Map"),
                   selected = "Wards"),
  ),
  leafletOutput("map")
)

server <- function(input, output, session) {
  print("Server function started")
  
  # Create color palettes based on bus_stop_count and average_price
  print("Creating color palettes")
  pal_wards_aggr <- colorBin(colors_wards, domain = wards_aggr$bus_stop_count, bins = breaks_wards)
  pal_lsoas_aggr <- colorBin(colors_lsoa, domain = lsoas_aggr$bus_stop_count, bins = break_lsoas)
  pal_locations_aggr <- colorBin(colors_price, domain = locations_aggr$average_price, bins = breaks_price)
  pal_deprivatio_aggr <- colorNumeric(color_deprivation, domain = deprivation_aggr$IMD_rank_inc)
  
  print("Color palettes created")
  
  output$map <- renderLeaflet({
    print("Rendering leaflet")
    tryCatch({
      # Start with a basic map
      m <- leaflet(options = leafletOptions(minZoom = 10)) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        setView(lng = -0.1276, lat = 51.5074, zoom = 10)
      
      print("Basic map created")
      
      # Add Wards layer
      m <- m %>% addPolygons(data = wards_aggr, group = "Wards",
                             fillColor = ~pal_wards_aggr(bus_stop_count),
                             fillOpacity = 0.7, weight = 1, color = "white",
                             label = ~lapply(paste("Ward Name:", ward_name,
                                                   "<br>Number of Bus Stops:", bus_stop_count), HTML),
                             labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "2px 6px"),
                                                         textsize = "11px", direction = "auto"),
                             highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE),
                             layerId = ~ward_code)
      
      print("Wards layer added")
      
      # Add LSOAs layer
      m <- m %>% addPolygons(data = lsoas_aggr, group = "LSOAs",
                             fillColor = ~pal_lsoas_aggr(bus_stop_count),
                             fillOpacity = 0.7, weight = 1, color = "white",
                             label = ~lapply(paste("LOSA Name:", lsoa_name,
                                                   "<br>Number of Bus Stops:", bus_stop_count), HTML),
                             labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "2px 6px"),
                                                         textsize = "11px", direction = "auto"),
                             highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE),
                             layerId = ~lsoa_code)
      
      print("LSOAs layer added")
      
      # add deprivation layer
      m <- m %>% addPolygons(data = deprivation_aggr, group = "Deprivation Index by Income",
                             fillColor = ~pal_deprivatio_aggr(IMD_rank_inc),
                             fillOpacity = 0.7, weight = 1, color = "white",
                             label = ~lapply(paste("Indexed Area:", LSOA_name,
                                                   "<br>Income Ranking:", IMD_rank_inc), HTML),
                             labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "2px 6px"),
                                                         textsize = "12px", direction = "auto"),
                             highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE),
                             layerId = ~LSOA_name)
      
      print("deprivation layer added")
      
      # Add Price Paid to Live layer
      m <- m %>% addPolygons(data = locations_aggr, group = "Price Paid to Live",
                             fillColor = ~pal_locations_aggr(average_price),
                             fillOpacity = 0.7, weight = 1, color = "white",
                             label = ~lapply(paste("Price Paid to Live:", formatC(average_price, format = "f", big.mark = ",", digits = 0),
                                                   "<br>Residential Type:", property_type,
                                                   "<br>Postcode:", PP_postcode), HTML),
                             labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "2px 6px"),
                                                         textsize = "12px", direction = "auto"),
                             highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE),
                             layerId = ~PP_postcode)
      
      print("Price Paid to Live layer added")
      
      m <- m %>% 
        hideGroup("LSOAs") %>% 
        hideGroup("Price Paid to Live") %>% 
        hideGroup("Deprivation Index by Income")
      
      print("Groups hidden")
      
      return(m)
      
    }, error = function(e) {
      print(paste("Error in renderLeaflet:", e$message))
      print(traceback())
      return(NULL)
    })
    m %>% 
      hideGroup("LSOAs") %>% 
      hideGroup("Deprivation Index by Income") %>% 
      hideGroup("Price Paid to Live")
  })
  
  print("Leaflet rendered")
  
  observe({
    print(paste("Current view:", input$view))  # Debug print
    switch(input$view,
           "Wards" = {
             leafletProxy("map") %>%
               showGroup("Wards") %>%
               hideGroup("LSOAs") %>%
               hideGroup("Deprivation Index by Income") %>% 
               hideGroup("Price Paid to Live") %>% 
               clearControls() %>%
               addLegend("bottomright", pal = pal_wards_aggr, values = wards_aggr$bus_stop_count,
                         title = "Number of Bus Stops in Each Ward",
                         labFormat = labelFormat(prefix = ""),
                         bins = breaks_wards,
                         na.label = "N/A")
           },
           "LSOAs" = {
             leafletProxy("map") %>%
               showGroup("LSOAs") %>%
               hideGroup("Wards") %>%
               hideGroup("Deprivation Index by Income") %>% 
               hideGroup("Price Paid to Live") %>% 
               clearControls() %>%
               addLegend("bottomright", pal = pal_lsoas_aggr, values = lsoas_aggr$bus_stop_count,
                         title = "Number of Bus Stops in Each LSOA",
                         labFormat = labelFormat(prefix = ""),
                         bins = break_lsoas,
                         na.label = "N/A")
           },
           "Deprivation Index by Income" = {
             leafletProxy("map") %>% 
               hideGroup("Wards") %>% 
               hideGroup("LSOAs") %>% 
               showGroup("Deprivation Index by Income") %>% 
               hideGroup("Price Paid to Live") %>% 
               clearControls() %>% 
               addLegend("bottomright", pal = pal_deprivatio_aggr, values = deprivation_aggr$IMD_rank_inc,
                         title = "Income Deprivation Ranking (smaller number = less income)",
                         labFormat = labelFormat(prefix = ""),
                         bins = breaks_deprivation,
                         na.label = "N/A")
           },
           "Plain Map" = {
             leafletProxy("map") %>%
               hideGroup("Wards") %>%
               hideGroup("LSOAs") %>%
               hideGroup("Deprivation Index by Income") %>%
               hideGroup("Price Paid to Live") %>% 
               clearControls() %>%
               setView(lng = -0.1276, lat = 51.5074, zoom = 12)
           },
           "Price Paid to Live" = {
             leafletProxy("map") %>% 
               hideGroup("Wards") %>% 
               hideGroup("LSOAs") %>% 
               hideGroup("Deprivation Index by Income") %>% 
               showGroup("Price Paid to Live") %>% 
               clearControls() %>% 
               addLegend("bottomright", pal = pal_locations_aggr, values = locations_aggr$average_price,
                         title = "Average Price Paid to Live in 2023",
                         labFormat = labelFormat(prefix = "£", big.mark = ","),
                         bins = breaks_price,
                         na.label = "N/A")
           }
    )
  })
  
  observeEvent(input$map_shape_click, {
    click <- input$map_shape_click
    print(paste("Clicked:", click$id))  # Debug print
    if (is.null(click) || is.na(click$id))
      return()
    
    clicked_id <- click$id
    if (input$view == "Wards") {
      clicked_area <- wards_aggr[wards_aggr$ward_code == clicked_id, ]
      print(paste("Clicked ward:", clicked_id))  # Debug print
    } else if (input$view == "LSOAs") {
      clicked_area <- lsoas_aggr[lsoas_aggr$lsoa_code == clicked_id, ]
      print(paste("Clicked LSOA:", clicked_id))  # Debug print
    } else if (input$view == "Deprivation Index by Income") {
      clicked_area <- deprivation_aggr[deprivation_aggr$LSOA_code == clicked_id, ]
      print(paste("Clicked Deprivation Index by Income area:", clicked_id))
    } else if (input$view == "Price Paid to Live") {
      clicked_area <- locations_aggr[locations_aggr$PP_postcode == clicked_id, ]
      print(paste("Clicked Price Paid to Live area:", clicked_id))
    } else {
      print("Clicked area not recognised")
      return()
    }
    
    if (nrow(clicked_area) == 0) {
      warning("Clicked area not found in the data")
      return()
    }
    
    bbox <- try(st_bbox(clicked_area), silent = TRUE)
    if (inherits(bbox, "try-error")) {
      warning("Error in calculating bounding box of clicked area")
      return()
    }
    
    center_lng <- (bbox["xmin"] + bbox["xmax"]) / 2
    center_lat <- (bbox["ymin"] + bbox["ymax"]) / 2
    
    print(paste("Zooming to:", center_lng, center_lat))  # Debug print
    
    leafletProxy("map") %>%
      setView(lng = as.numeric(center_lng), lat = as.numeric(center_lat), zoom = 14)
  })
}

shinyApp(ui = ui, server = server)
