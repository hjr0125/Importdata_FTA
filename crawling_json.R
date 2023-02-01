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

#length(response$content) >= 1000

response <- httr::POST(url, body = payload, encode = "form")

json_data <- jsonlite::fromJSON(content(response, as = "text"))

# extract the gridExportData from the JSON object
grid_data <- json_data$gridImportData
grid_foot <- json_data$gridImportFootData

grid_df_foot <- fromJSON(grid_foot)
#전체 소계
#FTA_INCRE_RATIO -> BASE_YEAR 증감률
#FTA_INCRE_RATIO1 -> BASE_YEAR - 1 증감률
#FTA_INCRE_RATIO2 -> BASE_YEAR - 2 증감률
#FTA_SUM_DLR -> BASE_YEAR 금액
#FTA_SUM_DLR1 -> BASE_YEAR - 1 금액
#FTA_SUM_DLR2 -> BASE_YEAR - 2 금액
#TARIFF_DLR -> BASE_YEAR 수혜금액
#TARIFF_DLR1 -> BASE_YEAR -1 수혜금액
#TARIFF_DLR2 -> BASE_YEAR -2 수혜금액


grid_df_data <- fromJSON(grid_data)
#IM_AMT_OF_DLR -> BASE_YEAR 금액
#PRE_IM_AMT_OF_DLR1 -> BASE_YEAR - 1 금액
#PRE_IM_AMT_OF_DLR2 -> BASE_YEAR - 2 금액
#TARIFF_DLR -> BASE_YEAR 특혜 적용 금액
#TARIFF_DLR1 -> BASE_YEAR - 1 특혜 적용 금액
#TARIFF_DLR2 -> BASE_YEAR - 2 특혜 적용 금액
#NATN_NAME -> 국가
#FTANAME -> FTA


grid_df_data %>% select(FTANAME,NATN_NAME)