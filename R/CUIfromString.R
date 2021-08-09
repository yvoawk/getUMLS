#' Retrieving UMLS Concept Unique Identifier
#' @description
#' This function help to retrieve a UMLS Concept Unique Identifier (CUI) associate with a search term (string).
#'
#' @param TGT UMLS ticket-grant ticket.
#' @param String The search term.
#' @param ENG The default is TRUE. We recommend put it to FALSE when the search term is not in English.
#'
#' @return A UMLS Concept Unique Identifier (CUI).
#' @export
CUIfromString <- function(TGT, String, ENG = TRUE) {
  .checkString(String)
  if (isTRUE(ENG)) {
    lang <- "normalizedString"
  } else {
    lang <- "exact"
  }
  ST <- .service_pass(TGT)
  .checkST(ST)

  url <- "https://uts-ws.nlm.nih.gov/rest/search/current"
  query <-
    list(
      "ticket" = ST,
      "string" = String,
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
