library(gsheet)
library(tidyverse)
library(janitor)


gsheet2tbl("https://docs.google.com/spreadsheets/d/1UDFB4Rny9KS3ENfKooFOAa20mbhzJyn5oC5pU07SLdA/edit#gid=254232109") %>%
  write_csv("osf_report.csv")

osf_report <- read_csv("./osf_report.csv") %>%
  clean_names("snake") %>%
  slice(-1) %>%
  select(key_performance_indicators, definition,
         source, caveats, raw_data_location,
         x2012:x2020_actual, -x2020_target) %>%
  rename(x2018 = x2018_actual,
         x2019 = x2019_actual,
         x2020 = x2020_actual) %>%
  slice(1:25) %>%
  glimpse()


