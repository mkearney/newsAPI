% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/articles.R
\name{get_articles}
\alias{get_articles}
\title{get_sources}
\usage{
get_articles(source, sortBy = "", apiKey = NULL, parse = TRUE)
}
\arguments{
\item{source}{Name of news source.}

\item{sortBy}{Name of sorting mechanism must be one of latest, top, or popular. Certain methods
only work for certain news sources.}

\item{apiKey}{Character string API token. Default is to grab it from user R environ.}

\item{parse}{Logical indicating whether to parse response object to data frame.}
}
\value{
Data frame or nested list.
}
\description{
Returns news sources with meta data.
}
\examples{
\dontrun{
df <- get_articles("espn")
}
}
