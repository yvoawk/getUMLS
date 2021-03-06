% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CUIfromString.R
\name{CUIfromString}
\alias{CUIfromString}
\title{Retrieving UMLS Concept Unique Identifier}
\usage{
CUIfromString(String, ENG = TRUE)
}
\arguments{
\item{String}{The search term.}

\item{ENG}{The default is TRUE. We recommend put it to FALSE when the search term is not in English.}
}
\value{
A UMLS Concept Unique Identifier (CUI).
#' @examples
\dontrun{cui <- CUIfromString(String = "bone fracture")}
}
\description{
This function help to retrieve a UMLS Concept Unique Identifier (CUI) associate with a search term (string).
}
