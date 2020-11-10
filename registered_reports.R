#registered report analyses

library(tidyverse)
library(janitor)

#completed registered reports
osf_rrs <- read_csv("./OSF_RRs.csv") %>%
  clean_names("snake") %>%
  filter(item_type == "journalArticle") %>%
  select(publication_year, contains("date"), everything()) %>%
  glimpse()

osf_rrs %>%
  tabyl(publication_year)

#need to update this database

#stage one registered reports
osf_rr_registrations <- read_csv("./OSF_RR_registrations.csv") %>%
  clean_names("snake") %>%
  select(publication_year, contains("date"), everything()) %>%
  glimpse()

osf_rr_registrations %>%
  tabyl(publication_year)

#need to update this database
