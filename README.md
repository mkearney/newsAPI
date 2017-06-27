
News API
--------

-   R client for newsAPIorg

API key
-------

-   Go to [newsapi.org](https://newsapi.org) and register to get an API key.
-   Save the key as an environment variable

``` r
## my obscured key
NEWSAPI_KEY <- "4345e85e8ae1427480xxxxxxxxxxxxxx"

## save to .Renviron file
cat(
  paste0("NEWSAPI_KEY=", NEWSAPI_KEY),
  append = TRUE,
  fill = TRUE,
  file = file.path("~", ".Renviron")
)
```

Demo
----

-   Get all the news sources.

``` r
src <- get_sources(language = "en")
src
```

    ## # A tibble: 60 x 9
    ##                     id                  name
    ##                  <chr>                 <chr>
    ##  1         abc-news-au         ABC News (AU)
    ##  2  al-jazeera-english    Al Jazeera English
    ##  3        ars-technica          Ars Technica
    ##  4    associated-press      Associated Press
    ##  5            bbc-news              BBC News
    ##  6           bbc-sport             BBC Sport
    ##  7           bloomberg             Bloomberg
    ##  8      breitbart-news        Breitbart News
    ##  9    business-insider      Business Insider
    ## 10 business-insider-uk Business Insider (UK)
    ## # ... with 50 more rows, and 7 more variables: description <chr>,
    ## #   url <chr>, category <chr>, language <chr>, country <chr>,
    ## #   urlsToLogos <chr>, sortBysAvailable <chr>

-   Pass news source names (IDs) to `get_articles` function.

``` r
df <- lapply(src$id, get_articles)
df <- do.call("rbind", df)
df
```

    ## # A tibble: 563 x 8
    ##         source         publishedAt
    ##          <chr>              <dttm>
    ##  1 abc-news-au 2017-06-27 00:23:11
    ##  2 abc-news-au 2017-06-26 23:45:27
    ##  3 abc-news-au 2017-06-27 01:05:50
    ##  4 abc-news-au 2017-06-27 01:01:47
    ##  5 abc-news-au 2017-06-27 01:37:43
    ##  6 abc-news-au 2017-06-27 01:00:11
    ##  7 abc-news-au 2017-06-27 00:05:19
    ##  8 abc-news-au 2017-06-27 01:50:18
    ##  9 abc-news-au 2017-06-26 23:40:28
    ## 10 abc-news-au 2017-06-27 00:50:41
    ## # ... with 553 more rows, and 6 more variables: author <chr>, title <chr>,
    ## #   description <chr>, url <chr>, urlToImage <chr>, sortBy <chr>
