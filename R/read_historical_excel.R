#' Parse the spreadsheet that contains the census's history of poverty levels
#'
#' This data table includes values for people of different ages and for
#' households with different numbers of people. The year span begins in 1959.
#' The dollar amounts are not corrected for inflation, which is why the CPI is
#' included as a column.
#'
#' @param .path <chr> the full path to the file
#'
#' @return <data.frame> a table of poverty levels
#' @export
read_historical_excel <- function(.path){
    .path |>
        readxl::read_xlsx(
            sheet = "pov01",
            skip = 5L,
            col_names = c(
                "Year",
                "Ages,All,People,1",
                "Ages,Under 65,People,1",
                "Ages,65 or Over,People,1",
                "Ages,All,People,2",
                "Ages,Under 65,People,2",
                "Ages,65 or Over,People,2",
                paste0("Ages,All,People,", c(3:6, "7+", 7:8, "9+")),
                "CPI"
            ),
            col_types = c(
                "text",
                rep("numeric", 15)
            ),
            na = c("", "***")
        ) |>
        dplyr::filter(
            !is.na(.data$CPI)
        ) |>
        dplyr::mutate(
            Year = .data$Year |>
                stringr::str_extract("^\\d+") |>
                as.integer()
        ) |>
        tidyr::pivot_longer(
            cols = tidyselect::starts_with("Ages"),
            names_to = c(NA, "Age", NA, "People"),
            names_sep = ",",
            values_to = "Poverty Threshold"
        )
}
