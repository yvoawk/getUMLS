#' @title Information about CUI
#' @description
#' This function retrieves information about a known CUI.
#'
#' @param TGT Ticket-grant ticket, obtain with the umls_pass function.
#' @param CUI UMLS Concept Unique Identifier.
#'
#' @return a data frame
#' @importFrom magrittr %>% %<>%
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr select tibble
#' @export
fromCUI <- function(TGT, CUI) {
  .checkCUI(CUI)
  ST <- .service_pass(TGT)

  query <- list("ticket" = ST)
  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI)

  query <- httr::GET(url = url, query = query, encode = "json")
  response <- rawToChar(query$content) %>%
    jsonlite::fromJSON() %>%
    .[["result"]]

  if (is.null(response)) {
    response <- dplyr::tibble(
      name = NA,
      type = NA,
      id = NA,
      semanticType = NA,
      atomCount = NA,
      relationCount = NA
    )
  } else {
    response %<>% dplyr::tibble(
      name = response$name,
      type = response$classType,
      id = response$ui,
      semanticType = response$semanticTypes$name,
      atomCount = response$atomCount,
      relationCount = response$relationCount
    ) %>%
      dplyr::select(!.) %>%
      unique()
  }
  return(response)
}
