#' Retrieving UMLS Concept Unique Identifier (source-asserted Id)
#' @description
#' This function help to retrieve a UMLS Concept Unique Identifier (**CUI**) associate with a specific source-asserted identifier (**code**).
#'
#' @param Id Source-asserted identifier.
#' @param vocabulary Any root source abbreviation in the UMLS. See the “Abbreviation” column for a list of UMLS source vocabulary abbreviations.
#' @return A UMLS Concept Unique Identifier (CUI).
#' #' @examples
#' \dontrun{cui <- CUIfromId(Id = "J45", vocabulary = "ICD10")}
#' @export
CUIfromId <- function(Id, vocabulary) {
  .checkVocabulary(vocabulary)
  TGT <- getumls_env$TGT
  ST <- .service_pass(TGT)
  .checkST(ST)

  url <- "https://uts-ws.nlm.nih.gov/rest/search/current"
  query <-
    list(
      "ticket" = ST,
      "string" = Id,
      "sabs" = vocabulary,
      "inputType" = "sourceUi",
      "searchType" = "exact"
    )

  response <- getUMLS2(url, query)

  if (response == "NONE") {
    response <- NA
  } else {
    response
  }
  return(response)
}
