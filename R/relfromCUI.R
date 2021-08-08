#' Retrieving UMLS Concept Relations
#' @description
#' This function help to retrieve the NLM-asserted relationships for a known CUI.
#'
#' @param TGT UMLS ticket-grant ticket
#' @param CUI UMLS Concept Unique Identifier
#' @param pageSize The default is NULL and returns 25 pages. pageSize is a number.
#'
#' @return A data frame
#' @importFrom magrittr %>% %<>%
#' @importFrom dplyr tibble select
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
relfromCUI <- function(TGT, CUI, pageSize = NULL) {
  ST <- .service_pass(TGT)
  .checkCUI(CUI)
  query <- list("ticket" = ST)

  if (!is.null(pageSize)) {
    .checkpageSize(pageSize)
    query$pageSize <- pageSize
  }

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/relations")
  query <- httr::GET(url = url, query = query, encode = "json")
  response <- rawToChar(query$content) %>%
    jsonlite::fromJSON() %>%
    .[["result"]]

  if (is.null(response)) {
    response <- dplyr::tibble(
      name = NA,
      termType = NA,
      rootSource = NA,
      id = NA
    )
  } else {
    response$id <-
      sapply(
        response$relatedId,
        FUN = function(x) {
          y <- .detect(x)
          substr(x, y[1] + 1, y[2])
        }
      )
    response %<>% dplyr::select(id, relatedIdName, rootSource, ui)
  }
  return(response)
}
