---
layout: blog
title: More on numerical instability in Incanter
---

I wrote an earlier [post on Incanter][1] that drew a response from an
Incanter user (who wants to stay anonymous, or I'd just quote the
email).  In short, the email pointed out that, if you know how Clojure
handles dependencies and libraries, it's not hard to verify that
Incanter's solve uses [LAPACK's DGESV][2] from JBLAS to invert the
*X'X* matrix using an LU factorization, which is the exact same
algorithm as [R's solve][3], so my suspicion there was misplaced.
Great!

[1]: /blog/2013/04/10/clojure
[2]: http://www.netlib.org/lapack/explore-html/d7/d3b/group__double_g_esolve.html#ga5ee879032a8365897c3ba91e3dc8d512
[3]: http://stat.ethz.ch/R-manual/R-devel/library/base/html/solve.html

Obviously my first reaction to the email was astonishment that
anyone's read my blog.  But I think my original point still stands.
Looking for a variable named `xtxi` used to estimate OLS is a quick
and dirty way to evaluate a statistics package, because inverting the
$X'X$ matrix is numerically unsound compared to other methods of
estimating OLS—R, for example, does not use solve for OLS, [it uses
the QR decomposition][3b].

[3b]: http://stat.ethz.ch/R-manual/R-patched/library/stats/html/lm.html

Here's some R code where the difference matters (I don't know Clojure,
but this uses the same algorithms).  This isn't quite linear
regression, it's a comparison of different methods for constructing
projection matrices, $P = X (X'X)^{-1} X'$ (so it's basically identical
to linear regression).  Here are three different methods:

    projection.LU1 <- function(x) x %*% solve(crossprod(x)) %*% t(x)

    projection.LU2 <- function(x) crossprod(t(x), solve(crossprod(x), t(x)))

    projection.QR <- function(x) {
      QR <- qr(x)
      tcrossprod(qr.Q(QR)[, QR$pivot[seq_len(QR$rank)], drop = FALSE])
    }

The first inverts $X'X$ using the same algorithm in Incanter; the
second uses a slightly better version but is basically the same, and
the third uses the QR decomposition, just like R.

From the mathematical definition, we can see that $P= PP$, a property
called idempotence, which is an easy property to verify numerically.
Here's a set of 51 observations for 11 regressors (each column is $z$
raised to the $p$th power for $p = 0, 1, 2,...,10$ and $z$ between
zero and one).

    X <- outer(seq(0, 1, 0.02), 0:10, "^")

And now we can "verify" idempotence (up to numerical tolerance)

    > all.equal(projection.LU1(X), projection.LU1(X) %*% projection.LU1(X))
    [1] "Mean relative difference: 0.0002737938"

    > all.equal(projection.LU2(X), projection.LU2(X) %*% projection.LU2(X))
    [1] "Mean relative difference: 0.0001990939"

    > all.equal(projection.QR(X), projection.QR(X) %*% projection.QR(X))
    [1] TRUE

All of the code is available for download here:
<https://gist.github.com/grayclhn/5717763>

You can see (and verify it for yourself by downloading the code) that
the first two methods of calculating $P$, which invert $X'X$ using the
LU factorization *just like Incanter*, are not idempotent.  The third
method, which uses the QR decomposition *just like R*, is idempotent.
So in this example, the QR decomposition works and the LU
factorization doesn't.

This example is obviously contrived, but it's not isolated.  Chapter
11 of [Seber and Lee's (2003) *Linear Regression Analysis*][5] shows
the same thing: that if the regressors are "badly" distributed, the QR
decomposition is more reliable.  (In the interest of full disclosure,
I should admit, embarrassing as it is, that chapter 11 of Seber and
Lee, along with the paper "[What every computer scientist should know
about floating point arithmetic][6]," is all I know about these
issues, so I'm not claiming a lot of expertise).

[5]: http://www.worldcat.org/title/linear-regression-analysis/oclc/300231427
[6]: http://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html

As one last point, let me preempt anyone who might respond, "yes,
these issues matter in those particular examples, but that will never
come up in real research."  Try to guess why I look to see how a stats
package calculates the linear regression coefficients, and why I have
this particular criterion that I care about instead of any other, and
why....

It's obvious, right?  This is something I've personally screwed up
before.  An early version of my job-market paper had fantastic
empirical results that turned out to be entirely an artifact of using
$(X'X)^{-1}$ to calculate the F-test statistic instead of using the QR
decomposition and the "projection.QR" function in the code example is
copied directly from that project (a later version).  I was lucky and
paranoid enough to catch it before circulating the paper but the event
definitely left an emotional impression.