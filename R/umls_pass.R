#' @title Obtain access to UMLS API
#' @description Function to register your apikey.
#'
#' @export
umls_pass <- function() {
  apikey <- getPass::getPass("Paste or enter your apiKey")
  .checkApikey(apikey)
  getumls_env$KEY <- apikey
  message("Access granted.")
}
