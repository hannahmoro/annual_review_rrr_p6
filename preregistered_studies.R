#preregistered study analyses

library(tidyverse)
library(janitor)

#completed registered reports
osf_prereg <- read_csv("./OSF_preregistered_studies.csv") %>%
  clean_names("snake") %>%
  filter(item_type == "journalArticle") %>%
  select(publication_year, contains("date"), everything()) %>%
  glimpse()

osf_prereg %>%
  tabyl(publication_year)

#need to update this database

