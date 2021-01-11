library(tidyverse)
library(ggplot2)
library(janitor)


n_pact <- read_csv("n_pact_data.csv") %>%
  clean_names("snake") %>%
  filter(estimate_type == "median N") %>%
  filter(!is.na(estimate)) %>% #one estimate from Kossmeier was 1000 from 1982 (huge outlier... removed for now....)
  arrange(year)


journal_names <- n_pact %>%
  group_by(journal) %>%
  count() %>%
  pull(journal)

rolling_averages <- n_pact %>%
  group_by(journal) %>%
  arrange(year) %>%
  mutate(previous_estimate = lag(estimate),
         previous_estimate_year = lag(year),
         rolling_estimate = (estimate + previous_estimate)/2) %>%
  dplyr::select(journal, year, rolling_estimate)


n_pact %>%
ggplot(aes(x = as.numeric(year), y = estimate)) +
  geom_point(aes(color = journal)) +
  geom_line(aes(color = journal, group = journal)) +
  labs(x = "Year", y = "N-Pact Factor (Median N)", color = "Journal") +
  theme(axis.text.x = element_text(angle = -45, vjust = 0.5, hjust=1)) +
  ggsave("n_pact_over_time_line.png", scale = 1.2)

n_pact %>%
  ggplot(aes(x = as.numeric(year), y = estimate)) +
  geom_point(aes(color = journal)) +
  geom_line(data = rolling_averages, aes(x = as.numeric(year), y = rolling_estimate, color = journal, group = journal, se = FALSE)) +
  labs(x = "Year", y = "N-Pact Factor (Median N)", color = "Journal") +
  ggsave("n_pact_over_time_rolling_avg_line.png", scale = 1.2)


n_pact %>%
  ggplot(aes(x = as.numeric(year), y = estimate)) +
  geom_point(aes(color = journal)) +
  geom_smooth(aes(color = journal, group = journal), se = FALSE, method = "lm") +
  labs(x = "Year", y = "N-Pact Factor (Median N)", color = "Journal") +
  ggsave("n_pact_over_time_smooth.png", scale = 1.2)

n_pact %>%
  ggplot(aes(x = as.numeric(year), y = estimate)) +
  geom_point(aes(color = research_area)) +
  geom_smooth(aes(color = research_area, group = research_area), se = FALSE, method = "glm") +
  labs(x = "Year", y = "N-Pact Factor (Median N)", color = "Research Area") +
  ggsave("n_pact_over_time_smooth_by_area.png", scale = 1.2)

n_pact %>%
  ggplot(aes(x = as.numeric(year), y = as.numeric(estimate))) +
  geom_point(aes(color = journal)) +
  #geom_smooth(aes(color = journal, group = journal), se = FALSE, method = "lm") +
  geom_smooth() +
  labs(x = "Year", y = "N-Pact Factor (Median N)", color = "Journal") +
  ggsave("n_pact_over_time_total_avg_smooth.png", scale = 1.2)


