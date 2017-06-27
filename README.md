
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

Install
-------

-   Install from Github

``` r
## install script
if (!"devtools" %in% installed.packages()) {
  install.packages("devtools")
}
devtools::install_github("mkearney/newsAPI")

## load package
library(newsAPI)
```

Demo
----

-   Get all available news sources

``` r
## get all english language news sources (made available by newsapi.org)
src <- get_sources(language = "en")

## preview data
print(src, width = 500)
```

    ## # A tibble: 60 x 9
    ##                     id                  name                                                                                                                                                                                                                                                  description                            url   category language country urlsToLogos sortBysAvailable
    ##                  <chr>                 <chr>                                                                                                                                                                                                                                                        <chr>                          <chr>      <chr>    <chr>   <chr>       <chr>            <chr>
    ##  1         abc-news-au         ABC News (AU)                                                                                              Australia's most trusted source of local, national and world news. Comprehensive, independent, in-depth analysis, the latest business, sport, weather and more.     http://www.abc.net.au/news    general       en      au                          top
    ##  2  al-jazeera-english    Al Jazeera English                                                                                                        News, analysis from the Middle East and worldwide, multimedia and interactives, opinions, documentaries, podcasts, long reads and broadcast schedule.       http://www.aljazeera.com    general       en      us                   top latest
    ##  3        ars-technica          Ars Technica                                                                                                                                                               The PC enthusiast's resource. Power users and the tools they love, without computing religion.         http://arstechnica.com technology       en      us                   top latest
    ##  4    associated-press      Associated Press                                                                                                                                               The AP delivers in-depth coverage on the international, politics, lifestyle, business, and entertainment news.            https://apnews.com/    general       en      us                          top
    ##  5            bbc-news              BBC News          Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news as well as local and regional perspectives. Also entertainment, business, science, technology and health news.      http://www.bbc.co.uk/news    general       en      gb                          top
    ##  6           bbc-sport             BBC Sport The home of BBC Sport online. Includes live sports coverage, breaking news, results, video, audio and analysis on Football, F1, Cricket, Rugby Union, Rugby League, Golf, Tennis and all the main world sports, plus major events such as the Olympic Games.     http://www.bbc.co.uk/sport      sport       en      gb                          top
    ##  7           bloomberg             Bloomberg                                                                                                                Bloomberg delivers business and markets news, data, analysis, and video to the world, featuring stories from Businessweek and Bloomberg News.       http://www.bloomberg.com   business       en      us                          top
    ##  8      breitbart-news        Breitbart News                                                                                                                                               Syndicated news and opinion website providing continuously updated headlines to top news and analysis sources.       http://www.breitbart.com   politics       en      us                   top latest
    ##  9    business-insider      Business Insider                                                                Business Insider is a fast-growing business site with deep financial, media, tech, and other industry verticals. Launched in 2007, the site is now the largest business news site on the web. http://www.businessinsider.com   business       en      us                   top latest
    ## 10 business-insider-uk Business Insider (UK)                                                                Business Insider is a fast-growing business site with deep financial, media, tech, and other industry verticals. Launched in 2007, the site is now the largest business news site on the web.  http://uk.businessinsider.com   business       en      gb                   top latest
    ## # ... with 50 more rows

-   Pass news source names (IDs) to `get_articles` function

``` r
## apply get_articles function to each news source
df <- lapply(src$id, get_articles)

## collapse into single data frame
df <- do.call("rbind", df)

## preview data
print(df, width = 500)
```

    ## # A tibble: 564 x 8
    ##         source         publishedAt                                                                                                                                                 author                                                                                    title                                                                                                                                                                                     description
    ##          <chr>              <dttm>                                                                                                                                                  <chr>                                                                                    <chr>                                                                                                                                                                                           <chr>
    ##  1 abc-news-au 2017-06-27 10:04:23                                                                                                       http://www.abc.net.au/news/andrew-probyn/8259322              'There's a jungle drum': Furious Liberal MPs pressure Turnbull to dump Pyne              Christopher Pyne's secretly recorded comments have triggered widespread anger in Liberal Party, with the Prime Minister pressured to strip him of his role as Leader of the House.
    ##  2 abc-news-au 2017-06-27 08:56:23                                                                                                                                                   <NA>                                     Navy member deployed on border patrol operation dies                                                    A Royal Australian Navy member deployed on a border patrol operation has died, Defence says, adding the cause of the death is not yet known.
    ##  3 abc-news-au 2017-06-27 07:55:35 http://www.abc.net.au/news/catherine-hanrahan/7901852, http://www.abc.net.au/news/simon-elvery/5449816, http://www.abc.net.au/news/joshua-byrd/8609896                                                          This is Australia as 100 people                                                                                If Australia were just 100 people, what would it look like? New census data gives us an opportunity to find out.
    ##  4 abc-news-au 2017-06-27 14:00:46                                                                                                         http://www.abc.net.au/news/jane-norman/5873958                      'He didn't have the courage': Turnbull's backers hit back at Abbott                                                Malcolm Turnbull's loyalists hit back at Tony Abbott, accusing him of pushing for policies that he never had the courage to implement as leader.
    ##  5 abc-news-au 2017-06-27 07:57:58                                                                                                    http://www.abc.net.au/news/peter-mccutcheon/2741774 'You can't put a value on this': Breaker Morant's possessions may have been found at tip An arms expert is convinced a priceless collection of Boer War items found in a hessian bag at a New South Wales rubbish tip once belonged to fabled British-Australian soldier Breaker Morant.
    ##  6 abc-news-au 2017-06-27 13:29:51                                                                                                                                                   <NA>                           Kiev car bomb kills colonel in Ukrainian military intelligence                                                                          A colonel in Ukraine's military intelligence is killed by a car bomb terrorist act in Kiev, the Defence Ministry says.
    ##  7 abc-news-au 2017-06-27 14:47:37                                                                                                                                                   <NA>                             Hackers strike across Europe, sparking widespread disruption                                                                                                         Hackers cause widespread disruption across Europe with a series of major cyber attacks.
    ##  8 abc-news-au 2017-06-27 08:47:18                                                                                                           http://www.abc.net.au/news/nick-dole/6279964                                    Sydney bio-hacker has travel card implanted into hand                       Would you be more likely to catch public transport if your Opal card was under your very own skin? Well, one Sydney man has done just this and now taps on with his hand.
    ##  9 abc-news-au 2017-06-27 12:26:17                                                                                                                                                   <NA>                                                     EU fines Google record $3.57 billion                                                                                                          The European Union's competition watchdog slaps a record $3.57 billion fine on Google.
    ## 10 abc-news-au 2017-06-27 08:20:10                                                                                                                                                   <NA>          'Afraid to have children': Climate scientists reveal their fears for the future                                              Some are scared to have children, others are planning to leave the country. Top climate scientists speak about their biggest fears for the future.
    ## # ... with 554 more rows, and 3 more variables: url <chr>,
    ## #   urlToImage <chr>, sortBy <chr>
