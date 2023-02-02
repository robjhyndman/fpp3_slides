library(fpp3)

mydata <- tsibble(
  year = 2015:2019,
  y = c(123, 39, 78, 52, 110),
  index = year
)

mydata <- tibble(
  year = 2015:2019,
  y = c(123, 39, 78, 52, 110)
) |>
  as_tsibble(index = year)


## ---- prison ------------------------------------------------------------

prison <- readr::read_csv("data/prison_population.csv") |>
  mutate(Quarter = yearquarter(date)) |>
  select(-date) |>
  as_tsibble(
    index = Quarter,
    key = c(state, gender, legal, indigenous)
  )

## ---- PBS ---------------------------------------------------------------

PBS |>
  filter(ATC2 == "A10") |>
  select(Month, Concession, Type, Cost) |>
  summarise(TotalC = sum(Cost)) |>
  mutate(Cost = TotalC / 1e6) -> a10
