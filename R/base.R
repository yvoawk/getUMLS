
#' @importFrom stringr str_detect
.checkApikey <- function(apikey) {
  if (!is.character(apikey) ||
    !stringr::str_detect(
      apikey,
      "^[:alnum:]{8}-[:alnum:]{4}-[:alnum:]{4}-[:alnum:]{4}-[:alnum:]{12}$"
    ))
    stop("api key is not valid")
}

#' @importFrom stringr str_detect
.checkTGT <- function(TGT) {
  if (stringr::str_detect(TGT, "^TGT[-]\\d+[-][:alnum:]+[-]cas$"))
    message("Authentication was successful. This gives you access for 8 hours")
   else
    stop("Authentication failed")
}

#' @importFrom stringr str_detect
.checkST <- function(ST) {
  if (!stringr::str_detect(ST, "^ST[-]\\d+[-][:alnum:]+[-]cas$"))
    stop("Your session has expired. Please get another session with the umls_pass function")
}

#' @importFrom stringr str_detect
.checkCUI <- function(CUI) {
  if (!is.character(CUI) ||
    !stringr::str_detect(
      CUI,
      "C[:alnum:]{7}"
    ))
    stop("CUI is not valid")
}

#' @importFrom utils read.delim2
.checkVocabulary <- function(vocabulary) {
  if (!is.character(vocabulary) ||
    !vocabulary %in% vocab)
    stop("vocabulary must be a character or vocabulary is not valid")
}

.checkLanguage <- function(language) {
  if (!is.character(language) ||
    !language %in% c("ENG", "FRE"))
    stop("language must be a character or language is not valid")
}

.checkpageSize <- function(pageSize) {
  if (!is.numeric(pageSize))
    stop("pageSize must be a numeric")
}

.checkENG <- function(ENG) {
  if (!is.logical(ENG))
    stop("ENG must be TRUE or FALSE")
}

.checkString <- function(String) {
  if (!is.character(String))
    stop("String must be a character")
}

.checkType <- function(type) {
  if (!is.character(type) &&
    !type %in% c("ancestors", "descendants", "parents", "children"))
    stop("type must be a character or type is not valid")
}

#' @importFrom httr POST
.service_pass <- function(TGT) {
  url <- paste0("https://utslogin.nlm.nih.gov/cas/v1/tickets/", TGT)
  query <-
    httr::POST(
      url = url,
      body = list("service" = "http://umlsks.nlm.nih.gov"),
      encode = "form"
    )
  ST <- rawToChar(query$content)
  .checkST(ST)
  return(ST)
}

.detect <- function(String) {
  vec <- unlist(strsplit(String, ""))
  position <- grep("[/]", vec)
  vec1 <- rev(position)[1]
  vec2 <- length(vec)
  return(c(vec1, vec2))
}

#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
getUMLS <- function(url, query) {
  get <- httr::GET(url = url, query = query)
  response <- httr::content(get, as = "text") %>% jsonlite::fromJSON() %>% .[["result"]]
  return(response)
}

#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>% %$%
getUMLS2 <- function(url, query) {
  get <- httr::GET(url = url, query = query)
  response <- httr::content(get, as = "text") %>% jsonlite::fromJSON() %$% .$result$results$ui
  return(response)
}

getumls_env <- new.env(parent = emptyenv())

utils::globalVariables(c(".", "id", "ui", "relatedIdName", "rootSource", "name", "termType"))
