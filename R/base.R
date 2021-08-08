
#' @importFrom stringr str_detect
.checkApikey <- function(apikey) {
  if (!is.character(apikey) ||
    !stringr::str_detect(
      apikey,
      "[:alnum:]+[-][0-9]+[-][0-9]+[-][:alnum:]+[-][:alnum:]+"
    )) {
    stop("api key is not valid")
  }
}

#' @importFrom stringr str_detect
.checkTGT <- function(TGT) {
  if (!stringr::str_detect(TGT, "^TGT.*cas$")) {
    stop("ticket has expired or is not valid")
  }
}

#' @importFrom stringr str_detect
.checkCUI <- function(CUI) {
  if (!is.character(CUI) ||
    !stringr::str_detect(
      CUI,
      "C[:alnum:]{7}"
    )) {
    stop("CUI is not valid")
  }
}

#' @importFrom utils read.delim2
.checkVocabulary <- function(vocabulary) {
  vocab <- utils::read.delim2("./inst/vocabulary.tsv", sep = "\t", stringsAsFactors = FALSE, encoding = "UTF-8")$Abbreviation
  if (!is.character(vocabulary) ||
    !vocabulary %in% vocab) {
    stop("vocabulary must be a character or vocabulary is not valid")
  }
}

.checkLanguage <- function(language) {
  if (!is.character(language) ||
    !language %in% c("ENG", "FRE")) {
    stop("language must be a character or language is not valid")
  }
}

.checkpageSize <- function(pageSize) {
  if (!is.numeric(pageSize)) {
    stop("pageSize must be a numeric")
  }
}

.checkString <- function(String) {
  if (!is.character(String)) {
    stop("String must be a character")
  }
}

.checkType <- function(type) {
  if (!is.character(type) &&
    !type %in% c("ancestors", "descendants", "parents", "children")) {
    stop("type must be a character or type is not valid")
  }
}

#' @importFrom httr POST
.service_pass <- function(TGT) {
  .checkTGT(TGT)
  url <- paste0("https://utslogin.nlm.nih.gov/cas/v1/tickets/", TGT)
  query <-
    httr::POST(
      url = url,
      body = list("service" = "http://umlsks.nlm.nih.gov"),
      encode = "form"
    )
  ST <- rawToChar(query$content)
  return(ST)
}

.detect <- function(String) {
  vec <- unlist(strsplit(String, ""))
  position <- grep("[/]", vec)
  vec1 <- rev(position)[1]
  vec2 <- length(vec)
  return(c(vec1, vec2))
}

utils::globalVariables(c(".", "id", "ui", "relatedIdName", "rootSource"))
