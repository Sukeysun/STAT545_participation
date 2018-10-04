cm010 Exercises
================

Install `nycflights13` package
------------------------------

``` r
install.packages("nycflights13")
```

``` r
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: package 'tidyverse' was built under R version 3.5.1

    ## Warning: package 'tidyr' was built under R version 3.5.1

    ## Warning: package 'readr' was built under R version 3.5.1

    ## Warning: package 'purrr' was built under R version 3.5.1

    ## Warning: package 'dplyr' was built under R version 3.5.1

    ## Warning: package 'forcats' was built under R version 3.5.1

``` r
suppressPackageStartupMessages(library(nycflights13))
```

    ## Warning: package 'nycflights13' was built under R version 3.5.1

Types of mutating join
----------------------

### Let's join tibbles using four mutating functions: `left_join`, `right_join`, `inner_join` and `full_join`.

-   create two tibbles named `a` and `b`, similar to Data Wrangling Cheatsheet.
-   use `left_join`, `right_join`, `inner_join` and `full_join` functions
-   example for `left_join`: Join matching rows from b to a
-   example for `right_join`: Join matching rows from a to b
-   example for `inner_join`: Join data. Retain only rows in both sets
-   example for `full_join`: Join data. Retain all values, all rows
-   example of using two different variables from two datasets
-   example of two variables have identical names

### create two tibbles named `a` and `b`

``` r
(a <- tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
(b <- tibble(x1 = LETTERS[c(1,2,4)], x3 = c("T", "F", "T")))
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F    
    ## 3 D     T

### left\_join: Join matching rows from `b` to `a` by matching "x1" variable

``` r
left_join(a, b, by = "x1")   ## this new table contains all x1 values of left table
```

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 C         3 <NA>

### right\_join: Join matching rows from `a` to `b` by matching "x1" variable.

``` r
right_join(a, b, by = "x1")  ## all x1 values from b table
```

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 D        NA T

### inner\_join: Join data. Retain only rows in both sets `a` to `b` by matching "x1" variable.

``` r
inner_join(a, b, by = "x1")   ## only x1 values both from a and b
```

    ## # A tibble: 2 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F

### full\_join: Join data. Retain all values, all rows of `a` to `b` by matching "x1"

``` r
full_join(a, b, by = "x1") ## all x1 values 
```

    ## # A tibble: 4 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 C         3 <NA> 
    ## 4 D        NA T

### what happen if we do not specify `by` option?

``` r
left_join(a, b)   ## it reports error: joining by "x1" 
```

    ## Joining, by = "x1"

    ## # A tibble: 3 x 3
    ##   x1       x2 x3   
    ##   <chr> <int> <chr>
    ## 1 A         1 T    
    ## 2 B         2 F    
    ## 3 C         3 <NA>

### what happen if we specify two different variables from two tibbles `a` to `b`?

``` r
left_join(a, b, by = c("x1" = "x3"))  ## x1 from a and x3 from b. if they dont match, then returns NA
```

    ## # A tibble: 3 x 3
    ##   x1       x2 x1.y 
    ##   <chr> <int> <chr>
    ## 1 A         1 <NA> 
    ## 2 B         2 <NA> 
    ## 3 C         3 <NA>

### what happen if two columns of `a` and `c` datasets have the identical names?

``` r
# make data frame c and use inner_join()
(c <- tibble(x1 = c(LETTERS[1:2],"x"), x2 = c(1,4,5)))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         4
    ## 3 x         5

``` r
inner_join(a, c)
```

    ## Joining, by = c("x1", "x2")

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1

In class practice
-----------------

`nycflights13` dataset has four tibbles e.g., `flights`, `airports`, `planes` and `weather`.

### Explore and subset data:

-   Explore `nycflights13` dataset
-   to reduce the running time, subset `flights` data.frame taking first 1000 rows and year, tailnum, carrier, time\_hour columns.

### Practice Exercises:

-   check which variables are common in `weather` and `flights2` datasets
-   add `weather` information to the `flights2` dataset by matching "year" and "time\_hour" variables. -add `weather` information to the `flights2` dataset by matching only "time\_hour" variable.

### 1. Explore `nycflights13` dataset

``` r
#check the tibbles included in `nycflights13` package
class(flights)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
colnames(flights)
```

    ##  [1] "year"           "month"          "day"            "dep_time"      
    ##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
    ##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
    ## [13] "origin"         "dest"           "air_time"       "distance"      
    ## [17] "hour"           "minute"         "time_hour"

``` r
colnames(airports)
```

    ## [1] "faa"   "name"  "lat"   "lon"   "alt"   "tz"    "dst"   "tzone"

``` r
colnames(planes)
```

    ## [1] "tailnum"      "year"         "type"         "manufacturer"
    ## [5] "model"        "engines"      "seats"        "speed"       
    ## [9] "engine"

``` r
colnames(weather)
```

    ##  [1] "origin"     "year"       "month"      "day"        "hour"      
    ##  [6] "temp"       "dewp"       "humid"      "wind_dir"   "wind_speed"
    ## [11] "wind_gust"  "precip"     "pressure"   "visib"      "time_hour"

### 2. Drop unimportant variables so it's easier to understand the join results. Also take first 1000 rows to run it faster.

``` r
flights2 <- flights[1:1000,] %>% 
  select(year, tailnum, carrier, time_hour)

dim(flights2)
```

    ## [1] 1000    4

``` r
colnames(flights2)
```

    ## [1] "year"      "tailnum"   "carrier"   "time_hour"

### 3. Add airline names to `flights2` from `airlines` dataset.

``` r
# Which join function to use?
colnames(airlines)
```

    ## [1] "carrier" "name"

``` r
colnames(flights2)
```

    ## [1] "year"      "tailnum"   "carrier"   "time_hour"

``` r
flights2 %>% 
  left_join(airlines)
```

    ## Joining, by = "carrier"

    ## # A tibble: 1,000 x 5
    ##     year tailnum carrier time_hour           name                    
    ##    <int> <chr>   <chr>   <dttm>              <chr>                   
    ##  1  2013 N14228  UA      2013-01-01 05:00:00 United Air Lines Inc.   
    ##  2  2013 N24211  UA      2013-01-01 05:00:00 United Air Lines Inc.   
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00 American Airlines Inc.  
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00 JetBlue Airways         
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00 Delta Air Lines Inc.    
    ##  6  2013 N39463  UA      2013-01-01 05:00:00 United Air Lines Inc.   
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00 JetBlue Airways         
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00 ExpressJet Airlines Inc.
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00 JetBlue Airways         
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00 American Airlines Inc.  
    ## # ... with 990 more rows

### 4. Add weather information to the `flights2` dataset by matching "year" and "time\_hour" variables.

``` r
colnames(weather)
```

    ##  [1] "origin"     "year"       "month"      "day"        "hour"      
    ##  [6] "temp"       "dewp"       "humid"      "wind_dir"   "wind_speed"
    ## [11] "wind_gust"  "precip"     "pressure"   "visib"      "time_hour"

``` r
flights2 %>% left_join(weather, by = c("year", "time_hour"))
```

    ## # A tibble: 2,888 x 17
    ##     year tailnum carrier time_hour           origin month   day  hour
    ##    <dbl> <chr>   <chr>   <dttm>              <chr>  <dbl> <int> <int>
    ##  1  2013 N14228  UA      2013-01-01 05:00:00 EWR        1     1     5
    ##  2  2013 N14228  UA      2013-01-01 05:00:00 JFK        1     1     5
    ##  3  2013 N14228  UA      2013-01-01 05:00:00 LGA        1     1     5
    ##  4  2013 N24211  UA      2013-01-01 05:00:00 EWR        1     1     5
    ##  5  2013 N24211  UA      2013-01-01 05:00:00 JFK        1     1     5
    ##  6  2013 N24211  UA      2013-01-01 05:00:00 LGA        1     1     5
    ##  7  2013 N619AA  AA      2013-01-01 05:00:00 EWR        1     1     5
    ##  8  2013 N619AA  AA      2013-01-01 05:00:00 JFK        1     1     5
    ##  9  2013 N619AA  AA      2013-01-01 05:00:00 LGA        1     1     5
    ## 10  2013 N804JB  B6      2013-01-01 05:00:00 EWR        1     1     5
    ## # ... with 2,878 more rows, and 9 more variables: temp <dbl>, dewp <dbl>,
    ## #   humid <dbl>, wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>,
    ## #   precip <dbl>, pressure <dbl>, visib <dbl>

### 5. Add `weather` information to the `flights2` dataset by matching only "time\_hour" variable

``` r
flights2 %>% left_join(weather, by = "time_hour")
```

    ## # A tibble: 2,888 x 18
    ##    year.x tailnum carrier time_hour           origin year.y month   day
    ##     <int> <chr>   <chr>   <dttm>              <chr>   <dbl> <dbl> <int>
    ##  1   2013 N14228  UA      2013-01-01 05:00:00 EWR      2013     1     1
    ##  2   2013 N14228  UA      2013-01-01 05:00:00 JFK      2013     1     1
    ##  3   2013 N14228  UA      2013-01-01 05:00:00 LGA      2013     1     1
    ##  4   2013 N24211  UA      2013-01-01 05:00:00 EWR      2013     1     1
    ##  5   2013 N24211  UA      2013-01-01 05:00:00 JFK      2013     1     1
    ##  6   2013 N24211  UA      2013-01-01 05:00:00 LGA      2013     1     1
    ##  7   2013 N619AA  AA      2013-01-01 05:00:00 EWR      2013     1     1
    ##  8   2013 N619AA  AA      2013-01-01 05:00:00 JFK      2013     1     1
    ##  9   2013 N619AA  AA      2013-01-01 05:00:00 LGA      2013     1     1
    ## 10   2013 N804JB  B6      2013-01-01 05:00:00 EWR      2013     1     1
    ## # ... with 2,878 more rows, and 10 more variables: hour <int>, temp <dbl>,
    ## #   dewp <dbl>, humid <dbl>, wind_dir <dbl>, wind_speed <dbl>,
    ## #   wind_gust <dbl>, precip <dbl>, pressure <dbl>, visib <dbl>

Types of filtering join
-----------------------

### Let's filter tibbles using two filtering functions:

-   create two tibbles named `a` and `b`, similar to Data Wrangling Cheatsheet
-   use `semi_join`, `anti_join` functions
-   example for `semi_join`: All rows in a that have a match in b
-   example for `anti_join`: All rows in a that do not have a match in b
-   example of using two different variables from two datasets

### example for `semi_join`: All rows in `a` that have a match in `b`

``` r
semi_join(a,b)
```

    ## Joining, by = "x1"

    ## # A tibble: 2 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2

``` r
a
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
b
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 B     F    
    ## 3 D     T

example for `anti_join`: All rows in `a` that do not have a match in `b`
========================================================================

``` r
anti_join(a,b, by = "x1")
```

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 C         3

example of joinin by matching two variables from both datasets `a` and `c`
==========================================================================

``` r
semi_join(a, c, by = c("x1", "x2"))  ## x1 from a and x2 from c
```

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1

Types of Set Operations for two datasets
----------------------------------------

### Let's use three `set` functions:

-   create two tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet
-   use `intersect`, `union` and `setdiff` functions
-   example for `intersect`: Rows that appear in both `y` and `z`
-   example for `union`: Rows that appear in either or both `y` and `z`
-   example for `setdiff`: Rows that appear in `y` but not `z`. **Caution:** `setdiff` for `y` to `z` and `z` to `y` are different.
-   what happen if colnames are different?

### create two tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet

``` r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

### example for `intersect`: Rows that appear in both `y` and `z`

``` r
intersect(y,z)
```

    ## # A tibble: 2 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3

### example for `union`: Rows that appear in either or both `y` and `z`

``` r
union(y,z)
```

    ## # A tibble: 4 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 D         4
    ## 3 A         1
    ## 4 C         3

example for `setdiff`: Rows that appear in `y` but not `z`. **Caution:** `setdiff` for `y` to `z` and `z` to `y` are different.
===============================================================================================================================

``` r
setdiff(y,z)
```

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1

``` r
setdiff(z,y)
```

    ## # A tibble: 1 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 D         4

what happen if colnames are differentin `y` and `x`? Is there any error message and why?
========================================================================================

``` r
(x <- tibble(x1 = c("B", "C", "D"), x3 = 2:4))
```

    ## # A tibble: 3 x 2
    ##   x1       x3
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

``` r
y
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3

``` r
z
```

    ## # A tibble: 3 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

``` r
intersect(y,z)
```

    ## # A tibble: 2 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3

``` r
# 
# intersect(y,x) # colnames must same
```

Types of binding datasets
-------------------------

### Let's bind datasets by rows or column using two binding functions:

-   create two tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet
-   use `bind_rows`, `bind_cols` functions
-   example for `bind_rows`: Append z to y as new rows
-   example for `bind_cols`: Append z to y as new columns. **Caution**: matches rows by position
-   what happen if colnames are different?

### example for `bind_rows`: Append z to y as new rows

``` r
## dont need have same column names
bind_rows(y,z)
```

    ## # A tibble: 6 x 2
    ##   x1       x2
    ##   <chr> <int>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3
    ## 4 B         2
    ## 5 C         3
    ## 6 D         4

``` r
bind_rows(x,y)
```

    ## # A tibble: 6 x 3
    ##   x1       x3    x2
    ##   <chr> <int> <int>
    ## 1 B         2    NA
    ## 2 C         3    NA
    ## 3 D         4    NA
    ## 4 A        NA     1
    ## 5 B        NA     2
    ## 6 C        NA     3

### example for `bind_cols`: Append z to y as new columns. **Caution**: matches rows by position

``` r
## dont need have same column names
bind_cols(y,z) #check colnames
```

    ## # A tibble: 3 x 4
    ##   x1       x2 x11     x21
    ##   <chr> <int> <chr> <int>
    ## 1 A         1 B         2
    ## 2 B         2 C         3
    ## 3 C         3 D         4

``` r
bind_cols(z,y)
```

    ## # A tibble: 3 x 4
    ##   x1       x2 x11     x21
    ##   <chr> <int> <chr> <int>
    ## 1 B         2 A         1
    ## 2 C         3 B         2
    ## 3 D         4 C         3

``` r
bind_cols(x,y)
```

    ## # A tibble: 3 x 4
    ##   x1       x3 x11      x2
    ##   <chr> <int> <chr> <int>
    ## 1 B         2 A         1
    ## 2 C         3 B         2
    ## 3 D         4 C         3

### what happen if colnames are different?

``` r
(x <- tibble(x1 = c("B", "C", "D"), x3 = 2:4))
```

    ## # A tibble: 3 x 2
    ##   x1       x3
    ##   <chr> <int>
    ## 1 B         2
    ## 2 C         3
    ## 3 D         4

``` r
bind_rows(y,x)
```

    ## # A tibble: 6 x 3
    ##   x1       x2    x3
    ##   <chr> <int> <int>
    ## 1 A         1    NA
    ## 2 B         2    NA
    ## 3 C         3    NA
    ## 4 B        NA     2
    ## 5 C        NA     3
    ## 6 D        NA     4

``` r
bind_cols(y,x)
```

    ## # A tibble: 3 x 4
    ##   x1       x2 x11      x3
    ##   <chr> <int> <chr> <int>
    ## 1 A         1 B         2
    ## 2 B         2 C         3
    ## 3 C         3 D         4

Practice Exercises
------------------

Practice these concepts in the following exercises. It might help you to first identify the type of function you are applying.

### 1. Filter the rows of `flights2` by matching "year" and "time\_hour" variables to `weather` dataset. Use both `semi_join()` and `anti_join()`

``` r
semi_join(flights2, weather, by = c("year", "time_hour"))  ## return 1000 rows
```

    ## # A tibble: 1,000 x 4
    ##     year tailnum carrier time_hour          
    ##    <int> <chr>   <chr>   <dttm>             
    ##  1  2013 N14228  UA      2013-01-01 05:00:00
    ##  2  2013 N24211  UA      2013-01-01 05:00:00
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00
    ##  6  2013 N39463  UA      2013-01-01 05:00:00
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00
    ## # ... with 990 more rows

``` r
anti_join(flights2, weather, by = c("year", "time_hour"))  ## returns 0 row
```

    ## # A tibble: 0 x 4
    ## # ... with 4 variables: year <int>, tailnum <chr>, carrier <chr>,
    ## #   time_hour <dttm>

### 2. Can we apply `set` and `binding` funcions between `flights2` and `weather` datasets. Why and why not?

``` r
aa <- colnames(flights2)
bb <- colnames(weather)
intersect(aa,bb)   ## return only year and timehour
```

    ## [1] "year"      "time_hour"

``` r
#intersect(flights2, weather) ## they dont have same column names
#setdiff(flights2, weather)    ## they dont have same column names

# union(flights2,weather)     ## they dont have same column names
bind_rows(flights2, weather)  
```

    ## # A tibble: 27,115 x 17
    ##     year tailnum carrier time_hour           origin month   day  hour
    ##    <dbl> <chr>   <chr>   <dttm>              <chr>  <dbl> <int> <int>
    ##  1  2013 N14228  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA
    ##  2  2013 N24211  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA
    ##  3  2013 N619AA  AA      2013-01-01 05:00:00 <NA>      NA    NA    NA
    ##  4  2013 N804JB  B6      2013-01-01 05:00:00 <NA>      NA    NA    NA
    ##  5  2013 N668DN  DL      2013-01-01 06:00:00 <NA>      NA    NA    NA
    ##  6  2013 N39463  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA
    ##  7  2013 N516JB  B6      2013-01-01 06:00:00 <NA>      NA    NA    NA
    ##  8  2013 N829AS  EV      2013-01-01 06:00:00 <NA>      NA    NA    NA
    ##  9  2013 N593JB  B6      2013-01-01 06:00:00 <NA>      NA    NA    NA
    ## 10  2013 N3ALAA  AA      2013-01-01 06:00:00 <NA>      NA    NA    NA
    ## # ... with 27,105 more rows, and 9 more variables: temp <dbl>, dewp <dbl>,
    ## #   humid <dbl>, wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>,
    ## #   precip <dbl>, pressure <dbl>, visib <dbl>

``` r
#bind_cols(flights2, weather) ## two dataframe must have same length


sub_flights2 <- flights2 %>% 
  select("year", "time_hour")

sub_weather <- weather[1:1000,] %>% 
  select("year", "time_hour")

intersect(sub_flights2, sub_weather) 
```

    ## # A tibble: 24 x 2
    ##     year time_hour          
    ##    <dbl> <dttm>             
    ##  1  2013 2013-01-01 05:00:00
    ##  2  2013 2013-01-01 06:00:00
    ##  3  2013 2013-01-01 07:00:00
    ##  4  2013 2013-01-01 08:00:00
    ##  5  2013 2013-01-01 09:00:00
    ##  6  2013 2013-01-01 10:00:00
    ##  7  2013 2013-01-01 11:00:00
    ##  8  2013 2013-01-01 13:00:00
    ##  9  2013 2013-01-01 14:00:00
    ## 10  2013 2013-01-01 15:00:00
    ## # ... with 14 more rows

``` r
setdiff(sub_flights2, sub_weather)   
```

    ## # A tibble: 1 x 2
    ##    year time_hour          
    ##   <dbl> <dttm>             
    ## 1  2013 2013-01-01 12:00:00

``` r
union(sub_flights2,sub_weather)     
```

    ## # A tibble: 1,001 x 2
    ##     year time_hour          
    ##    <dbl> <dttm>             
    ##  1  2013 2013-02-04 07:00:00
    ##  2  2013 2013-01-26 15:00:00
    ##  3  2013 2013-01-09 10:00:00
    ##  4  2013 2013-01-02 00:00:00
    ##  5  2013 2013-02-10 01:00:00
    ##  6  2013 2013-02-01 09:00:00
    ##  7  2013 2013-01-15 04:00:00
    ##  8  2013 2013-01-07 18:00:00
    ##  9  2013 2013-02-03 18:00:00
    ## 10  2013 2013-01-26 02:00:00
    ## # ... with 991 more rows

``` r
bind_rows(sub_flights2, sub_weather)  
```

    ## # A tibble: 2,000 x 2
    ##     year time_hour          
    ##    <dbl> <dttm>             
    ##  1  2013 2013-01-01 05:00:00
    ##  2  2013 2013-01-01 05:00:00
    ##  3  2013 2013-01-01 05:00:00
    ##  4  2013 2013-01-01 05:00:00
    ##  5  2013 2013-01-01 06:00:00
    ##  6  2013 2013-01-01 05:00:00
    ##  7  2013 2013-01-01 06:00:00
    ##  8  2013 2013-01-01 06:00:00
    ##  9  2013 2013-01-01 06:00:00
    ## 10  2013 2013-01-01 06:00:00
    ## # ... with 1,990 more rows

``` r
bind_cols(sub_flights2, sub_weather) 
```

    ## # A tibble: 1,000 x 4
    ##     year time_hour           year1 time_hour1         
    ##    <int> <dttm>              <dbl> <dttm>             
    ##  1  2013 2013-01-01 05:00:00  2013 2013-01-01 01:00:00
    ##  2  2013 2013-01-01 05:00:00  2013 2013-01-01 02:00:00
    ##  3  2013 2013-01-01 05:00:00  2013 2013-01-01 03:00:00
    ##  4  2013 2013-01-01 05:00:00  2013 2013-01-01 04:00:00
    ##  5  2013 2013-01-01 06:00:00  2013 2013-01-01 05:00:00
    ##  6  2013 2013-01-01 05:00:00  2013 2013-01-01 06:00:00
    ##  7  2013 2013-01-01 06:00:00  2013 2013-01-01 07:00:00
    ##  8  2013 2013-01-01 06:00:00  2013 2013-01-01 08:00:00
    ##  9  2013 2013-01-01 06:00:00  2013 2013-01-01 09:00:00
    ## 10  2013 2013-01-01 06:00:00  2013 2013-01-01 10:00:00
    ## # ... with 990 more rows

### 3. Let's create a tibble `p` with "x1" and "x2" coulmns and have duplicated element in "x1" column. Create another tibble `q` with "x1" and "x3" columns. Then apply `left_join` function `p` to `q` and `q` to `p`.

``` r
(p <- tibble(x1 = c("A","B","C","A"),
                  x2 = c(1,2,3,4)))
```

    ## # A tibble: 4 x 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         3
    ## 4 A         4

``` r
(q <- tibble(x1 = c("A","b","C"),
             x3 = c("T","F","T")))
```

    ## # A tibble: 3 x 2
    ##   x1    x3   
    ##   <chr> <chr>
    ## 1 A     T    
    ## 2 b     F    
    ## 3 C     T

``` r
p %>% 
  left_join(q, by = "x1")
```

    ## # A tibble: 4 x 3
    ##   x1       x2 x3   
    ##   <chr> <dbl> <chr>
    ## 1 A         1 T    
    ## 2 B         2 <NA> 
    ## 3 C         3 T    
    ## 4 A         4 T

``` r
q %>% 
  left_join(p, by = "x1")
```

    ## # A tibble: 4 x 3
    ##   x1    x3       x2
    ##   <chr> <chr> <dbl>
    ## 1 A     T         1
    ## 2 A     T         4
    ## 3 b     F        NA
    ## 4 C     T         3
