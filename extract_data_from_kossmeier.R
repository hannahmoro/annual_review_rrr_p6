library(tidyverse)
library(janitor)

kossmeier <- read_delim("./Kossmeier_npact_data.csv", delim = ";") %>%
  clean_names("snake") %>%
  glimpse()

#creating data to add to other N-pact factor data
kossmeier %>%
  filter(included_in_analysis == "1") %>% #see codebook https://osf.io/kcuyj/
  group_by(journal, publ_yr) %>%
  summarize(median_N = median(n_for_analysis)) %>%
  mutate(
    source = "Kossmeier et al. (2019)",
    research_area = "personality",
    journal = case_when(
      journal == "JID" ~ "Journal of Individual Differences",
      journal == "PAID" ~ "Personality and Individual Differences"),
    year = publ_yr,
    estimate_type = "median N",
    estimate = median_N) %>%
  select(source, research_area, journal, year, estimate_type, estimate) %>%
  write_csv("kossmeier_extracted_npact_data.csv")
