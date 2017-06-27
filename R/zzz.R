#' aggregate_time
#'
#' @param dt Data
#' @param by Unit of time to be used as interval.
#' @param trim Logical indicating whether to trim time.
#' @param datetime Name of date time variable.
#' @param \dots Args passed to trim_time
#' @return Data frame
#' @export
#' @importFrom tibble as_tibble
#' @noRd
aggregate_time <- function (dt, by = "days", trim = TRUE, datetime = "publishedAt", ...) {
  if (all(is.data.frame(dt), isTRUE(datetime %in% names(dt)))) {
    dt <- dt[[datetime]]
  }
  stopifnot(inherits(dt, "POSIXct"), is.atomic(by))
  dt <- sort(na_omit(dt))
  .unit <- parse_unit(by)

  dt <- round_time(dt, .unit)
  dt <- trim_time(dt, by, ...)
  dtb <- table(dt)

  df <- data.frame(
    time = unique(dt),
    n = as.integer(dtb)
  )

  df2 <- data.frame(
    time = unique(trim_time(seq(dt[1], dt[length(dt)], .unit), by)),
    n = 0L
  )

  if (any(!df2$time %in% df$time)) {
    df <- rbind(df, df2[!df2$time %in% df$time, ])
  }
  df <- df[order(df$time), ]
  row.names(df) <- NULL

  tibble::as_tibble(df)
}


trim_time <- function(dt, by, tz = "UTC", ...) {
  if (grepl("year", by)) {
    as.POSIXct(paste0(substr(dt, 1, 5), "01-01 00:00:00"), tz = tz, ...)
  } else if (grepl("month", by)) {
    as.POSIXct(paste0(substr(dt, 1, 8),    "01 00:00:00"), tz = tz, ...)
  } else if (grepl("week|day", by)) {
    as.POSIXct(paste0(substr(dt, 1, 12),      "00:00:00"), tz = tz, ...)
  } else if (grepl("hour", by)) {
    as.POSIXct(paste0(substr(dt, 1, 15),         "00:00"), tz = tz, ...)
  } else if (grepl("min", by)) {
    as.POSIXct(paste0(substr(dt, 1, 18),            "00"), tz = tz, ...)
  } else {
    dt
  }
}

parse_unit <- function(by) {
  if (is.numeric(by)) {
    n <- by
  } else if (grepl("year", by)) {
    n <- 60 * 60 * 24 * 365
  } else if (grepl("month", by)) {
    n <- 60 * 60 * 24 * 30
  } else if (grepl("week", by)) {
    n <- 60 * 60 * 24 * 7
  } else if (grepl("day", by)) {
    n <- 60 * 60 * 24
  } else if (grepl("hour", by)) {
    n <- 60 * 60
  } else if (grepl("min", by)) {
    n <- 60
  } else if (grepl("sec", by)) {
    n <- 1
  } else {
    stop("must express time interval in secs, mins, hours, days, weeks, months, or years",
         call. = FALSE)
  }
  x <- as.double(gsub("[^[:digit:]|\\.]", "", by))
  if (any(is.na(x), identical(x, ""))) {
    x <- 1
  }
  n * x
}


na_omit <- function(x) {
  x[!is.na(x)]
}

#' round_time
#'
#' Aggregates POSIXct object
#'
#' @param x Vector of class POSIXct.
#' @param interval Amount, in seconds, of aggregated window of time.
#' @param center Logical indicating whether to center datetime value at interval
#'   midpoint.
#' @noRd
round_time <- function(x, interval = 60, center = TRUE) {
    stopifnot(inherits(x, "POSIXct"))
    ## round off to lowest value
    rounded <- floor(as.numeric(x) / interval) * interval
    if (center) {
        ## center so value is interval mid-point
        rounded <- rounded + round(interval * .5, 0)
    }
    ## return to date-time
    as.POSIXct(rounded, origin = "1970-01-01")
}


#' ts data
#'
#' Returns time series-like data frame.
#'
#' @param data Data frame or grouped data frame.
#' @param by Desired interval of time expressed as numeral plus secs, mins,
#'   hours, days, weeks, months, years. If a numeric is provided, the value
#'   is assumed to be in seconds.
#' @param group Name of grouping variable to construct multiple time series,
#'   which still returns a data frame but it includes the group variable as
#'   a named column.
#' @param \dots Passed along to trim_time. Most likely used to specify timezone.
#' @return Data frame with time, n, and grouping column if applicable.
#' @export
ts_data <- function(data, by = "days", group = NULL, ...) {
  if (inherits(data, "grouped_df")) {
    group <- names(attr(data, "labels"))
    data <- data.frame(data)
  }
  if (!is.null(group)) {
    groupfun(data, group, aggregate_time, by, ...)
  } else {
    aggregate_time(data, by, ...)
  }
}


ggcols <- function (n) {
    hues = seq(15, 375, length = n + 1)
    hcl(h = hues, l = 65, c = 100)[1:n]
}

#' apply functions to data frame by group
#'
#' @param data Data frame.
#' @param group Name of grouping variable.
#' @param f Function to be applied to data frame for each group.
#' @param \dots Args passed along to function.
#' @noRd
groupfun <- function(data, group, f, ...) {
  data <- lapply(
    unique(data[[group]]),
    function(x) {
      dg <- f(data[data[[group]] == x, ], ...)
      dg[[group]] <- x
      dg
    })
  if (requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(do.call("rbind", data))
  } else {
    do.call("rbind", data)
  }
}
