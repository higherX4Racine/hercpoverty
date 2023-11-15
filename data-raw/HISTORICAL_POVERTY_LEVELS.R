## code to prepare `HISTORICAL_POVERTY_LEVELS` dataset goes here

POVERTY_FILE <- system.file("extdata",
                            "hstpov1.xlsx",
                            package = "hercpoverty")

curl::curl_download("https://www2.census.gov/programs-surveys/cps/tables/time-series/historical-poverty-people/hstpov1.xlsx",
                    destfile = POVERTY_FILE)

HISTORICAL_POVERTY_LEVELS <- read_historical_excel(POVERTY_FILE)

usethis::use_data(HISTORICAL_POVERTY_LEVELS, overwrite = TRUE)
