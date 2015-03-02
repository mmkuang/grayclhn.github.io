---
title: Preliminary notes on Julia’s macros
layout: blog
author: Gray Calhoun
---

First things first, I’m entirely unqualified to write a review, or
even an email or a tweet, discussing macros in Julia. I don’t know
anything. That said, I’m scheduled to give a 50 minute talk on
Wednesday about macros in Julia, so I need to do some research and
organize my thoughts. And you, dear reader, are reading the result of
that research and the mechanism for organizing my thoughts. So be
skeptical of everything you read here: it’s just my opinion, and my
opinion isn’t especially well-informed. A better resource is [Julia’s
documentation on metaprogramming][0].

## What are macros? How are they different than functions?

Julia’s functions, like functions in most languages, take a collection
of arguments, run some instructions on them, and return a
value. Julia’s macros, on the other hand, take a collection of
expressions, run some transformations on them, and return Julia
code. That new code is run in place of the original macro.

Now, what does that mean? I’ll go back to [my first love in Julia][2],
Dahua Lin’s `@devec` macro. Let `x` and `y` be numeric vectors that
have the same length and suppose that we want to do some simple math
on their elements and store the results in a new vector `r`. Like
this:
{% highlight julia %}
r = exp(-abs(x - y))                      # basic version
{% endhighlight %}

You might disagree, but this is clearly the way we want to write these
operations: our intent is unambiguous. But this isn’t the way we want
the computer to execute these operations. As Dahua points out, it’s
slow and uses more memory than necessary, because each operation is
executed sequentially: first `x-y` is calculated and stored in a
temporary array (call it `temp1`); then `abs(temp1)` is executed and
stored in an array we can call `temp2`; then `-temp2` is executed and
stored in an array `temp3`; and finally `exp(temp3)` is executed and
stored in `r`. Each intermediate step traverses its input, which takes
time, and stores its output in a new array, which takes memory.

Dahua argues that we’d like to run the code

{% highlight julia %}
r = similar(x)                                # version 2
for i = 1:length(x)
    r[i] = exp(-abs(x[i] - y[i]))
end
{% endhighlight %}

which is faster and more memory efficient. The operations still create
temporary variables, but those variables are now scalars and not
vectors, and we only traverse the array once. Potentially noticable
gains.

I’d go even further. The first line of that code frightens me, because
`x` can be a vector of integers but we’d still exect that `r` would be
floats (and, indeed, when you run this code with `x` as an integer, it
fails with an error). Second, `x` and `y` can have different
lengths. The code as written implicitly checks that `x[i]` and `y[i]`
are legitimate indexes, but it does it at each step of the loop. It
would be faster to check before the loop starts, and turn off checking
inside the loop. (There’s another macro, `@inbounds`, that turns it
off.) So I’d prefer to use the code

{% highlight julia %}
@assert length(x) == length(y)                # version 3
firstval = exp(-abs(x[1] - y[1]))
if length(x) > 1
    r = similar(x, typeof(firstval))
    r[1] = firstval
    @inbounds for i = 2:length(x)
        r[i] = exp(-abs(x[i] - y[i]))
    end
else
    r = firstval
end
{% endhighlight %}

This code does the following:

1. Checks that `x` and `y` have the same length.
2. Calculates the first element of `exp(-abs(x - y))` so that we can
   learn its type.
3. If `x` and `y` only have one element, set `r` equal to `firstval` and
   stop. Otherwise, allocate an array for `r`, store `firstval` as its first
   element, and then iterate our calculations down the rest of `x` and
   `y`, assuming that the indexes are valid for each `i`.

Running all three options on my laptop with 80,000,000 elements gives
the timings listed in the table below (I wrapped the code in trivial
functions for the timings; [this Gist has executable code][gist].)

Version |  &nbsp; &nbsp; | Elapsed time (sec) |  &nbsp; &nbsp; | Memory allocated (MB)
-------:|--------|-------------------:|--------|---------------------:
1       |        | 7.21               |        | 2,560
2       |        | 5.03               |        |   640
3       |        | 4.84               |        |   640

We obviously want to run the last version of the code. (The second
version is essentially as efficient, but will throw an error if `x` is
an integer.) But, just as obviously, the last version of the code is
hideous; so much so that I felt like it needed external documentation!
So we clearly want to *write* the first version, but *execute* the
second version.

## Baby steps towards writing a simple devectorization macro

This is my first macro. Fun!

I’ll walk through the steps I took. First, as recommended in Paul
Graham’s [On Lisp][3], we’ll write out a representative call to the
macro and the expression that we actually want evaluated. And let’s
start with a baby version of the expression first:

{% highlight julia %}
@ourdevec r = exp(-abs(x - y))     # representative call
firstval = exp(-abs(x[1] - y[1]))  # baby expression goal
{% endhighlight %}

So now we want to write code that converts the first expression to the
second. Julia expressions are represented as `Expr` objects and they
have a `head` and `args` field. (This is being revisted and eventually
may change, though.) Here, we have
{% highlight julia %}
julia> :(r = exp(-abs(x - y))).head
:(=)                                     # value returned

julia> :(r = exp(-abs(x - y))).args
2-element Array{Any,1}:                  # value returned
 :r
 :(exp(-(abs(x - y))))
{% endhighlight %}

And looking at the type of each of the argumets gives
{% highlight julia %}
julia> map(typeof, :(r = exp(-abs(x - y))).args)
2-element Array{Any,1}:                  # value returned
 Symbol
 Expr
{% endhighlight %}
So the left side is just a `Symbol` (the variable type Julia uses for
variable names) and the right side is another Expr. We could keep on
going sub-expression by sub-expression, but fortunately there are
several functions that present everything at once for us:
{% highlight julia %}
julia> Base.Meta.show_sexpr(:(r = exp(-abs(x - y))))
(:(=), :r, (:call, :exp, (:call, :-, (:call, :abs, (:call, :-, :x, :y)))))
{% endhighlight %}
which tells us that each sub-expression is a function call, until we
finally get to the symbols `:x` and `:y`. It also shows us that the
first element of `args` for a function call is the symbol that
represents the function, and the rest of the elements are the
expressions or symbols passed to that function as arguments.

To produce our baby expression, we want to replace `:x` and `:y` in
our original expression with `:(x[1])` and `:(y[1])`. More generally,
we want to take every symbol that’s not a function, and replace it
with a reference to its first element. (*Important realization*: what
if we want to mix in scalars? Then this might not work! Oh crap! Let’s
disregard that problem for now and worry about it tomorrow. This post
is hard enough as it is.)

This replacement is something we can do pretty easily with recursion,
since `:(x[1])` is just another type of expression (a `:ref`). We’ll
define two functions that help:

{% highlight julia %}
getindex(s::Symbol, i) = Expr(:ref, s, i)
getindex(e::Expr, i) = Expr(e.head, e.args[1],
              [getindex(a, i) for a in e.args[2:end]]...)
{% endhighlight %}
so

+ `getindex(:x, 1)` returns `:(x[1])`
+ `getindex(:(x - y), 1)` calls both `getindex(:x, 1)` and
  `getindex(:y, 1)`; takes the result; and puts them together in the
  original expression.

`getindex` already exists and is the function that’s called when you
write `x[i]` for arrays, so it seems reasonable to extend its methods
like this.

The baby macro is dead simple now
{% highlight julia %}
macro our_devec_p1(e)                # Ver 1 (baby macro)
    :($(e.args[1]) = $(getindex(e.args[2], 1)))
end
{% endhighlight %}

and we can verify that it “does the right thing” by using `macroexpand`.

{% highlight julia %}
julia> macroexpand(:(@our_devec_p1 r = exp(-abs(x - y))))
:(_38_firstval = exp(-(abs(x[1] - y[1]))))  # Value returned
{% endhighlight %}

A note on what happened to `firstval`: since macros write out code
that’s executed in-place, there’s a chance that it could clobber
variables that already exist. Macros, unlike functions, don’t define
their own scope. To avoid overwriting existing variables, variables in
macros are given unique names. (The function that does this is
`gensym`.) The `_38_` represents the unique identifier added to
`firstval` to make it unique. (The `_` really displays as `#` and
screws up our code highlighting; I've manually replaced the symbol.)

## Two more tiny steps towards a devectorization macro

If we look back at the expanded code, we can see three distinct parts:

1. Evaluate the vectorized expression for the first element. We’ve
   already done this part.
2. Check that the vectors have the same length, and check that `x`
   has more than one element.
3. Loop over the elements of `x` and `y` and assign the results of
   each calculation to `r`.

This parallels our initial description, but now we’re going to
implement the second and third parts in the macro.

First add the length check. Setting up the problem just like we did
for the baby macro earlier, we start with the expression
{% highlight julia %}
r = exp(-abs(x - y))
{% endhighlight %}
and we need to produce
{% highlight julia %}
length(x) == length(y)
{% endhighlight %}

We can write similar functions as before (which is a sign that we
might want to think about generalizing this as utility code, but
nevermind that for now...)

{% highlight julia %}
getvecs(s::Symbol) = s
getvecs(e::Expr) = [[getvecs(a) for a in e.args[2:end]]...]
{% endhighlight %}

which will recurse down a nested expression until it finds the symbols
at the bottom, then return a single array that lists them
all. (Putting `...` at the end of the `Expr` method flattens the
results.)

It’s clumsy, but we can assemble the expression we need by hand, as
the next macro shows.
{% highlight julia %}
macro our_devec_p2(e)
  vecs = getvecs(e.args[2])
  check_lengths = Expr(:comparison)
  check_lengths.args = Array(Any, 2 * length(vecs) - 1)
  check_lengths.args[1:2:end] = map(s -> Expr(:call, :length, s), vecs)
  check_lengths.args[2:2:end] = :(==)
  :($check_lengths)
end
{% endhighlight %}
(I’m sure that there’s a slick, functional way to assemble the
`check_lengths` expression, but I don’t know it.) Using `macroexpand`
to verify that we’re on the right track gives

{% highlight julia %}
julia> macroexpand(:(@our_devec_p2 r = exp(-abs(x - y))))
:(length(x) == length(y))                # value returned
{% endhighlight %}

And now the loop. Again, the expression we start with is
{% highlight julia %}
r = exp(-abs(x - y))
{% endhighlight %}
and now the expression we want to return is
{% highlight julia %}
if length(x) > 1
    r = similar(x, typeof(firstval))
    r[1] = firstval
    for i = 2:length(x)
        r[i] = exp(-abs(x[i] - y[i]))
    end
end ### Ignore the `else` part for now
{% endhighlight %}

The body of the loop is *almost* what we did before when we calculated
the first element, but now we don’t want `gensym` to create a new
variable name, we want to clobber `r`. Julia, forntunately, offers a
mechansim for “unhygenic” macros through the function, `esc`, which
works as follows

{% highlight julia %}
macro our_devec_part3(e)
    vecs = getvecs(e.args[2])
    quote
        if length($(vecs[1])) > 1
            $(esc(e.args[1])) = similar($(vecs[1]), typeof(firstval))
            $(esc(e.args[1]))[1] = firstval
            for i = 2:length($(vecs[1]))
                $(esc(e.args[1]))[i] = $(getindex(e.args[2], :i))
            end
        end
    end
end
{% endhighlight %}

You should expand this part on your own to verify that it works. (It
does, though.)

## Finishing the macro

We can put the three steps together for our final devectorization
macro:

{% highlight julia %}
macro our_devec(e)                        # Final version
    vecs = getvecs(e.args[2])

    check_lengths = Expr(:comparison)            # Part 2
    check_lengths.args = Array(Any, 2 * length(vecs) - 1)
    check_lengths.args[1:2:end] = map(s -> Expr(:call, :length, s), vecs)
    check_lengths.args[2:2:end] = :(==)

    quote
        @assert $check_lengths
        firstval = $(getindex(e.args[2], 1))     # Part 1
        if length($(vecs[1])) > 1                # Part 3
            $(esc(e.args[1])) = similar($(vecs[1]), typeof(firstval))
            $(esc(e.args[1]))[1] = firstval
            @inbounds for i = 2:length($(vecs[1]))
                $(esc(e.args[1]))[i] = $(getindex(e.args[2], :i))
            end
        else
            $(esc(e.args[1])) = firstval   # new but easy
        end
    end
end
{% endhighlight %}
And one final expansion to verify that it does what we’d hoped:
{% highlight julia %}
julia> macroexpand(:(@our_devec r = exp(-abs(x - y))))
quote  # none, line 10:
    if length(x) == length(y)
        nothing
    else
        Base.error("assertion failed: length(x) == length(y)")
    end # line 11:
    _51_firstval = exp(-(abs(x[1] - y[1]))) # line 12:
    if length(x) > 1 # line 13:
        r = similar(x,typeof(_51_firstval)) # line 14:
        r[1] = _51_firstval # line 15:
        begin
            $(Expr(:boundscheck, false))
            begin
                for _52_i = 2:length(x) # line 16:
                    r[_52_i] = exp(-(abs(x[_52_i] - y[_52_i])))
                end
                $(Expr(:boundscheck, :(Base.pop)))
            end
        end
    else  # line 19:
        r = _51_firstval
    end
end
{% endhighlight %}
(I was happily surprised that the index of the for loop is taken care
of automatically.)

So now the code
{% highlight julia %}
@our_devec r = exp(-abs(x - y))
{% endhighlight %}

runs as fast and with the same memory allocation as the explicitly
devectorized code from before. You can download all of the code for
this post [here][gist]. (Obvious caveats are that the code is probably
pretty fragile and you’d probably need to make it more robust if you
use it for real.)

## Are macros just about performance?

The devectorize macro we defined is representative of a class of
macros: it takes Julia code that would run fine otherwise, and it
rewrites the code to use the computer more efficiently. (The Julia
manual calls these “[Performance Annotations][4]”). Some other macros
like this are

* `@inbounds`, which we’ve seen already
* `@parallel`, which can split loops across multiple processors to be
  run in parallel
* `@devec` (the real version) which does more general devectorization.
* `@simd`, which enables [some sort of CPU-level devectorization that
  I don’t understand][5] but looks impressive

I’m sure there are a few others, but these are, as far as I can tell,
unrepresentative. Most macros are not written just to translate blocks
of Julia code into blocks of faster Julia code.  Dahua’s blog post was
the first thing I read that got me really excited about Julia, though,
so if I’m going to talk about macros....  But the main use of macros,
at least historically (and “historically” here means “in Lisp, as far
as I can tell.” Julia’s not old enough for any usage to be “historic”)
is extending the language by adding new features.

First, a small example of language extensions. Perl, if you haven’t
used it, is a programming language that excels at text
manipulation. It does other things well too, and it was probably as
important to web programming during the dot-com bubble as JavaScript
has been for the whole Ajax/Web 2.0 [bubble]. One of the reasons why
Perl is great at text manipulations is because it has *excellent*
[Regular Expressions][6] (“regexes”), giving it an entire
mini-language for finding and replacing patterns in strings.

Perl’s regexes are built into the language—large parts of the
language are built around them—so they’re fast and immediately
available. Julia has regexes as well, but they’re implemented as a
macro. (My understanding is that this is how Common Lisp implements
them as well.) Since these macro calls are translated before any code
is actually run, the regex is parsed once, in advance, and they’re
fast too.

So both languages have fast regexes. But the implementation methods
are very different and the difference matters when you or I want to
add a feature like regexes to the language; say (hypothetically) a
regression modeling language like R’s, or a different text-processing
minilanguage. With Perl, new features will never have the same
performance or support that the built-in features do. With Julia, your
macros are on equal footing with the native ones, so these new
features have exactly the same support and potential for performance
as the “built in” regex.

For flashier examples, there are at least two packages that support
pattern matching through the macro system. ([Match.jl][] and
[PatternDispatch.jl][]; you’ll have to look at the packages to really
understand what they enable, but these are like powerful switch
statements.) And support for DocStrings is (finally) being added to
Base Julia, as a macro that was originally developed in a separate
package ([Docile.jl][].)

## Alternatives to macros

Another question: could we have written `@our_devec` as a function?
Can we write macros as functions in general? Julia functions can take
expressions as arguments and can return unevaluated expressions, and
Julia provides an `eval` function that evaluates expressions on the
fly. Specifically, would
{% highlight julia %}
eval(our_devec(:(r = exp(-abs(x - y)))))
{% endhighlight %}
do the same thing as
{% highlight julia %}
@our_devec r = exp(-abs(x - y))
{% endhighlight %}

As implemented in Julia, the answer is clearly “no.” `eval` has weird
scoping issues: it evaluates expressions in the global scope, so if
it’s called inside a function it wouldn’t have access to `x` and
`y`. (I’ve read several places that this is for performance.)

But, even if it’s not the way Julia implements it, we can certainly
imagine a “local eval” function. And we can certainly imagine people
who don’t care about performance. So, without those constraints, do
macros provide anything that we can’t get from evaluating expressions
returned from functions?

I don’t think so, but I could be wrong. One reason is an *R-News*
article by Thomas Lumley (2001), “[Overcoming R’s Virtues][7],” that
describes how to implement Lisp-style macros through R’s
functions. (Unlike Julia, R lets functions evaluate expressions in
essentially *whatever environment you want*.) So, from a conceptual
standpoint, macros are just one mechanism for transforming expressions
and choosing where to evaluate them, and there are potentially many
other conceptually equivalent ways to do that.

“Conceptual equivalence” and “practical equivalence” are very
different things, of course. The hypothetical `eval` version of macro
execution would have to parse the expression on the fly each time it’s
called, which we’d expect would give it a performance penalty compared
to a “native” implementation and is going to make them less appealing
in real applications. One of the driving principles in Julia’s
development has been the idea that user-added functionality should be
just as good as built-in functionality. This was part of the reason
that Julia’s numeric types are implemented in Julia, and not as
specialized C code, and it’s part of the reason that macros are used
to implement fundamental objects like regexes: putting them on equal
footing forces the language to support all of these extensions really
well.

And obviously, performance-oriented macros like `@our_devec` are off
the table without a real macro system.

## Other things to read

* [Julia’s metaprogramming documentation][0] (it’s unfortunately
  sparse.)

* [JuMP.jl][] and [DataFramesMeta.jl][] heavily use macros and are
  probably going to be interesting to people who have read this far.

* Given Lisp’s clear influence on Julia’s macro system, it’s probably
  worth reading the [special volume on Lisp-Stat of the *Journal of
  Statistical Software*][1], but it unfortunately does not say
  anything about macros.

* [Paul Graham’s *On Lisp*][3] is widely recommended and also
  free. I’ve only read the first chapter on macros so far.

* Here are links to the
  [slides]({{ site.url }}/dl/macros_etc.pdf),
  [julia code]({{ site.url }}/dl/macros_etc.jl), and
  their [source code](https://github.com/heike/stat590f/tree/master/macros)
  from the talk itself (given on 10/22)

* I've started a short file with some basic macros and utility
  functions on GitHub: <https://gist.github.com/grayclhn/5e70f5f61d91606ddd93>

[0]: http://julia.readthedocs.org/en/latest/manual/metaprogramming/
[1]: http://www.jstatsoft.org/v13
[2]: http://julialang.org/blog/2013/09/fast-numeric
[3]: http://www.paulgraham.com/onlisp.html
[4]: http://julia.readthedocs.org/en/latest/manual/performance-tips/#performance-annotations
[5]: https://software.intel.com/en-us/articles/vectorization-in-julia
[6]: http://en.wikipedia.org/wiki/Regular_expression
[7]: http://www.r-project.org/doc/Rnews/Rnews_2001-3.pdf#section*.31

[JuMP.jl]: https://github.com/JuliaOpt/JuMP.jl
[DataFramesMeta.jl]: https://github.com/JuliaStats/DataFramesMeta.jl
[gist]: https://gist.github.com/grayclhn/2e43a628e67c007446e0
[Match.jl]: https://matchjl.readthedocs.org/en/latest/
[PatternDispatch.jl]: https://github.com/toivoh/PatternDispatch.jl
[Docile.jl]: https://github.com/MichaelHatherly/Docile.jl
