#' @title Information about CUI
#' @description
#' This function retrieves information about a known CUI.
#'
#' @param CUI UMLS Concept Unique Identifier.
#'
#' @return a data frame
#' #' @examples
#' \dontrun{x <- fromCUI(CUI = "C0018689")}
#' @importFrom magrittr %>%
#' @export
fromCUI <- function(CUI) {
  .checkCUI(CUI)
  ST <- .service_pass(getumls_env$TGT)
  query <- list("ticket" = ST)
  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI)
  response <- getUMLS(url, query)

  if (is.null(response)) {
    response <- data.frame(
      name = NA,
      type = NA,
      id = NA,
      semanticType = NA,
      atomCount = NA,
      relationCount = NA
    )
  } else {
    response <- data.frame(
      name = response$name,
      type = response$classType,
      id = response$ui,
      semanticType = response$semanticTypes$name,
      atomCount = response$atomCount,
      relationCount = response$relationCount
    ) %>% unique()
  }
  return(response)
}
