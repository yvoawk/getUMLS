#' Retrieving UMLS Concept Unique Identifier
#' @description
#' This function help to retrieve a UMLS Concept Unique Identifier (CUI) associate with a search term (string).
#'
#' @param TGT UMLS ticket-grant ticket.
#' @param String The search term.
#' @param ENG The default is TRUE. We recommend put it to FALSE when the search term is not in English.
#'
#' @return A UMLS Concept Unique Identifier (CUI).
#' @importFrom magrittr %>% %$%
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
CUIfromString <- function(TGT, String, ENG = TRUE) {
  .checkString(String)
  if (isTRUE(ENG)) {
    lang <- "normalizedString"
  } else {
    lang <- "exact"
  }
  ST <- .service_pass(TGT)

  url <- "https://uts-ws.nlm.nih.gov/rest/search/current"
  query <-
    list(
      "ticket" = ST,
      "string" = String,
      "searchType" = lang
    )
  . <- NULL
  query <- httr::GET(url = url, query = query, encode = "json")
  response <- rawToChar(query$content) %>% jsonlite::fromJSON() %$% .$result$results$ui

  if (response == "NONE") {
    response <- NA
  } else {
    response
  }
  return(response)
}
