
#' @title Obtain TGT
#' @description Function to get UMLS Ticket-Grant Ticket.
#'
#' @param apikey apikey gives by UMLS
#' @importFrom magrittr %>%
#' @importFrom httr POST
#' @importFrom stringr str_extract
#' @export
umls_pass <- function(apikey) {
  .checkApikey(apikey)

  url <- "https://utslogin.nlm.nih.gov/cas/v1/api-key"
  query <-
    httr::POST(
      url = url,
      body = list("apikey" = apikey),
      encode = "form"
    )
  TGT <- query$headers$location %>% stringr::str_extract("TGT.*")
  return(TGT)
}
