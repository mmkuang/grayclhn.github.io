---
layout: blog
title: Literate-style argument checking in R
author: Gray Calhoun
---

[lp]: http://en.wikipedia.org/wiki/Literate_programming
[dk]: http://www-cs-faculty.stanford.edu/~knuth/‎
[noweb]: http://www.cs.tufts.edu/~nr/noweb/
[Sweave]: http://en.wikipedia.org/wiki/Sweave
[Knitr]: http://yihui.name/knitr/
[Raincheck]: https://github.com/grayclhn/raincheck
[advr]: http://adv-r.had.co.nz

I've played around with [Literate Programming][lp] since early in grad
school. Literate Programming was developed by [Don Knuth][dk] (who
also developed TeX and was generally a hugely influential computer
scientist) and is grounded in the idea of embedding a computer program
inside its documentation, rather than the other way around. A lot of
people mistakenly believe that the point of this is to have nicely
formatted documentation (there are pretty-printers, etc.) but the big
advantage is that LP tools let you arrange your program in logical
order, and the tools will reassemble it in the correct order for you.
Norman Ramsey's [noweb][] program is an example of this.

Anyway, Literate Programming hasn't caught on and I don't do it
anymore. (Tools for Reproducible Research, like [Sweave][] and
[Knitr][], generally don't allow you to write the code in arbitrary
order, so they're close but don't count.) For one thing, the tools are
too specific to a particular workflow, which makes collaborating
difficult. But another reason is that a lot of the benefits are
available without using dedicated Literate Programming tools. R
packages, for example, let you organize code logically and will get
the order "correct" when it's time to call them.

But one thing I miss is the construction (using R and Noweb's syntax):

    myfunction <- function(argument) {
      <<extensive error checking of arguments>>
      # Code that does the analysis goes here
      # ...
    }

    <<extensive error checking of arguments>>=
      # Make sure that the arguments make sense, and reformat
      # them if necessary. 
      # For example:
      argument <- as.data.frame(argument)
    @

and then call

    myfunction(xargument)

where (if you're not familiar with LP syntax), the code between
`<<extensive error checking of arguments>>=` and `@` will be written
into the appropriate part of `myfunction` before the code is executed.
In my experience, separating this code visually makes it easier to
understand the logic in `myfunction` and encourages me to write more
error checking, since it won't pollute the main function.  (I've read
this in a Knuth interview too, but I can't find the source right now.)

But R is flexible, and we can mimic that structure by abusing
environments. So I've written some code to do that. Using that code,
we can write

    myfunction <- function(argument) {
      ExtensiveChecking()
      # Code that does the analysis goes here
      # ...
    }

    ExtensiveChecking <- raincheck({
      # Make sure that the arguments make sense, and reformat
      # them if necessary. 
      # For example:
      argument <- as.data.frame(argument)
    })

and call

    myfunction(xargument)

where the line `argument <- as.data.frame(argument)` executes inside
`myfunction`.  `raincheck` is obviously a cute name to construct these
sort of functions.

The code for `raincheck` is surprisingly simple:

    raincheck <- function(expr) {
      e <- substitute(expr)
      function(env = parent.frame()) {
        eval(e, env)
        invisible(TRUE)
      }
    }

`raincheck` returns a function that is intended to be called inside
another function.  `expr` is a block of unevaluated R code that will
be executed inside that other function. (The line
`env = parent.frame()` means that the R code will be executed in the
calling environment by default, but that can be overridden by
supplying another environment as an argument.)

I've made the `raincheck` function into a minimal R package that's
available on GitHub, [Raincheck][]. The package also has a `scold`
function that can be used to issue warnings and errors that appear to
come from the top function, e.g. if we had written

    ExtensiveChecking <- raincheck({
      # Make sure that the arguments make sense, and reformat
      # them if necessary. 
      # For example:
      argument <- as.data.frame(argument)
      scold("<error message>")
    })
    myfunction(xargument)

we would get

    Warning message:
    In myfunction(xargument) : <error message>

instead of

    Warning message:
    In eval(expr, envir, enclos) : <error message>

if we had used `warning("<error message>")`, which makes the messages
more informative to end users — `eval(expr, envir, enclos)` could be
anywhere. The `scold` function uses information from Hadley's (2013)
book, [*Advanced R Programming*][advr], especially the chapter on
[exceptions and
debugging](http://adv-r.had.co.nz/Exceptions-Debugging.html).

Obviously this was more of an educational exercise than anything else,
but I will start using the package and see if it's useful. Let me know
if you have any suggestions.