


srcs <- get_sources(language = "en")

sortbys <- ifelse(grepl("latest", srcs$sortBysAvailable ), "latest", "")

library(httr)

arts <- Map(function(a, b) get_articles(a, sortBy = b),
    srcs$id, sortbys)
arts <- do.call(dplyr::bind_rows, arts)

arts <- lapply(srcs$id, get_articles)

x <- get_articles(srcs$id[17], parse = FALSE)

parse_articles(x)

str(arts, 2)
traceback()

traceback()

get_articles("breitbart-news")
