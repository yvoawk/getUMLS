#' Retrieving UMLS Concept Unique Identifier (source-asserted Id)
#' @description
#' This function help to retrieve a UMLS Concept Unique Identifier (**CUI**) associate with a specific source-asserted identifier (**code**).
#'
#' @param TGT UMLS ticket-grant ticket.
#' @param Id Source-asserted identifier.
#' @param vocabulary Any root source abbreviation in the UMLS. See the “Abbreviation” column for a list of UMLS source vocabulary abbreviations.
#' @return A UMLS Concept Unique Identifier (CUI).
#' @importFrom magrittr %>% %$%
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
CUIfromId <- function(TGT, Id, vocabulary) {
  .checkVocabulary(vocabulary)
  ST <- .service_pass(TGT)

  url <- "https://uts-ws.nlm.nih.gov/rest/search/current"
  query <-
    list(
      "ticket" = ST,
      "string" = Id,
      "sabs" = vocabulary,
      "inputType" = "sourceUi",
      "searchType" = "exact"
    )

  query <- httr::GET(url = url, query = query, encode = "json")
  response <- rawToChar(query$content) %>% jsonlite::fromJSON() %$% .$result$results$ui

  if (response == "NONE") {
    response <- NA
  } else {
    response
  }
  return(response)
}
