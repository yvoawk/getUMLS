#' Retrieving UMLS Concept Unique Identifier
#' @description
#' This function help to retrieve a UMLS Concept Unique Identifier (CUI) associate with a search term (string).
#'
#' @param String The search term.
#' @param ENG The default is TRUE. We recommend put it to FALSE when the search term is not in English.
#'
#' @return A UMLS Concept Unique Identifier (CUI).
#' #' @examples
#' \dontrun{cui <- CUIfromString(String = "bone fracture")}
#' @export
CUIfromString <- function(String, ENG = TRUE) {
  .checkString(String)
  if (isTRUE(ENG)) {
    lang <- "normalizedString"
  } else {
    lang <- "exact"
  }
  ST <- .service_pass(getumls_env$TGT)

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
