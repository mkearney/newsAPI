
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
print(src, width = 300)
```

    ## # A tibble: 60 x 9
    ##                     id                  name                                                                                                                                                                                                                                                  description
    ##                  <chr>                 <chr>                                                                                                                                                                                                                                                        <chr>
    ##  1         abc-news-au         ABC News (AU)                                                                                              Australia's most trusted source of local, national and world news. Comprehensive, independent, in-depth analysis, the latest business, sport, weather and more.
    ##  2  al-jazeera-english    Al Jazeera English                                                                                                        News, analysis from the Middle East and worldwide, multimedia and interactives, opinions, documentaries, podcasts, long reads and broadcast schedule.
    ##  3        ars-technica          Ars Technica                                                                                                                                                               The PC enthusiast's resource. Power users and the tools they love, without computing religion.
    ##  4    associated-press      Associated Press                                                                                                                                               The AP delivers in-depth coverage on the international, politics, lifestyle, business, and entertainment news.
    ##  5            bbc-news              BBC News          Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news as well as local and regional perspectives. Also entertainment, business, science, technology and health news.
    ##  6           bbc-sport             BBC Sport The home of BBC Sport online. Includes live sports coverage, breaking news, results, video, audio and analysis on Football, F1, Cricket, Rugby Union, Rugby League, Golf, Tennis and all the main world sports, plus major events such as the Olympic Games.
    ##  7           bloomberg             Bloomberg                                                                                                                Bloomberg delivers business and markets news, data, analysis, and video to the world, featuring stories from Businessweek and Bloomberg News.
    ##  8      breitbart-news        Breitbart News                                                                                                                                               Syndicated news and opinion website providing continuously updated headlines to top news and analysis sources.
    ##  9    business-insider      Business Insider                                                                Business Insider is a fast-growing business site with deep financial, media, tech, and other industry verticals. Launched in 2007, the site is now the largest business news site on the web.
    ## 10 business-insider-uk Business Insider (UK)                                                                Business Insider is a fast-growing business site with deep financial, media, tech, and other industry verticals. Launched in 2007, the site is now the largest business news site on the web.
    ## # ... with 50 more rows, and 6 more variables: url <chr>, category <chr>,
    ## #   language <chr>, country <chr>, urlsToLogos <chr>,
    ## #   sortBysAvailable <chr>

-   Pass news source names (IDs) to `get_articles` function.

``` r
df <- lapply(src$id, get_articles)
df <- do.call("rbind", df)
print(df, width = 300)
```

    ## # A tibble: 563 x 8
    ##         source         publishedAt                                                                                                                                                 author                                                                                                  title
    ##          <chr>              <dttm>                                                                                                                                                  <chr>                                                                                                  <chr>
    ##  1 abc-news-au 2017-06-27 00:23:11                                                                                                      http://www.abc.net.au/news/ashlynne-mcghee/167076                                              Census results show Australians are losing their religion
    ##  2 abc-news-au 2017-06-26 23:45:27 http://www.abc.net.au/news/catherine-hanrahan/7901852, http://www.abc.net.au/news/simon-elvery/5449816, http://www.abc.net.au/news/joshua-byrd/8609896                                                                        This is Australia as 100 people
    ##  3 abc-news-au 2017-06-27 01:05:50                                                                                                        http://www.abc.net.au/news/michael-janda/166854                                                         Census reveals continued home ownership plunge
    ##  4 abc-news-au 2017-06-27 01:01:47                                                                                                                                                   <NA> 'Getting the same racism, that's not the life I want to live': NYT reporter examines race in Australia
    ##  5 abc-news-au 2017-06-27 01:37:43                                                                                                      http://www.abc.net.au/news/louise--yaxley/5553226                                                       Same-sex marriage: A game of snakes and ladders?
    ##  6 abc-news-au 2017-06-27 01:00:11                                                                                                                                                   <NA>                                      Travel ban 3.0: What does Trump's latest ban mean for travellers?
    ##  7 abc-news-au 2017-06-27 00:05:19                                                                                                                                                   <NA>                                                      Australia Post names Christine Holgate as new CEO
    ##  8 abc-news-au 2017-06-27 01:50:18                                                                                                       http://www.abc.net.au/news/isabel-dayman/6417218                                           SA recycling business closes after $100k hike in power bills
    ##  9 abc-news-au 2017-06-26 23:40:28                                                                                                      http://www.abc.net.au/news/louise--yaxley/5553226                         Greens senator 'feeling bullied', blames 'leaker' for spreading misinformation
    ## 10 abc-news-au 2017-06-27 00:50:41                                                                                                                                                   <NA>                                                      Aussies taste victory and defeat in America's Cup
    ## # ... with 553 more rows, and 4 more variables: description <chr>,
    ## #   url <chr>, urlToImage <chr>, sortBy <chr>
