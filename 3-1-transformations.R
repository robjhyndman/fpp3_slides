library(fpp3)

## GDP per capita
global_economy |>
  filter(Country == "Australia") |>
  autoplot(GDP / Population)


## Retail CPI
print_retail <- aus_retail |>
  filter(Industry == "Newspaper and book retailing") |>
  group_by(Industry) |>
  index_by(Year = year(Month)) |>
  summarise(Turnover = sum(Turnover))
print_retail |> autoplot(Turnover)
aus_economy <- global_economy |>
  filter(Code == "AUS")
print_retail |>
  left_join(aus_economy, by = "Year") |>
  mutate(Adjusted_turnover = Turnover / CPI * 100) |>
  pivot_longer(c(Turnover, Adjusted_turnover), values_to = "Turnover") |>
  mutate(name = factor(name, levels = c("Turnover", "Adjusted_turnover"))) |>
  ggplot(aes(x = Year, y = Turnover)) +
  geom_line() +
  facet_grid(name ~ ., scales = "free_y") +
  labs(title = "Turnover: Australian print media industry", y = "$AU")


## Food retailing
food <- aus_retail |>
  filter(Industry == "Food retailing") |>
  summarise(Turnover = sum(Turnover))
food |> autoplot(Turnover) +
  labs(y = "Turnover ($AUD)")
food |>
  features(Turnover, features = guerrero)
food |>
  autoplot(box_cox(Turnover, 0.0895)) +
  labs(y = "Box-Cox transformed turnover")
