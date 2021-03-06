#' Retrieving Source-Asserted hierarchy
#' @description
#' This function provides you a way to retrieve a hierarchical information about a known source-asserted identifier.
#'
#' @param vocabulary Any root source abbreviation in the UMLS. See the “Abbreviation” column for a list of UMLS source vocabulary abbreviations.
#' @param Id Source-asserted identifier.
#' @param type The type of hierarchy e.g. "parents", "children", "ancestors" or "descendants". By default, it is "descendants".
#'
#' @return A data frame
#' #' @examples
#' \dontrun{hierarchy <- hierarchyfromSource(vocabulary = "ICD10", Id = "J45", type = "children")}
#' @export
hierarchyfromSource <- function(vocabulary, Id, type = "descendants") {
  .checkVocabulary(vocabulary)
  apikey <- getumls_env$KEY
  query <- list("apiKey" = apikey)
  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/source/", vocabulary, "/", Id, "/", type)
  response <- getUMLS(url, query)

  if (isTRUE(response)) {
    response <- list(result = NA)
  } else {
    response <- list(result = response$name)
  }
  return(response)
}
