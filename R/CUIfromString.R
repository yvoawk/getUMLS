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
  .checkENG(ENG)
  if (isTRUE(ENG)) {
    lang <- "normalizedString"
  } else {
    lang <- "exact"
  }
  apikey <- getumls_env$KEY

  url <- "https://uts-ws.nlm.nih.gov/rest/search/current"
  query <-
    list(
      "apiKey" = apikey,
      "string" = String,
      "searchType" = lang
    )
  response <- getUMLS2(url, query)
  response <- ifelse(response == "NONE", NA, response)
  return(response)
}
