#' Retrieving UMLS Atoms
#' @description
#' This function help to retrieve atoms and information about atoms for a known CUI.
#'
#' @param CUI UMLS Concept Unique Identifier
#' @param vocabulary The default is NULL and returns all vocabularies. It takes any root source abbreviation in the UMLS. See the “Abbreviation” column for a list of UMLS source vocabulary abbreviations.
#' Currently filtering by one vocabulary is supported.
#' @param language The default is NULL and returns all languages. It takes any 3 letter language abbreviation in the UMLS, such as “ENG”,“FRE”.
#' Currently filtering by one language is supported and the languages supported are french (FRE) and english (ENG).
#' @param pageSize The default is NULL and returns 25 pages. pageSize is a number.
#'
#' @return A data frame.
#' @examples
#' \dontrun{atom <- atomsfromCUI(CUI = "C0018689")}
#' @importFrom magrittr %<>%
#' @importFrom dplyr select
#' @export
atomsfromCUI <- function(CUI, vocabulary = NULL, language = NULL, pageSize = NULL) {
  apikey <- getumls_env$KEY
  query <- list("apiKey" = apikey)
  .checkCUI(CUI)

  if (!is.null(vocabulary)) {
    .checkVocabulary(vocabulary)
    query$sabs <- vocabulary
  }

  if (!is.null(language)) {
    .checkLanguage(language)
    query$language <- language
  }

  if (!is.null(pageSize)) {
    .checkpageSize(pageSize)
    query$pageSize <- pageSize
  }

  url <- paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", CUI, "/atoms")
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
        response$code,
        FUN = function(x) {
          y <- .detect(x)
          substr(x, y[1] + 1, y[2])
        }
      )
    response %<>% dplyr::select(name, termType, rootSource, id)
  }
  return(response)
}
