cm009 Exercises: tidy data
================

``` r
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: package 'tidyverse' was built under R version 3.5.1

    ## Warning: package 'tidyr' was built under R version 3.5.1

    ## Warning: package 'readr' was built under R version 3.5.1

    ## Warning: package 'purrr' was built under R version 3.5.1

    ## Warning: package 'dplyr' was built under R version 3.5.1

    ## Warning: package 'forcats' was built under R version 3.5.1

Reading and Writing Data: Exercises
-----------------------------------

Make a `tibble` of letters, their order in the alphabet, and then a pasting of the two columns together.

``` r
tibble( let = letters,
        num = 1:length(letters),
        comb = paste(let, num))
```

    ## # A tibble: 26 x 3
    ##    let     num comb 
    ##    <chr> <int> <chr>
    ##  1 a         1 a 1  
    ##  2 b         2 b 2  
    ##  3 c         3 c 3  
    ##  4 d         4 d 4  
    ##  5 e         5 e 5  
    ##  6 f         6 f 6  
    ##  7 g         7 g 7  
    ##  8 h         8 h 8  
    ##  9 i         9 i 9  
    ## 10 j        10 j 10 
    ## # ... with 16 more rows

``` r
######### tibble vs tribble
```

Make a `tribble` of three names and commute times.

``` r
tribble(
  ~name, ~commuteTime,
  "Frank", 30,
  "Lisa", 15,
  "Fred", 40
)
```

    ## # A tibble: 3 x 2
    ##   name  commuteTime
    ##   <chr>       <dbl>
    ## 1 Frank          30
    ## 2 Lisa           15
    ## 3 Fred           40

Write the `iris` data frame as a `csv`.

``` r
write.csv(iris, "iris.csv")
```

Write the `iris` data frame to a file delimited by a dollar sign.

``` r
write_delim(iris, "iris.txt", delim = "$")
```

Read the dollar-delimited `iris` data to a tibble.

``` r
read_delim("iris.txt", delim = "$")
```

    ## Parsed with column specification:
    ## cols(
    ##   Sepal.Length = col_double(),
    ##   Sepal.Width = col_double(),
    ##   Petal.Length = col_double(),
    ##   Petal.Width = col_double(),
    ##   Species = col_character()
    ## )

    ## # A tibble: 150 x 5
    ##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
    ##  1          5.1         3.5          1.4         0.2 setosa 
    ##  2          4.9         3            1.4         0.2 setosa 
    ##  3          4.7         3.2          1.3         0.2 setosa 
    ##  4          4.6         3.1          1.5         0.2 setosa 
    ##  5          5           3.6          1.4         0.2 setosa 
    ##  6          5.4         3.9          1.7         0.4 setosa 
    ##  7          4.6         3.4          1.4         0.3 setosa 
    ##  8          5           3.4          1.5         0.2 setosa 
    ##  9          4.4         2.9          1.4         0.2 setosa 
    ## 10          4.9         3.1          1.5         0.1 setosa 
    ## # ... with 140 more rows

Read these three LOTR csv's, saving them to `lotr1`, `lotr2`, and `lotr3`:

-   <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv>
-   <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv>
-   <https://github.com/jennybc/lotr-tidy/blob/master/data/The_Return_Of_The_King.csv>

``` r
lotr1 <- read.csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
lotr2 <- read.csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
lotr3 <- read.csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

`gather()`
----------

(Exercises largely based off of Jenny Bryan's [gather tutorial](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md))

This function is useful for making untidy data tidy (so that computers can more easily crunch the numbers).

1.  Combine the three LOTR untidy tables (`lotr1`, `lotr2`, `lotr3`) to a single untidy table by stacking them.

``` r
lotr_untidy <- bind_rows(lotr1, lotr2, lotr3)
```

    ## Warning in bind_rows_(x, .id): Unequal factor levels: coercing to character

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

1.  Convert to tidy. Also try this by specifying columns as a range, and with the `contains()` function.

``` r
gather(lotr_untidy, key = "Gender", value = "Word", Female, Male)
```

    ##                          Film   Race Gender Word
    ## 1  The Fellowship Of The Ring    Elf Female 1229
    ## 2  The Fellowship Of The Ring Hobbit Female   14
    ## 3  The Fellowship Of The Ring    Man Female    0
    ## 4              The Two Towers    Elf Female  331
    ## 5              The Two Towers Hobbit Female    0
    ## 6              The Two Towers    Man Female  401
    ## 7      The Return Of The King    Elf Female  183
    ## 8      The Return Of The King Hobbit Female    2
    ## 9      The Return Of The King    Man Female  268
    ## 10 The Fellowship Of The Ring    Elf   Male  971
    ## 11 The Fellowship Of The Ring Hobbit   Male 3644
    ## 12 The Fellowship Of The Ring    Man   Male 1995
    ## 13             The Two Towers    Elf   Male  513
    ## 14             The Two Towers Hobbit   Male 2463
    ## 15             The Two Towers    Man   Male 3589
    ## 16     The Return Of The King    Elf   Male  510
    ## 17     The Return Of The King Hobbit   Male 2673
    ## 18     The Return Of The King    Man   Male 2459

``` r
gather(lotr_untidy, key = "Gender", value = "Word", Female:Male)
```

    ##                          Film   Race Gender Word
    ## 1  The Fellowship Of The Ring    Elf Female 1229
    ## 2  The Fellowship Of The Ring Hobbit Female   14
    ## 3  The Fellowship Of The Ring    Man Female    0
    ## 4              The Two Towers    Elf Female  331
    ## 5              The Two Towers Hobbit Female    0
    ## 6              The Two Towers    Man Female  401
    ## 7      The Return Of The King    Elf Female  183
    ## 8      The Return Of The King Hobbit Female    2
    ## 9      The Return Of The King    Man Female  268
    ## 10 The Fellowship Of The Ring    Elf   Male  971
    ## 11 The Fellowship Of The Ring Hobbit   Male 3644
    ## 12 The Fellowship Of The Ring    Man   Male 1995
    ## 13             The Two Towers    Elf   Male  513
    ## 14             The Two Towers Hobbit   Male 2463
    ## 15             The Two Towers    Man   Male 3589
    ## 16     The Return Of The King    Elf   Male  510
    ## 17     The Return Of The King Hobbit   Male 2673
    ## 18     The Return Of The King    Man   Male 2459

``` r
gather(lotr_untidy, key = "Gender", value = "Word", contains("ale")) # all columns contains "ale" female, male ale
```

    ##                          Film   Race Gender Word
    ## 1  The Fellowship Of The Ring    Elf Female 1229
    ## 2  The Fellowship Of The Ring Hobbit Female   14
    ## 3  The Fellowship Of The Ring    Man Female    0
    ## 4              The Two Towers    Elf Female  331
    ## 5              The Two Towers Hobbit Female    0
    ## 6              The Two Towers    Man Female  401
    ## 7      The Return Of The King    Elf Female  183
    ## 8      The Return Of The King Hobbit Female    2
    ## 9      The Return Of The King    Man Female  268
    ## 10 The Fellowship Of The Ring    Elf   Male  971
    ## 11 The Fellowship Of The Ring Hobbit   Male 3644
    ## 12 The Fellowship Of The Ring    Man   Male 1995
    ## 13             The Two Towers    Elf   Male  513
    ## 14             The Two Towers Hobbit   Male 2463
    ## 15             The Two Towers    Man   Male 3589
    ## 16     The Return Of The King    Elf   Male  510
    ## 17     The Return Of The King Hobbit   Male 2673
    ## 18     The Return Of The King    Man   Male 2459

1.  Try again (bind and tidy the three untidy data frames), but without knowing how many tables there are originally.
    -   The additional work here does not require any additional tools from the tidyverse, but instead uses a `do.call` from base R -- a useful tool in data analysis when the number of "items" is variable/unknown, or quite large.

``` r
lotr_list <- list(lotr1, lotr2, lotr3)
lotr_list
```

    ## [[1]]
    ##                         Film   Race Female Male
    ## 1 The Fellowship Of The Ring    Elf   1229  971
    ## 2 The Fellowship Of The Ring Hobbit     14 3644
    ## 3 The Fellowship Of The Ring    Man      0 1995
    ## 
    ## [[2]]
    ##             Film   Race Female Male
    ## 1 The Two Towers    Elf    331  513
    ## 2 The Two Towers Hobbit      0 2463
    ## 3 The Two Towers    Man    401 3589
    ## 
    ## [[3]]
    ##                     Film   Race Female Male
    ## 1 The Return Of The King    Elf    183  510
    ## 2 The Return Of The King Hobbit      2 2673
    ## 3 The Return Of The King    Man    268 2459

``` r
## do.call(f,l) == f(l1,l2,l3)  supposed we dont know how many tables are there in lotr_list
do.call(bind_rows, lotr_list)   
```

    ## Warning in bind_rows_(x, .id): Unequal factor levels: coercing to character

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ## Warning in bind_rows_(x, .id): binding character and factor vector,
    ## coercing into character vector

    ##                         Film   Race Female Male
    ## 1 The Fellowship Of The Ring    Elf   1229  971
    ## 2 The Fellowship Of The Ring Hobbit     14 3644
    ## 3 The Fellowship Of The Ring    Man      0 1995
    ## 4             The Two Towers    Elf    331  513
    ## 5             The Two Towers Hobbit      0 2463
    ## 6             The Two Towers    Man    401 3589
    ## 7     The Return Of The King    Elf    183  510
    ## 8     The Return Of The King Hobbit      2 2673
    ## 9     The Return Of The King    Man    268 2459

`spread()`
----------

(Exercises largely based off of Jenny Bryan's [spread tutorial](https://github.com/jennybc/lotr-tidy/blob/master/03-spread.md))

This function is useful for making tidy data untidy (to be more pleasing to the eye).

Read in the tidy LOTR data (despite having just made it):

``` r
lotr_tidy <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Gender = col_character(),
    ##   Words = col_integer()
    ## )

Get word counts across "Race". Then try "Gender".

``` r
spread(lotr_tidy, key = "Race", value = "Words")  
```

    ## # A tibble: 6 x 5
    ##   Film                       Gender   Elf Hobbit   Man
    ##   <chr>                      <chr>  <int>  <int> <int>
    ## 1 The Fellowship Of The Ring Female  1229     14     0
    ## 2 The Fellowship Of The Ring Male     971   3644  1995
    ## 3 The Return Of The King     Female   183      2   268
    ## 4 The Return Of The King     Male     510   2673  2459
    ## 5 The Two Towers             Female   331      0   401
    ## 6 The Two Towers             Male     513   2463  3589

Now try combining race and gender. Use `unite()` from `tidyr` instead of `paste()`.

``` r
lotr_tidy %>% 
    unite(race_Gender, Race, Gender) %>%
  spread(key = "race_Gender", value = "Words")
```

    ## # A tibble: 3 x 7
    ##   Film   Elf_Female Elf_Male Hobbit_Female Hobbit_Male Man_Female Man_Male
    ##   <chr>       <int>    <int>         <int>       <int>      <int>    <int>
    ## 1 The F~       1229      971            14        3644          0     1995
    ## 2 The R~        183      510             2        2673        268     2459
    ## 3 The T~        331      513             0        2463        401     3589

``` r
lotr_tidy %>% 
    mutate(x = rnorm(nrow(lotr_tidy))) %>%  # if words more than 0 x is more than 0
  spread(key = "Gender", value = "x")
```

    ## Warning: package 'bindrcpp' was built under R version 3.5.1

    ## # A tibble: 18 x 5
    ##    Film                       Race   Words   Female    Male
    ##    <chr>                      <chr>  <int>    <dbl>   <dbl>
    ##  1 The Fellowship Of The Ring Elf      971  NA        1.33 
    ##  2 The Fellowship Of The Ring Elf     1229   0.239   NA    
    ##  3 The Fellowship Of The Ring Hobbit    14   0.571   NA    
    ##  4 The Fellowship Of The Ring Hobbit  3644  NA       -1.15 
    ##  5 The Fellowship Of The Ring Man        0  -0.874   NA    
    ##  6 The Fellowship Of The Ring Man     1995  NA        0.443
    ##  7 The Return Of The King     Elf      183   0.664   NA    
    ##  8 The Return Of The King     Elf      510  NA       -2.29 
    ##  9 The Return Of The King     Hobbit     2   0.0554  NA    
    ## 10 The Return Of The King     Hobbit  2673  NA        0.500
    ## 11 The Return Of The King     Man      268  -1.27    NA    
    ## 12 The Return Of The King     Man     2459  NA       -0.367
    ## 13 The Two Towers             Elf      331  -1.29    NA    
    ## 14 The Two Towers             Elf      513  NA        0.399
    ## 15 The Two Towers             Hobbit     0   0.0274  NA    
    ## 16 The Two Towers             Hobbit  2463  NA        0.491
    ## 17 The Two Towers             Man      401  -0.0631  NA    
    ## 18 The Two Towers             Man     3589  NA        0.465

Other `tidyr` goodies
---------------------

Check out the Examples in the documentation to explore the following.

`expand` vs `complete` (trim vs keep everything). Together with `nesting`. Check out the Examples in the `expand` documentation.

``` r
expand(mtcars, vs, cyl)   # vs has 0/1 cyl has 4/6/8 return all the possible group even not appear in dataframe 2*3 =6
```

    ## # A tibble: 6 x 2
    ##      vs   cyl
    ##   <dbl> <dbl>
    ## 1     0     4
    ## 2     0     6
    ## 3     0     8
    ## 4     1     4
    ## 5     1     6
    ## 6     1     8

``` r
df <- tibble(
  year   = c(2010, 2010, 2010, 2010, 2012, 2012, 2012),
  qtr    = c(   1,    2,    3,    4,    1,    2,    3),
  return = rnorm(7)
)

df %>% expand(year, qtr)
```

    ## # A tibble: 8 x 2
    ##    year   qtr
    ##   <dbl> <dbl>
    ## 1  2010     1
    ## 2  2010     2
    ## 3  2010     3
    ## 4  2010     4
    ## 5  2012     1
    ## 6  2012     2
    ## 7  2012     3
    ## 8  2012     4

``` r
df %>% expand(year = 2010:2012, qtr)
```

    ## # A tibble: 12 x 2
    ##     year   qtr
    ##    <int> <dbl>
    ##  1  2010     1
    ##  2  2010     2
    ##  3  2010     3
    ##  4  2010     4
    ##  5  2011     1
    ##  6  2011     2
    ##  7  2011     3
    ##  8  2011     4
    ##  9  2012     1
    ## 10  2012     2
    ## 11  2012     3
    ## 12  2012     4

``` r
df %>% expand(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 2
    ##     year   qtr
    ##    <dbl> <dbl>
    ##  1  2010     1
    ##  2  2010     2
    ##  3  2010     3
    ##  4  2010     4
    ##  5  2011     1
    ##  6  2011     2
    ##  7  2011     3
    ##  8  2011     4
    ##  9  2012     1
    ## 10  2012     2
    ## 11  2012     3
    ## 12  2012     4

``` r
df %>% complete(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 3
    ##     year   qtr   return
    ##    <dbl> <dbl>    <dbl>
    ##  1  2010     1   0.0551
    ##  2  2010     2   0.382 
    ##  3  2010     3  -0.738 
    ##  4  2010     4  -0.752 
    ##  5  2011     1  NA     
    ##  6  2011     2  NA     
    ##  7  2011     3  NA     
    ##  8  2011     4  NA     
    ##  9  2012     1   0.459 
    ## 10  2012     2  -2.28  
    ## 11  2012     3  -0.901 
    ## 12  2012     4  NA

``` r
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurment_1 = runif(6),
  measurment_2 = runif(6)
)

experiment
```

    ## # A tibble: 6 x 5
    ##   name   trt     rep measurment_1 measurment_2
    ##   <chr>  <chr> <dbl>        <dbl>        <dbl>
    ## 1 Alex   a         1        0.628        0.236
    ## 2 Alex   a         2        0.440        0.895
    ## 3 Alex   a         3        0.130        0.743
    ## 4 Robert b         1        0.339        0.538
    ## 5 Robert b         2        0.256        0.988
    ## 6 Sam    a         1        0.955        0.579

``` r
experiment %>% expand(name,trt,rep)
```

    ## # A tibble: 18 x 3
    ##    name   trt     rep
    ##    <chr>  <chr> <dbl>
    ##  1 Alex   a         1
    ##  2 Alex   a         2
    ##  3 Alex   a         3
    ##  4 Alex   b         1
    ##  5 Alex   b         2
    ##  6 Alex   b         3
    ##  7 Robert a         1
    ##  8 Robert a         2
    ##  9 Robert a         3
    ## 10 Robert b         1
    ## 11 Robert b         2
    ## 12 Robert b         3
    ## 13 Sam    a         1
    ## 14 Sam    a         2
    ## 15 Sam    a         3
    ## 16 Sam    b         1
    ## 17 Sam    b         2
    ## 18 Sam    b         3

``` r
experiment %>% expand(nesting(name,trt),rep)
```

    ## # A tibble: 9 x 3
    ##   name   trt     rep
    ##   <chr>  <chr> <dbl>
    ## 1 Alex   a         1
    ## 2 Alex   a         2
    ## 3 Alex   a         3
    ## 4 Robert b         1
    ## 5 Robert b         2
    ## 6 Robert b         3
    ## 7 Sam    a         1
    ## 8 Sam    a         2
    ## 9 Sam    a         3

`separate_rows`: useful when you have a variable number of entries in a "cell".

``` r
df <- data.frame(
  x = 1:3,
  y = c("a", "d,e,f", "g,h"),
  z = c("1", "2,3,4", "5,6"),
  stringsAsFactors = FALSE
)
separate_rows(df, y, z, convert = TRUE)
```

    ##   x y z
    ## 1 1 a 1
    ## 2 2 d 2
    ## 3 2 e 3
    ## 4 2 f 4
    ## 5 3 g 5
    ## 6 3 h 6

`unite` and `separate`.

`uncount` (as the opposite of `dplyr::count()`)

``` r
df <- tibble::tibble(x = c("a", "b"), n = c(1, 2))
uncount(df, n)
```

    ## # A tibble: 3 x 1
    ##   x    
    ##   <chr>
    ## 1 a    
    ## 2 b    
    ## 3 b

``` r
uncount(df, n, .id = "id")
```

    ## # A tibble: 3 x 2
    ##   x        id
    ##   <chr> <int>
    ## 1 a         1
    ## 2 b         1
    ## 3 b         2

`drop_na` and `replace_na`

`fill`

``` r
df <- data.frame(Month = 1:12, Year = c(2000, rep(NA, 11)))
df %>% fill(Year)
```

    ##    Month Year
    ## 1      1 2000
    ## 2      2 2000
    ## 3      3 2000
    ## 4      4 2000
    ## 5      5 2000
    ## 6      6 2000
    ## 7      7 2000
    ## 8      8 2000
    ## 9      9 2000
    ## 10    10 2000
    ## 11    11 2000
    ## 12    12 2000

`full_seq`

Time remaining?
---------------

Time permitting, do [this exercise](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md#exercises) to practice tidying data.
