#updating the coding sheet

library(tidyverse)
library(janitor)

library(tidyverse)
library(janitor)
library(stringr)


# making the coding sheet -------------------------------------------------

laura <- read_csv("Laura.csv") %>%
  mutate(coder = "laura")
joe <- read_csv("Joe.csv") %>%
  mutate(coder = "joe")
hannah <- read_csv("Hannah.csv") %>%
  mutate(coder = "hannah")

coding_sheet <- bind_rows(hannah, joe) %>%
  bind_rows(laura) %>%
  clean_names("snake") %>%
  mutate(first_author = str_extract(author, "^[[:alpha:]]*")) %>%
  mutate(notes = str_remove(str_remove(notes, "<p>"), "</p>")) %>%
  select(coder, url, first_author, publication_year, notes) %>%
  mutate(
    publication_year = as.character(publication_year),
    relevant = as.character(NA),
    relevant_reason = as.character(NA),
    qrp_1 = as.character(NA),
    qrp_2 = as.character(NA),
    qrp_3 = as.character(NA),
    qrp_4 = as.character(NA),
    qrp_5 = as.character(NA),
    qrp_6 = as.character(NA),
    qrp_7 = as.character(NA),
    qrp_8 = as.character(NA),
    qrp_9 = as.character(NA),
    qrp_10 = as.character(NA),
    qrp_absolute_time_range = as.character(NA),
    qrp_relative_time_stem = as.character(NA),
    population = as.character(NA),
    posted_data	= as.character(NA),
    posted_materials = as.character(NA),
    preregistered	= as.character(NA),
    os_absolute_time_range = as.character(NA),
    os_relative_time_stem = as.character(NA)
  )

coding_sheet %>%
  slice(1) %>%
  mutate(coder = "coder name",
         url = "paper url",
         first_author = "last name of first author",
         publication_year = "publication year",
         relevant = "relevant to our review?",
         relevant_reason = "reason (particularly if not relevant)",
         notes = "notes imported from zotero",
         qrp_1 = "includes question about failing to report all DVs (yes/no)",
         qrp_2 = "includes question about collecting more data after checking for significance (yes/no)",
         qrp_3 = "includes question about failing to report all conditions (yes/no)",
         qrp_4 = "includes question about stopping data collection early after getting desired result (yes/no)",
         qrp_5 = "includes question about rounding p values to obtain signifigance (yes/no)",
         qrp_6 = "includes question about selectively reporting studies that worked (yes/no)",
         qrp_7 = "includes question about excluding obs on the basis of effect on result (yes/no)",
         qrp_8 = "includes question about HARKing (yes/no)",
         qrp_9 = "includes question about generalizing to untested demographics (yes/no)",
         qrp_10 = "includes question about falsifying data (yes/no)",
         qrp_absolute_time_range = "date range when survey was administered",
         qrp_relative_time_stem = "question stem wording re: time frame people were asked to report on",
         population = "population description",
         os_absolute_time_range = "date range when survey was administered",
         os_relative_time_stem = "question stem wording re: time frame people were asked to report on") %>%
  bind_rows(coding_sheet) %>%
  write_csv("initial_coding_sheet.csv")


# adding lit search finds -------------------------------------------------

read_csv("./literature_search_finds.csv") %>%
  mutate(coder = "hannah") %>%
  clean_names("snake") %>%
  mutate(first_author = str_extract(author, "^[[:alpha:]]*")) %>%
  mutate(notes = str_remove(str_remove(notes, "<p>"), "</p>")) %>%
  select(coder, url, first_author, publication_year, notes) %>%
  mutate(
    publication_year = as.character(publication_year),
    relevant = as.character(NA),
    relevant_reason = as.character(NA),
    qrp_1 = as.character(NA),
    qrp_2 = as.character(NA),
    qrp_3 = as.character(NA),
    qrp_4 = as.character(NA),
    qrp_5 = as.character(NA),
    qrp_6 = as.character(NA),
    qrp_7 = as.character(NA),
    qrp_8 = as.character(NA),
    qrp_9 = as.character(NA),
    qrp_10 = as.character(NA),
    qrp_absolute_time_range = as.character(NA),
    qrp_relative_time_stem = as.character(NA),
    population = as.character(NA),
    posted_data	= as.character(NA),
    posted_materials = as.character(NA),
    preregistered	= as.character(NA),
    os_absolute_time_range = as.character(NA),
    os_relative_time_stem = as.character(NA)) %>%
  write_csv("literature_search_for_coding_sheet.csv")


