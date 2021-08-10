#' Retrieving UMLS Concept Relations
#' @description
#' This function help to retrieve the NLM-asserted relationships for a known CUI.
#'
#' @param CUI UMLS Concept Unique Identifier
#' @param pageSize The default is NULL and returns 25 pages. pageSize is a number.
#'
#' @return A data frame
#' @importFrom magrittr %<>%
#' @importFrom dplyr tibble select
#' @export
relfromCUI <- function(CUI, pageSize = NULL) {
  TGT <- getumls_env$TGT
  ST <- .service_pass(TGT)
  .checkST(ST)
  .checkCUI(CUI)
  query <- list("ticket" = ST)

  if (!is.null(pageSize)) {
    .checkpageSize(pageSize)
    query$pageSize <- pageSize
  }

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/relations")
  response <- getUMLS(url, query)

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
