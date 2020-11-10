library(tidyverse)
library(janitor)

beaudry <- read_csv("./data_processed_osf.csv") %>%
  clean_names("snake") %>%
  select(-participant_number) %>%
  filter(!across(everything(), is.na)) %>% #dropping people who didn't reply to any questions
  #recoding answers
  # note, if people said they were unaware of all OS practices, they were
  # assigned 'no' for each use variable (which was overwritten if people didn't skip)
  mutate(overall_os_use = case_when(
    overall_exp == "Aware, But Not Used" ~ "no",
    overall_exp == "Unaware" ~ "no",
    overall_exp == "Extensive" ~ "yes",
    overall_exp == "Some" ~ "yes"),
    data_use = case_when(
      overall_exp == "Unaware" ~ "no",
      data_exp == "Aware, But Not Used" ~ "no",
      data_exp == "Unaware" ~ "no",
      data_exp == "Regular Use" ~ "yes",
      data_exp == "Some Use" ~ "yes"),
    prereg_use = case_when(
      overall_exp == "Unaware" ~ "no",
      pre_reg_exp == "Aware, But Not Used" ~ "no",
      pre_reg_exp == "Unaware" ~ "no",
      pre_reg_exp == "Reg Use" ~ "yes",
      pre_reg_exp == "Some Experience" ~ "yes"),
    materials_code_use = case_when(
      overall_exp == "Unaware" ~ "no",
      code_exp == "Aware, But Not Used" ~ "no",
      code_exp == "Unaware" ~ "no",
      code_exp == "Regular Use" ~ "yes",
      code_exp == "Some Use" ~ "yes")) %>%
  glimpse()



beaudry_codebook <- read_csv("./os_metadata_processed_data.csv")


#posting data
beaudry %>%
  tabyl(data_use)


#posting materials (or code)
beaudry %>%
  tabyl(materials_code_use)


#preregistration
beaudry %>%
  tabyl(prereg_use)


