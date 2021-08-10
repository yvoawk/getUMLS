#' Retrieving UMLS Concept Definitions
#' @description
#' This function help to retrieve the source-asserted definitions for a known CUI.
#'
#' @param CUI UMLS Concept Unique Identifier.
#'
#' @return A data frame.
#' #' @examples
#' \dontrun{defintion <- defromUI(CUI = "C0155502")}
#' @importFrom dplyr tibble
#' @export
defromCUI <- function(CUI) {
  TGT <- getumls_env$TGT
  ST <- .service_pass(TGT)
  .checkCUI(CUI)
  query <- list("ticket" = ST)

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/definitions")
  response <- getUMLS(url, query)

  if (is.null(response)) {
    response <- dplyr::tibble(
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
