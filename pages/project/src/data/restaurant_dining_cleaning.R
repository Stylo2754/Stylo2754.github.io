# Read the raw dataset
df_raw <- readRDS(file = here::here("pages", "project", "data", "restaurant_dining.Rds"))

# Clean and format the columns
df_clean <- df_raw |>
  dplyr::mutate(
    cuisine_type = trimws(tolower(cuisine_type)),
    day_type = factor(
      x = trimws(tolower(day_type)),
      levels = c("weekday", "weekend")
    )
  )

# Check that row count is unchanged and no NAs were introduced in day_type
stopifnot(nrow(df_clean) == nrow(df_raw))
stopifnot(!any(is.na(df_clean$day_type)))

# Ensure the output directory exists
dir.create(
  path = here::here("pages", "project", "data", "cleaned"),
  showWarnings = FALSE,
  recursive = TRUE
)

# Save the cleaned data
saveRDS(
  object = df_clean,
  file = here::here("pages", "project", "data", "cleaned", "restaurant_dining_cleaned.Rds")
)
