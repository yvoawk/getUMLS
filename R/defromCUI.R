#' Retrieving UMLS Concept Definitions
#' @description
#' This function help to retrieve the source-asserted definitions for a known CUI.
#'
#' @param TGT UMLS ticket-grant ticket.
#' @param CUI UMLS Concept Unique Identifier.
#'
#' @return A data frame.
#' @importFrom magrittr %>% %<>%
#' @importFrom dplyr tibble
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
defromCUI <- function(TGT, CUI) {
  ST <- .service_pass(TGT)
  .checkCUI(CUI)
  query <- list("ticket" = ST)

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/definitions")
  query <- httr::GET(url = url, query = query, encode = "json")
  response <- rawToChar(query$content) %>%
    jsonlite::fromJSON() %>%
    .[["result"]]

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
