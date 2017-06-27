#' get_sources
#'
#' Returns news sources with meta data.
#'
#' @param category Name of news category.
#' @param language Name of language must be one of en, de, or fr. Defaults
#'   to all.
#' @param country Name of country must be one of au, de, gb, in, it, us. Defaults
#'   to all.
#' @param apiKey Character string API token. Default is to grab it from user R environ.
#' @param parse Logical indicating whether to parse response object to data frame.
#' @examples
#' \dontrun{
#' ## get english language news sources
#' df <- get_sources(language = "en")
#'
#' ## preview data
#' df
#' }
#' @importFrom httr content GET warn_for_status
#' @return Data frame or nested list.
#' @export
get_sources <- function(category = "",
                        language = "",
                        country = "",
                        apiKey = NULL,
                        parse = TRUE) {
  stopifnot(is.atomic(category), is.atomic(language))
  if (!is.null(language)) {
    if (!language %in% c("en", "de", "fr", "")) {
      stop("language must be en de or fr.", call. = FALSE)
    }
  }
  if (!is.null(country)) {
    if (!country %in% c("au", "de", "gb", "in", "it", "us", "")) {
      stop("country must be au de gb in it or us.", call. = FALSE)
    }
  }
  if (is.null(apiKey)) {
    apiKey <- .NEWSAPI_KEY()
  }
  params <- list(
    category = category,
    language = language,
    country = country,
    apiKey = apiKey
  )
  rurl <- .makeurl(query = "sources", params)
  r <- httr::GET(rurl)
  warn_for_status(r)
  r <- httr::content(r, "parsed")
  if (parse) {
    parse_sources(r)
  } else {
    r
  }
}

#' parse_sources
#'
#' Parses sources response object into data frame
#'
#' @param x Response object from get_sources.
#' @importFrom tibble as_tibble
#' @return Data frame
#' @export
parse_sources <- function(x) {
  if ("sources" %in% names(x)) {
    x <- x[["sources"]]
  }
  vars <- unique(unlist(lapply(x, names)))
  data <- vector("list", length(x))
  for (i in seq_along(x)) {
    for (j in vars) {
      data[[i]][[j]] <- paste(x[[i]][[j]], collapse = " ")
    }
  }
  data <- tibble::as_tibble(do.call("rbind", data))
  data
}
