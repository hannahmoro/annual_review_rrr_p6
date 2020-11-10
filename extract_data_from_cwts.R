library(tidyverse)
library(readxl)
library(janitor)

open_data_report <- read_excel("cwts_data_sharing_survey_respondent_data_ANON_publish.xlsx") %>%
  clean_names("snake")


open_data_report %>%
  filter(p2_subject_in_which_subject_discipline_do_you_specialize == "Psychology" |
           p2_subject_in_which_subject_discipline_do_you_specialize == "Neuroscience") %>%
  nrow()

open_data_report %>%
  filter(p2_subject_in_which_subject_discipline_do_you_specialize == "Psychology" |
           p2_subject_in_which_subject_discipline_do_you_specialize == "Neuroscience") %>%
  mutate(did_not_share = q1f_4_none_of_the_above_publishing_research_data_have_you_published_the_research_data_that_you_used_or_created_as_part_of_your_last_research_project_in_any_of_the_following_ways) %>%
  tabyl(did_not_share)
