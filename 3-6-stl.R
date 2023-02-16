library(fpp3)

us_retail_employment <- us_employment |>
  filter(year(Month) >= 1990, Title == "Retail Trade") |>
  select(-Series_ID)

us_retail_employment |>
  model(STL(Employed ~ season(window = 15) + trend(window = 15), robust = TRUE)) |>
  components() |>
  autoplot() + labs(title = "STL decomposition: US retail employment")

