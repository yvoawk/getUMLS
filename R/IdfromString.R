#' Retrieving source-asserted identifiers
#' @description
#' This function help to retrieve a source-asserted identifiers (codes) associate with a search term (string) in UMLS specific source vocabulary.
#'
#' @param TGT UMLS ticket-grant ticket.
#' @param String The search term.
#' @param vocabulary It takes any root source abbreviation in the UMLS. See the “Abbreviation” column for a list of UMLS source vocabulary abbreviations.
#' Currently searching for one source vocabulary at the time.
#' @param ENG The default is TRUE. We recommend put it to FALSE when the search term is not in English.
#'
#' @return A source-asserted identifier (codes).
#' @importFrom magrittr %>% %$%
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
IdfromString <- function(TGT, String, vocabulary, ENG = TRUE) {
  .checkString(String)
  .checkVocabulary(vocabulary)
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
      "sabs" = vocabulary,
      "returnIdType" = "code",
      "searchType" = lang
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
