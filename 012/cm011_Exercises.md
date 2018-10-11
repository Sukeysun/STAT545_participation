cm011 Exercises: R as a programming language
================

Part I
======

Types and Modes and Classes, Oh My!
-----------------------------------

R objects have a *type*, a *mode*, and a *class*. This can be confusing:

``` r
a <- 3
print(typeof(a))
```

    ## [1] "double"

``` r
print(mode(a))
```

    ## [1] "numeric"

``` r
print(class(a))
```

    ## [1] "numeric"

``` r
print(typeof(iris))
```

    ## [1] "list"

``` r
print(mode(iris))
```

    ## [1] "list"

``` r
print(class(iris))
```

    ## [1] "data.frame"

``` r
print(typeof(sum))
```

    ## [1] "builtin"

``` r
print(mode(sum))
```

    ## [1] "function"

``` r
print(class(sum))
```

    ## [1] "function"

Usually, there's no need to fuss about these differences: just use the `is.*()` family of functions. Give it a try:

We can also coerce objects to take on a different form, typically using the `as.*()` family of functions. We can't always coerce! You'll get a sense of this over time, but try:

-   Coercing a number to a character.
-   Coercing a character to a number.
-   Coercing a number to a data.frame. `letters` to a data.frame.

There is also a slight difference between coercion and conversion, but this is usually not important.

Vectors
-------

Vectors store multiple entries of a data type. You'll discover that they show up just about everywhere in R, so they're fundamental and extremely important.

### Vector Construction and Basic Subsetting

We've seen vectors as columns of data frames:

``` r
mtcars$hp
```

    ##  [1] 110 110  93 110 175 105 245  62  95 123 123 180 180 180 205 215 230
    ## [18]  66  52  65  97 150 150 245 175  66  91 113 264 175 335 109

Use the `c()` function to make a vector consisting of the course code (`"STAT"` and `545`). Notice the coercion. Vectors must be homogeneous.

Subset the first entry. Remove the first entry. Note the base-1 system.

Use `<-` to change the second entry to "545A". Using the same approach, add a third entry, "S01".

Subset the first and third entry. Order matters! Subset the third and first entry.

Explore integer sequences, especially negatives and directions. Especially `1:0` that might show up in loops!

Singletons are also vectors. Check using `is.vector`.

### Vectorization and Recycling

A key aspect of R is its vectorization. Let's work with the vector following vector:

``` r
(a <- 7:-2)
```

    ##  [1]  7  6  5  4  3  2  1  0 -1 -2

``` r
(n <- length(a))
```

    ## [1] 10

Square each component:

Multiply each component by 1 through its length:

It's important to know that R will silently recycle! Unless the length of one vector is not divisible by the other. Let's see:

This is true of comparison operators, too. Make a vector of logicals using a comparison operator.

Now try a boolean operator. Note that && and || are NOT vectorized!

Recycling works with assignment, too. Replace the entire vector a with 1:2 repeated:

### Special Subsetting

We can subset vectors by names and logicals, too.

Recall the course vector:

``` r
course <- c("STAT", "545A", "S01")
```

Let's give the components some names ("subject", "code", and "section") using three methods:

1.  Using the setNames function.

-   Notice that the vector does not change!!

1.  Using the names function with `<-`. Also, just explore the names function.

2.  Re-constructing the vector, specifying names within `c()`.

Subset the entry labelled "section" and "subject".

Amazingly, we can also subset by a vector of logicals (which will be recycled!). Let's work with our integer sequence vector again:

``` r
(a <- 7:-2)
```

    ##  [1]  7  6  5  4  3  2  1  0 -1 -2

``` r
(n <- length(a))
```

    ## [1] 10

Lists
-----

Unlike vectors, which are atomic/homogeneous, a list in R is heterogeneous.

Try storing the course code (`"STAT"` and `545`) again, but this time in a list. Use the `list()` function.

Lists can hold pretty much anything, and can also be named. Let's use the following list:

``` r
(my_list <- list(year=2018, instructor=c("Vincenzo", "Coia"), fav_fun=typeof))
```

    ## $year
    ## [1] 2018
    ## 
    ## $instructor
    ## [1] "Vincenzo" "Coia"    
    ## 
    ## $fav_fun
    ## function (x) 
    ## .Internal(typeof(x))
    ## <bytecode: 0x0000000018eac0d0>
    ## <environment: namespace:base>

Subsetting a list works similarly to vectors. Try subsetting the first element of `my_list`; try subsettig the first *component* of the list. Notice the difference!

Try also subsetting by name:

Smells a little like `data.frame`s. It turns out a `data.frame` is a special type of list:

``` r
(small_df <- tibble::tibble(x=1:5, y=letters[1:5]))
```

    ## # A tibble: 5 x 2
    ##       x y    
    ##   <int> <chr>
    ## 1     1 a    
    ## 2     2 b    
    ## 3     3 c    
    ## 4     4 d    
    ## 5     5 e

``` r
is.list(small_df)
```

    ## [1] TRUE

``` r
as.list(small_df)
```

    ## $x
    ## [1] 1 2 3 4 5
    ## 
    ## $y
    ## [1] "a" "b" "c" "d" "e"

Note that there's a difference between a list of one object, and that object itself! This is different from vectors.

``` r
identical(list(4), 4)
```

    ## [1] FALSE

``` r
identical(c(4), 4)
```

    ## [1] TRUE

Part II
=======

Global Environment
------------------

When you assign variables in R, the variable name and contents are stored in an R environment called a global environment.

See what's in the Global Environment by:

-   Executing `ls()`.
-   Looking in RStudio, in the "Environments" pane.

Making an assignment "binds" an object to a name within an environment. For example, writing `a <- 5` assigns the object `5` to the name `a` in the global environment.

The act of "searching for the right object to return" is called scoping.

By the way: the global environment is an object, too! It's the output of `globalenv()`, and is also stored in the variable `.GlobalEnv`:

``` r
globalenv()
```

    ## <environment: R_GlobalEnv>

``` r
.GlobalEnv
```

    ## <environment: R_GlobalEnv>

The Search Path
---------------

How does R know what `iris` is, yet `iris` does not appear in the global environment? What about functions like `length`, `sum`, and `print` (which are all objects, too)?

Let's explore.

1.  Each package has its own environment.
    -   Install and load the `pryr` package, and use `ls()` to list its bindings (its name is "package:pryr").
2.  There's a difference between an *environment* and its *name*. Get the environment with name "package:pryr" using the `as.environment()` function.

3.  Each environment has a parent. Use `parent.env()` to find the parent of the global environment.

4.  There are packages that come pre-loaded with R, and they're loaded in a sequence called the search path. Use `search()` to identify that path; then see it in RStudio.

First scoping rule: R looks to the parent environment if it can't find an object where it is.

1.  Use `pryr::where()` to determine where the first binding to the name `iris` is located.

2.  Override `iris` with, say, a numeric. Now `where()` is it? Can you extract the original?

3.  Override `sum` with, say, a numeric. `where()` is `sum` now? Can you still use the original `sum()` function?

Special scoping rule for functions! R knows whether or not to look for a function.

1.  Look at the source code of the `pryr:where()` function. It contains a line that creates a binding for "env". Why, then, is `env` nowhere to be found? Answer: execution environments.

``` r
# pryr::where
```
