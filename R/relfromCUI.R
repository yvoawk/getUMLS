#' Retrieving UMLS Concept Relations
#' @description
#' This function help to retrieve the NLM-asserted relationships for a known CUI.
#'
#' @param CUI UMLS Concept Unique Identifier
#' @param pageSize The default is NULL and returns 25 pages. pageSize is a number.
#'
#' @return A data frame
#' #' @examples
#' \dontrun{relation <- relfromCUI(CUI = "C0155502")}
#' @importFrom magrittr %<>%
#' @importFrom dplyr select
#' @export
relfromCUI <- function(CUI, pageSize = NULL) {
  ST <- .service_pass(getumls_env$TGT)
  .checkCUI(CUI)
  query <- list("ticket" = ST)

  if (!is.null(pageSize)) {
    .checkpageSize(pageSize)
    query$pageSize <- pageSize
  }

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/relations")
  response <- getUMLS(url, query)

  if (is.null(response)) {
    response <- data.frame(
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
