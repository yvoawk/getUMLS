#' Retrieving information from AUI
#' @description
#' This function help to retrieve information about a known AUI.
#'
#' @param AUI Atoms Unique Identifier
#'
#' @return A data frame.
#' @examples
#' \dontrun{
#' info <- CUIfromAtoms(AUI = "A8345234")
#' }
#' @importFrom magrittr %<>%
#' @importFrom dplyr select
#' @export
CUIfromAtoms <- function(AUI) {
  ST <- .service_pass(getumls_env$TGT)
  query <- list("ticket" = ST)
  .checkAUI(AUI)

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/AUI/", AUI)
  response <- getUMLS(url, query)

  if (is.null(response)) {
    response <- data.frame(
      ui = NA,
      CUI = NA,
      name = NA,
      termType = NA,
      rootSource = NA,
      id = NA
    )
  } else {
    len <- length(response)
    response <- response[-len] %>% unlist()
    name <- names(response)
    response %<>% matrix(ncol=length(response)) %>% data.frame()
    names(response) <- name
    response$id <-
      sapply(
        response$code,
        FUN = function(x) {
          y <- .detect(x)
          substr(x, y[1] + 1, y[2])
        }
      )
    response$CUI <-
      sapply(
        response$concept,
        FUN = function(x) {
          y <- .detect(x)
          substr(x, y[1] + 1, y[2])
        }
      )
    response %<>% dplyr::select(ui, CUI, name, termType, rootSource, id)
  }
  return(response)
}
