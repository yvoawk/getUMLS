#' Retrieving UMLS Concept Definitions
#' @description
#' This function help to retrieve the source-asserted definitions for a known CUI.
#'
#' @param CUI UMLS Concept Unique Identifier.
#'
#' @return A data frame.
#' #' @examples
#' \dontrun{defintion <- defromUI(CUI = "C0155502")}
#' @export
defromCUI <- function(CUI) {
  .checkCUI(CUI)
  apikey <- getumls_env$KEY
  query <- list("apiKey" = apikey)

  url <-
    paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/definitions")
  response <- getUMLS(url, query)

  if (is.null(response)) {
    response <- data.frame(
      classType = NA,
      sourceOriginated = NA,
      rootSource = NA,
      value = NA
    )
  } else {
    response
  }
  return(response)
}
