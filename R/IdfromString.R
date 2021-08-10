#' Retrieving source-asserted identifiers
#' @description
#' This function help to retrieve a source-asserted identifiers (codes) associate with a search term (string) in UMLS specific source vocabulary.
#'
#' @param String The search term.
#' @param vocabulary It takes any root source abbreviation in the UMLS. See the “Abbreviation” column for a list of UMLS source vocabulary abbreviations.
#' Currently searching for one source vocabulary at the time.
#' @param ENG The default is TRUE. We recommend put it to FALSE when the search term is not in English.
#'
#' @return A source-asserted identifier (codes).
#' #' @examples
#' \dontrun{Id <- IdfromString(String = "bone fracture", vocabulary = "MSH")}
#' @export
IdfromString <- function(String, vocabulary, ENG = TRUE) {
  .checkString(String)
  .checkVocabulary(vocabulary)
  if (isTRUE(ENG)) {
    lang <- "normalizedString"
  } else {
    lang <- "exact"
  }
  TGT <- getumls_env$TGT
  ST <- .service_pass(TGT)
  .checkST(ST)

  url <- "https://uts-ws.nlm.nih.gov/rest/search/current"
  query <-
    list(
      "ticket" = ST,
      "string" = String,
      "sabs" = vocabulary,
      "returnIdType" = "code",
      "searchType" = lang
    )
  response <- getUMLS2(url, query)

  if (response == "NONE") {
    response <- NA
  } else {
    response
  }
  return(response)
}
