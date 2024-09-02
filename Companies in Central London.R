overseas_comp_LDN <- read_csv("/Users/xuanyi/Library/CloudStorage/OneDrive-Personal/Documents/My Goldsmiths/Final Thesis and Project/Project - Rush hour 2/from HM Land Registry/Overseas companies that own property in England and Wales, till June 2024.csv")

overseas_comp_LDN <- `Overseas.companies.that.own.property.in.England.and.Wales,.till.June.2024`
rm(`Overseas.companies.that.own.property.in.England.and.Wales,.till.June.2024`)

str(overseas_comp_LDN)

overseas_comp_LDN <- overseas_comp_LDN %>% 
  filter(Region == 'GREATER LONDON')

overseas_comp_LDN %>% 
  distinct(District)

overseas_comp_CEN <- overseas_comp_LDN %>% 
  filter(District %in% c('CITY OF WESTMINSTER', 'CITY OF LONDON')) %>% 
  select(-Region, -Company.Registration.No...1., 
         -Proprietor..1..Address..2., 
         -Proprietor..1..Address..3.,
         -Company.Registration.No...2.,
         -Proprietorship.Category..2.,
         -Country.Incorporated..2.,
         -Proprietor..2..Address..1.,
         -Proprietor..2..Address..2.,
         -Proprietor..2..Address..3.,
         -Proprietor.Name..3.,
         -Company.Registration.No...3.,
         -Proprietorship.Category..3.,
         -Country.Incorporated..3.,
         -Proprietor..3..Address..1.,
         -Proprietor..3..Address..2.,
         -Proprietor..3..Address..3.,
         -Proprietor.Name..4.,
         -Company.Registration.No...4.,
         -Proprietorship.Category..4.,
         -Country.Incorporated..4.,
         -Proprietor..4..Address..1.,
         -Proprietor..4..Address..2.,
         -Proprietor..4..Address..3.,
         -Proprietor..1..Address..1.,
         -Proprietor.Name..2.,
         -Additional.Proprietor.Indicator
         ) %>% 
  rename(Company.Name = Proprietor.Name..1.,
         Company.Type = Proprietorship.Category..1.,
         From.Country = Country.Incorporated..1.) %>% 
  mutate(Multiple.Address.Indicator = Multiple.Address.Indicator == "Y")

dim(overseas_comp_LDN)
head(overseas_comp_LDN)

central_LDN_postcode <- st_read("/Users/xuanyi/Library/CloudStorage/OneDrive-Personal/Documents/My Goldsmiths/Final Thesis and Project/Project - Rush hour 2/from Ordnance Survey/London Postcodes, EPSG 4236/City, West End, and St. James's/City, West End, and St. James's Postcode.shp") %>% 
  rename(Postcode = postcode)

coord_comp_HIG <- overseas_comp_CEN %>% 
  right_join(central_LDN_postcode %>% select(Postcode, geometry),
             by = "Postcode") %>% 
  filter(!is.na(Company.Name), !is.na(Price.Paid)) %>% 
  group_by(Postcode) %>% 
  slice_max(order_by = Price.Paid, n = 1, with_ties = TRUE) %>% 
  ungroup()

str(coord_comp_HIG)

UK_comp_CEN <- read_csv("Support Files/UK_companies_that_own_property_in_England_and_Wales_till_May.csv", 
                        col_names = FALSE)

UK_comp_CEN <- UK_comp_CEN %>% 
  rename(title.number = X1,
         tenure = X2,
         property.addr = X3,
         district = X4,
         county = X5,
         Postcode = X6,
         multiple.addr = X7,
         price.paid = X8,
         company.name = X9,
         company.reg.no = X10,
         company.categ = X11,
         date.added = X12,
         additional.ind = X13) %>% 
  relocate(additional.ind, .after = company.name) %>% 
  filter(!is.na(Postcode), !is.na(price.paid), !is.na(date.added)) %>% 
  mutate(multiple.addr = multiple.addr == "Y",
         additional.ind = additional.ind == "Y")

dim(UK_comp_CEN)
head(UK_comp_CEN)

coord_comp_HIGUK <- UK_comp_CEN %>% 
  right_join(central_LDN_postcode %>% select(Postcode, geometry),
             by = "Postcode") %>% 
  filter(!is.na(company.name), !is.na(price.paid)) %>% 
  group_by(Postcode) %>% 
  slice_max(order_by = price.paid, n = 1, with_ties = TRUE) %>% 
  ungroup()

str(coord_comp_HIGUK)
