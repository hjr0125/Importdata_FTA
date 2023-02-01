library(jsonlite)
library(httr)

url <- "https://www.bandtrass.or.kr/theme/fta.do"

payload <- list(
  command = "THE00202Detail",
  search = "Y",
  UNIT = "1000",
  COL_NAME = "",
  COL_NAME2 = "",
  EXCEL_LOG = "",
  MENU_CODE = "THE00202",
  page = "1",
  S0010005 = "H",
  SelectCd = "1101",
  S0010004 = "M",
  BASE_YEAR = "2013",
  BASE_MON = "01",
  pageRowCount = "10"
)

response <- httr::POST(url, body = payload, encode = "form")

json_data <- jsonlite::fromJSON(content(response, as = "text"))

# extract the gridExportData from the JSON object
grid_data <- json_data$gridExportData
grid_foot <- json_data$gridExportFootData

grid_df_foot <- fromJSON(grid_foot)
grid_df_data <- fromJSON(grid_data)